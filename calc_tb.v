`timescale 1ns/1ps

module calc_tb;

    // Είσοδοι
    reg clk;
    reg btnc, btnl, btnu, btnr, btnd;
    reg [15:0] sw;

    // Έξοδος
    wire [15:0] led;

    // Σύνδεση με το DUT (Device Under Test)
    calc dut (
        .clk(clk),
        .btnc(btnc),
        .btnl(btnl),
        .btnu(btnu),
        .btnr(btnr),
        .btnd(btnd),
        .sw(sw),
        .led(led)
    );

    // Ρολόι
    always #5 clk = ~clk; // Περίοδος 10ns (100 MHz)

    initial begin
        $dumpfile("calc_tb.vcd"); // Αρχείο waveforms
        $dumpvars(0, calc_tb);    // Παρακολούθηση μεταβλητών

        // Αρχικοποίηση
        clk = 0;
        btnc = 0; btnl = 0; btnu = 0; btnr = 0; btnd = 0; 
        sw = 16'h0000;
        #10;

        // Reset του accumulator
        btnu = 1; #10;
        btnu = 0; #10;
        $display("Reset: led = %h (αναμενόμενο: 0x0)", led);

        // Test 1: ADD (acc = 0x0 + sw = 0x354a)
        sw = 16'h354a; btnl = 0; btnc = 1; btnr = 0; btnd = 1;
        #10; btnd = 0; #10;
        $display("Test 1 (ADD): led = %h (αναμενόμενο: 354a)", led);

        // Test 2: SUB (acc = 0x354a - sw = 0x1234)
        sw = 16'h1234; btnl = 1; btnc = 1; btnr = 0; btnd = 1;
        #10; btnd = 0; #10;
        $display("Test 2 (SUB): led = %h (αναμενόμενο: 2316)", led);

        // Test 3: OR (acc = 0x2316 | sw = 0x1001)
        sw = 16'h1001; btnl = 0; btnc = 0; btnr = 1; btnd = 1;
        #10; btnd = 0; #10;
        $display("Test 3 (OR): led = %h (αναμενόμενο: 3317)", led);

        // Test 4: AND (acc = 0x3317 & sw = 0x0f0f)
        sw = 16'h0f0f; btnl = 0; btnc = 0; btnr = 0; btnd = 1;
        #10; btnd = 0; #10;
        $display("Test 4 (AND): led = %h (αναμενόμενο: 3010)", led);

        // Test 5: XOR (acc = 0x3010 ^ sw = 0x1fa2)
        sw = 16'h1fa2; btnl = 1; btnc = 1; btnr = 1; btnd = 1;
        #10; btnd = 0; #10;
        $display("Test 5 (XOR): led = %h (αναμενόμενο: 2fb2)", led);

        // Test 6: ADD (acc = 0x2fb2 + sw = 0x6aa2)
        sw = 16'h6aa2; btnl = 0; btnc = 1; btnr = 0; btnd = 1;
        #10; btnd = 0; #10;
        $display("Test 6 (ADD): led = %h (αναμενόμενο: 9a54)", led);

        // Test 7: Logical Shift Left (acc = 0x9a54 << 0x0004)
        sw = 16'h0004; btnl = 1; btnc = 0; btnr = 0; btnd = 1;
        #10; btnd = 0; #10;
        $display("Test 7 (Logical Shift Left): led = %h (αναμενόμενο: a540)", led);

        // Test 8: Arithmetic Shift Right (acc = 0xa540 >>> 0x0001)
        sw = 16'h0001; btnl = 0; btnc = 1; btnr = 0; btnd = 1;
        #10; btnd = 0; #10;
        $display("Test 8 (Arithmetic Shift Right): led = %h (αναμενόμενο: d2a0)", led);

        // Test 9: Less Than (acc = 0xd2a0 < sw = 0x46ff)
        sw = 16'h46ff; btnl = 1; btnc = 0; btnr = 1; btnd = 1;
        #10; btnd = 0; #10;
        $display("Test 9 (Less Than): led = %h (αναμενόμενο: 0001)", led);

        #50 $finish;
    end

endmodule
