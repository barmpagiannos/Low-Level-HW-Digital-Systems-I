// Code your design here
module regfile #(parameter DATAWIDTH = 32, // Πλάτος δεδομένων.
                 parameter COUNT = 32) // Πλήθος καταχωρητών.
 
  (output reg [DATAWIDTH-1:0] readData1, // Δεδομένα ανάγνωσης από τη θύρα 1.
   output reg [DATAWIDTH-1:0] readData2, // Δεδομένα ανάγνωσης από τη θύρα 2.
   input wire clk, // Ρολόι.
   input wire [4:0] readReg1, // Διεύθυνση για τη θύρα ανάγνωσης 1.
   input wire [4:0] readReg2, // Διεύθυνση για τη θύρα ανάγνωσης 2.
   input wire [4:0] writeReg, // Διεύθυνση για θύρα εγγραφής.
   input wire [DATAWIDTH-1:0] writeData, // Δεδομένα προς εγγραφή.
   input wire write); // Σήμα ελέγχου που υποδεικνύει εγγραφή.
  
  reg[DATAWIDTH-1:0] registers [0:COUNT-1]; // 32x32 αρχείο καταχωρητών,
  					    // 32 καταχωρητές των 32 bit.
  
  // Αρχικοποιώ τους καταχωρητές με μηδενικά.
  initial
    begin
      for(integer i = 0; i <= 31; i=i+1)
        registers[i] = {DATAWIDTH{1'b0}}; // Επαναλαμβάνω 32 φορές το bit 0.
    end
  
  always @(posedge clk)
    begin
      if(write) // Εγγραφή δεδομένων όταν write=1.
        begin
          // Γράφω τα δεδομένα writeData στη διεύθυνση writeReg.
          registers[writeReg] <= writeData;
        end
    end
  
  // Διαβάζω τα δεδομένα από τη θύρα readReg1.
  assign readData1 = registers[readReg1];
  // Διαβάζω τα δεδομένα από τη θύρα readReg2.
  assign readData2 = registers[readReg2];
  
endmodule