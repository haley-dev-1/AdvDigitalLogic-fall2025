module riscv_32_instr_decoder(
        input logic [31:0] full,

        output logic [6:0] opcode,
        output logic [2:0] type_of_instruction
);

// instantiate lut from lut.sv
lut lut_for_instruction_type(
                .op(full[6:0])
                                );
// above lut gives back 000, 001, or 010 based on op code (3 bits -- can be extended)

// get value from lut (it returns a 0, 1, or 2 in binary)

        always_comb
        begin
                case(lut_for_instruction_type)
                7'b0110011: type_of_instruction = 3'b000;   // R
                7'b0010011: type_of_instruction = 3'b001;   // I
                7'b0110111: type_of_instruction = 3'b010;   // U
        end

        // next we need to use this for control unit

        // 3 bit input to control unit

endmodule

//ctrl_unit.sv

/*
riscv is for control nit // nested if statements
*/