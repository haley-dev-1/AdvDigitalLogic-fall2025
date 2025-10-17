/* Copyright 2020 Jason Bakos, Philip Conrad, Charles Daniels */

/* Top-level module for CSCE611 RISC-V CPU, for running under simulation.  In
 * this case, the I/Os and clock are driven by the simulator. */

module simtop;

        logic clk;
        logic [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
        logic [3:0] KEY;
        logic [17:0] SW;

        top dut
        (
                //////////// CLOCK //////////
                .CLOCK_50(clk),
                .CLOCK2_50(),
                .CLOCK3_50(),

                //////////// LED //////////
                .LEDG(),
                .LEDR(),

                //////////// KEY //////////
                .KEY(KEY),

                //////////// SW //////////
                .SW(SW),

                //////////// SEG7 //////////
                .HEX1(HEX1),
                .HEX0(HEX0),
                .HEX2(HEX2),
                .HEX3(HEX3),
                .HEX4(HEX4),
                .HEX5(HEX5),
                .HEX6(HEX6),
                .HEX7(HEX7)
        );

initial begin

	SW = 18'b0;
	$display("======================================");
	$display("Starting CPU test");
	$display("---------------------------------------");
	
	
	$display("\n Test 1: Instruction Fetch");
	#100 // supposed to run for 10 clock cycles
	$display("PC= %h, dut.mycpu.pc_F");
	$display("finish this junk later lol.");
end 








