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
                .HEX0(HEX0),
                .HEX1(HEX1),
                .HEX2(HEX2),
                .HEX3(HEX3),
                .HEX4(HEX4),
                .HEX5(HEX5),
                .HEX6(HEX6),
                .HEX7(HEX7)
        );

        // pulse reset (active low)
        initial begin
                KEY <= 4'he;
                #10;
                KEY <= 4'hf;
        end

        // drive clock
        always begin
                clk <= 1'b0; #5;
                clk <= 1'b1; #5;
        end

        // assign simulated switch values
        assign SW = 18'd12345;

endmodule

// need to update actual architecture to reflect the cpu but this is good pseudo code 
Initial begin 
// instantiate our testbench, needs to check the output of the cpu. binary numbers need to output decimal numbers, really just check those 
//set switches to desired numbers to check 
SW = 18'h1dddd;  // this is 18 bits that, we are assigning 4 to every 4 bit section in the 18, we will check the 

// need to take the input from the risc v code and read after some number of cyclces to check if we are correct 
#20
if (HEX0 !== 0xf00) begin 
	$display("yo junk is cooked for //initial number) 
end else $display("looking good for TEST CASE) 
if (HEX1 !-- 0xf00)
	$display("not working for input 4") 
end else $display("looking good for 4")
end 
//testing, needs to be longer 

// make it clock constantly
// display statements inside the cpu to output after instruction 
// chech csrrw with the output 
// always_ff @ (posedge clk) 
// if (rst) begin 
// instruction_EX <= 32'b0;
//PC_FETCH <= instruction_mem[PC_FETCH];
//end 











