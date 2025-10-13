# CPU

# Current status
I've mostly got the CPU architecture down, including control unit, decoder, etc. I just haven't ran it at all. **Haven't worked through any sort of error messages that might come from running it.**

## Todo 
* sim top 
* actually run this mf cuz i havent done that yet lolz
* make RISCV program to be ran // run/test on the FPGA board

..  
..  
..  
..  
..  
# IGNORE EVERYTHING BELOW THIS UNLESS YOU REALLY CARE ........

---
---
---
---
---
---
---
---

# References
https://www.cs.sfu.ca/~ashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_CARD.pdf for ISA e.g. opcodes, funct3, funct7

# Design Instruction Decoder
1. Standalone module 
2. take in 32-bit instructions
3. outputs all fields of each type of instruction
4. **Do not** determine instruction type within this module and parse or whatever

## Pull out all possible fields out of each instruction
Is it R, I, U based on its opcode?


## Module: Instruction Decoder

```verilog
module riscv_32_instr_decoder(
    input clk,
    input reset,
    input logic [31:0] full,
);

    // lut(full[6:0]) // goal here is to use our custom lut module
    // instatntiate lut
    // lut should return the type of instruction due to its opcode
    // 000 is R, 001 is I, 010 is U
    lut lut_for_instruction_type(
                            .op(full[6:0]), // 7 least significant btis will house the opcode
                            .clk(clk)
                            // are there others? 
                            );

    // The lut outputs 00, 01, 10 for R,I,U respectively
    // next, decode depending on the different types of instructions
    always_comb 
    begin
        case(r, i, or u)
            3'000: // TODO: Module for R type
            3'001: // TODO: Module for I type
            3'010: // TODO: Module for U type
        endcase
    end

// decoder should output all fields given the type of instruction (App. B), page 12 thing

endmodule

```

## Module: Look-Up Table
```verilog
// LUT
// Look at opcode from 32bit input
module lut(
    input logic [6:0] op,
    output logic [2:0] type_of_instruction // can be extended because 3 bits = 2^3 = 8 
    // 000 is R
    // 001 is I
    // 010 is U
    // planned but not imeplemented:
        // 011 for J
        // 100 for B
        // 101 for ?

);

always_comb begin
    case(op)
    7'b0110011: type_of_instruction = 3'b000;   // R
    7'b0010011: type_of_instruction = 3'b001;   // I
    7'b0110111: type_of_instruction = 3'b010;   // U
    default:    type_of_instruction = 3'b111    // bad
    endcase
end
endmodule
```

## Module: R Type Instruction 
```verilog
module r_type_instruction(
    // no clk/res inputs because combinational 
    input logic [31:0] full,
    
    output logic [6:0] op,
    output logic [11:7] rd,
    output logic [14:12] funct3,
    output logic [19:15] rs1,
    output logic [24:20] rs2,
    output logic [31:25]

);

/*
    R TYPE MODULE
    ------------------
    0-6 for op 
    7-11 for rd [11:7]
    12-14 for funct3 [14:12]
    15-19 rs1 [19:15]
    rs2 [24:20]
    funct7 [31:25]
    */

// R, I, and U instructions
    // they all have first 7 bits for opcode (bits 0-6)
    // r
        // add rd,rs1,rs2
        // sub rd,rs1,rs2
        // mul rd,rs1,rs2
        // mulh rd,rs1,rs2
        // mulhu rd,rs1,rs2
        // slt rd,rs1,rs2
        // sltu rd,rs1,rs2
        // and rd,rs1,rs2
        // or rd,rs1,rs2
        // xor rd,rs1,rs2
        // sll rd,rs1,rs2
        // srl rd,rs1,rs2
        // sra rd,rs1,rs2

endmodule
```