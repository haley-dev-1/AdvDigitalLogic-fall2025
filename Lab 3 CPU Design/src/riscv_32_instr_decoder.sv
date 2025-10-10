/*
 * Haley Lind 
 * CSCE611 RISCV 3 Stage CPU Design
 * Fall 2025
*/

module riscv_32_instr_decoder(
        input logic [31:0] full,

        output logic [6:0] opcode,
        output logic [2:0] type_of_instruction
);

assign opcode = full[6:0]; // grabs those bits, which tell opcode

// instantiate lut from lut.sv

// get value from lut (it returns a 0, 1, or 2 in binary)

lut lut_for_instruction_type(
                .op(opcode),
                .instr_type(type_of_instruction)
                                );

// above lut gives back 000, 001, or 010 based on op code (3 bits -- can be extended)

endmodule
