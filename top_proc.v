// Code your design here
module top_proc #(parameter [31:0] INITIAL_PC = 32'h00400000)
  (
    output reg [31:0] PC, // Program Counter.
	output wire [31:0] dAddress, // Διεύθυνση για δεδομένα μνήμης.
  	output wire [31:0] dWriteData, // Δεδομένα προς εγγραφή στη μνήμη δεδομένων.
    output wire MemRead; // Σήμα ελέγχου που υποδεικνύει ανάγνωση μνήμης.
    output wire MemWrite; // Σήμα ελέγχου που υποδεικνύει εγγραφή στη μνήμη.
    output wire [31:0] // Δεδομένα που εγγράφονται σε καταχωρητές (για αποσφαλμάτωση).
    input wire clk, // Ρολόι.
    input wire rst, // Σύγχρονο Reset.
    input wire [31:0] instr, // Δεδομένα εντολών από τη μνήμη εντολών.
    input wire [31:0] dReadData); // Ανάγνωση δεδομένων από τη μνήμη δεδομένων.
  
  // Datapath.
  datapath #(
    .INITIAL_PC(INITIAL_PC) // Κατάλληλη αρχικοποίηση εντός module.
  ) datapath_inst(
    .PC(PC),
    .instr(instr),
    .dAddress(dAddress),
    .dReadData(dReadData),
    .dWriteData(dWriteData)
  )
  
  // FSM: έχει 5 καταστάσεις άρα 3 bit αρκούν.
  always @(posedge clk)
    begin
      case
        
    end
  
  // Παραγωγή σήματος ALUCtrl.
  wire [3:0] ALUCtrl;
  
  
  
endmodule
