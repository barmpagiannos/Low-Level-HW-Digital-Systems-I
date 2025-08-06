module calc_enc (output wire [3:0] alu_op, // Έξοδος alu_op.
                 input wire btnl, btnr, btnc); // Είσοδοι πλήκτρων.

  // Υπολογισμός του alu_op[0].
  wire and1_0, and2_0;
  assign and1_0 = ~btnc & btnr;
  assign and2_0 = btnl & btnr;
  assign alu_op[0] = and1_0 | and2_0;

  // Υπολογισμός του alu_op[1].
  wire and1_1, and2_1;
  assign and1_1 = ~btnl & btnc;
  assign and2_1 = btnc & ~btnr;
  assign alu_op[1] = and1_1 | and2_1;

  // Υπολογισμός του alu_op[2].
  wire and1_2, and2_2, and3_2;
  assign and1_2 = btnc & btnr;
  assign and2_2 = btnl & ~btnc
  assign and3_2 = and2_2 & ~btnr
  assign alu_op[2] = and1_2 | and2_3;

  // Υπολογισμός του alu_op[3].
  wire and1_3, and2_3, and3_3, and4_3;
  assign and1_3 = btnl & ~btnc;
  assign and2_3 = and1_3 & btnr;
  assign and3_3 = btnl & btnc
  assign and4_3 = and3_3 & ~btnr
  assign alu_op[3] = and2_3 & and4_3;

endmodule
