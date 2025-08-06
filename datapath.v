// Code your design here
`timescale 1ns/1ps
module datapath #(parameter [31:0] INITIAL_PC = 32'h00400000)
(
  	output reg [31:0] PC, // Program Counter.
    output wire Zero, // Ένδειξη μηδενισμού ALU.
  	output wire [31:0] dAddress, // Διεύθυνση για δεδομένα μνήμης.
  	output wire [31:0] dWriteData, // Δεδομένα προς εγγραφή στη μνήμη δεδομένων.
  	output wire [31:0] WriteBackData, // WriteBack δεδομένα στους καταχωρητές.
    input wire clk, // Ρολόι.
    input wire rst, // Σύγχρονο Reset.
  	input wire [31:0] instr, // Δεδομένα εντολών από τη μνήμη εντολών
    input wire PCSrc, // Πηγή του PC.
    input wire ALUSrc, // Πηγή του 2ου τελεστή της ALU.
    input wire RegWrite, // Εγγραφή δεδομένων στους καταχωρητές.
 	input wire MemToReg, // Πολυπλέκτης εισόδου στους καταχωρητές.
  	input wire [3:0] ALUCtrl, // Εντολή για την ALU.
  	input wire loadPC, // Ενημέρωση του PC με νέα τιμή.
  	input wire [31:0] dReadData); // Δεδομένα από τη μνήμη δεδομένων.

    // Αποκωδικοποίηση των bits της εντολής.
    wire [6:0] opcode = instr[6:0];
    wire [4:0] rd = instr[11:7];
    wire [2:0] funct3 = instr[14:12];
    wire [4:0] rs1 = instr[19:15];
    wire [4:0] rs2 = instr[24:20];
    wire [6:0] funct7 = instr[31:25];

    // Immediate Generation με βάση την 148 σελίδα του pdf.
    reg [31:0] imm;
    always @(*) begin
        case (opcode)
            7'b0010011, 7'b0000011, 7'b1100111: // I-type (ADDI, LW, JALR)
                imm = {{20{instr[31]}}, instr[31:20]};
            7'b0100011: // S-type (SW, SH, SB)
                imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            7'b1100011: // B-type (BEQ, BNE, etc.)
                imm = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            7'b0110111, 7'b0010111: // U-type (LUI, AUIPC)
                imm = {instr[31:12], 12'b0};
            7'b1101111: // J-type (JAL)
                imm = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
            default:
                imm = 32'b0;
        endcase
    end

    // Σύνδεση με το submodule regfile.
    wire [31:0] readData1, readData2;
    regfile #(32, 32) regfile_inst (
      .readData1(readData1),
      .readData2(readData2),
      .clk(clk),
      .readReg1(rs1),
      .readReg2(rs2),
      .writeReg(rd),
      .writeData(WriteBackData),
      .write(RegWrite)
    );

  // Είσοδος op2 της alu.
  wire [31:0] alu_op2 = ALUSrc ? imm : readData2;
  
  // Σύνδεση με το submodule alu.
  wire [31:0] aluResult;
  alu alu_inst (
    .result(aluResult),
    .zero(Zero),
    .op1(readData1),
    .op2(alu_op2),
    .alu_op(ALUCtrl)
  );

  // Data Memory.
  assign dAddress = aluResult;
  assign dWriteData = readData2;

  // Write Back.
  assign WriteBackData = MemToReg ? dReadData : aluResult;

  // Program Counter.
  always @(posedge clk)
    begin
      if(rst) // Σύγχρονο Reset. 
        PC <= INITIAL_PC;
      else if(loadPC) // Ενημέρωση του PC με νέα τιμή (στην επόμενη ακμή του ρολογιού).
        PC <= PCSrc ? (PC + (imm << 1)) : PC + 4; // Λογική branch target ανάλογα την τιμή του PCSrc.
    end
  
endmodule

