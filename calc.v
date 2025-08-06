`timescale 1ns/1ps

module calc (output wire [15:0] led, // LED για την έξοδο του συσσωρευτή.
             input wire clk, // Ρολόι
             input wire btnc, // Κεντρικό πλήκτρο.
             input wire btnl, // Αριστερό πλήκτρο.
             input wire btnu, // Πάνω πλήκτρο.
             input wire btnr, // Δεξιό πλήκτρο.
             input wire btnd, // Κάτω πλήκτρο.
             input wire [15:0] sw); // Διακόπτες για την εισαγωγή δεδομένων.

  reg [15:0] accumulator; // Καταχωρητής 16 bit.
  wire [3:0] alu_op; // Επιλογή πράξης alu.
  wire [31:0] alu_result; // Το αποτέλεσμα της alu.
  
  wire [31:0] op1_extended, op2_extended;
  
  // Επέκταση προσήμου.
  assign op1_extended = {{16{accumulator[15]}}, accumulator};
  assign op2_extended = {{16{sw[15]}}, sw};

  // Σύνδεση του calc_enc.
  calc_enc encoder(.btnl(btnl), .btnr(btnr), .btnc(btnc), .alu_op(alu_op));
  
  // Σύνδεση της alu.
  alu alu(.op1(op1_extended), .op2(op2_extended), .alu_op(alu_op), .result(alu_result));

  // Λειτουργία του accumulator.
  always @(posedge clk) // Συνδέεται με την είσοδο του ρολογιού.
    begin
      if (btnu) // Μηδενίζεται σύγχρονα με το πάτημα του btnu.
        accumulator <= 16'b0;
      else if (btnd) // Ενημερώνεται σύγχρονα με το πάτημα του btnd.
        accumulator <= alu_result[15:0]; // Τα 16 χαμηλότερα bits του alu_result.
    end
  
  // Αντιγραφή του accumulator στην έξοδο LED.
  assign led = accumulator;

endmodule
