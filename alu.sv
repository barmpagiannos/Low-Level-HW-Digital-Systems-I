module alu (output reg [31:0] result,
            output reg zero,
    		input wire [31:0] op1,
    		input wire [31:0] op2,
    		input wire [3:0] alu_op);

    // Ορίζουμε τις σταθερές για τις πράξεις.
  parameter [3:0] ALU_AND = 4'b0000,
                  ALU_OR = 4'b0001,
                  ALU_ADD = 4'b0010,
                  ALU_SUB = 4'b0110,
                  ALU_LESS = 4'b0100,
                  ALU_SHIFTR = 4'b1000,
                  ALU_SHIFTL = 4'b1001,
                  ALU_ARITHMR = 4'b1100,
                  ALU_XOR = 4'b0101;

  // Πολυπλέκτης (εντολή case) για επιλογή της πράξης.
  always @(*) 
    begin
      case (alu_op) // Ανάλογα την τιμή του alu_op γίνεται και 
        			// η αντίστοιχη πράξη.
        ALU_AND: result = op1 & op2;
        ALU_OR:  result = op1 | op2;
		ALU_ADD: result = op1 + op2;
		ALU_SUB: result = op1 - op2;
		ALU_LESS:  result = (op1 < op2) ? 32'b1 : 32'b0;
		ALU_SHIFTR: result = op1 >> op2[4:0];
		ALU_SHIFTL: result = op1 << op2[4:0];
		ALU_ARITHMR: result = op1 >>> op2[4:0];
		ALU_XOR: result = op1 ^ op2;
        default: result = 32'b0;
      endcase
    end

    // Υπολογισμός του zero.
  always @(*) 
    begin // Όταν το result είναι 0, το zero είναι λογικό 1.
      zero = (result == 32'b0) ? 1'b1 : 1'b0;
    end
endmodule
