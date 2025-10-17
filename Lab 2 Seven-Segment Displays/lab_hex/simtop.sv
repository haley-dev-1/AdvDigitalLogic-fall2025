/* Copyright 2020 Jason Bakos, Philip Conrad, Charles Daniels */

/* Top-level module for CSCE611 RISC-V CPU, for running under simulation.  In
 * this case, the I/Os and clock are driven by the simulator. */

module simtop;

	logic clk;
	logic [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
	logic [17:0] SW;

	top dut // design under test
	(
		//////////// CLOCK //////////
		.CLOCK_50(clk),
		.CLOCK2_50(),
	        .CLOCK3_50(),

		//////////// LED //////////
		.LEDG(),
		.LEDR(),

		//////////// KEY //////////
		.KEY(),

		//////////// SW //////////
		.SW(SW),

		//////////// SEG7 //////////
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5),
		.HEX6(HEX6),
		.HEX7(HEX7)
	);

// Notes:
/* 
* initial begin block ... "initial" is not synthesizable and cannot be converted into hardware!
* initial is for SIMULATION
* In this module, we are using another module (top), which we named dut. 
	In dut, we did ports and wrote switch to switch.
*
*/
	initial begin
	
		/* Demo for 7seg 0 */
		SW = 18'b0000_0000_0000_0000_01; #10 // sets switch, then delay or 5 seconds
		if(HEX0 == 7'b1111001) $display("Testcase 1 passed");
		SW = 18'b0000_0000_0000_0010_00; #10 // sets switch, then delay or 5 seconds
		if(HEX0 == 7'b0000000) $display("Testcase 2 passed");
		
		/* dEMO FOR 7seg 1 */
		SW = 18'b0000_0000_0000_0100_00; #10 // sets switch, then delay or 5 seconds
		if(HEX1 == 7'b1111001) $display("Testcase 3 passed");
		SW = 18'b0000_0000_0010_0000_00; #10 // sets switch, then delay or 5 seconds
		if(HEX1 == 7'b0000000) $display("Testcase 4 passed");
		
		/* Demo for 7seg 2  */
		SW = 18'b0000_0000_1100_0000_00; #10 // sets switch, then delay or 5 seconds
		if(HEX2 == 7'b0110000) $display("Testcase 5 passed");
		SW = 18'b0000_0000_01_0000_0000; #10 // sets switch, then delay or 5 seconds
		if(HEX2 == 7'b1111001) $display("Testcase 6 passed");
		
		/* Demo for 7seg 3 */
		SW = 18'b00_0001_0000_0000_0000; #10 // sets switch, then delay or 5 seconds
		if(HEX3 == 7'b1111001) $display("Testcase 7 passed");
		SW = 18'b0001_0000_0000_0000_00; #10 // sets switch, then delay or 5 seconds
		if(HEX3 == 7'b0011001) $display("Testcase 8 passed");
		
		/* Demo for 7seg 4 */
		SW = 18'b1100_0000_0000_0000_00; #10 // sets switch, then delay or 5 seconds
		if(HEX4 == 7'b0110000) $display("Testcase 9 passed");
		SW = 18'b1000_0000_0000_0000_00; #10 // sets switch, then delay or 5 seconds
		if(HEX4 == 7'b0100100) $display("Testcase 10 passed");
		
		
	end




endmodule

