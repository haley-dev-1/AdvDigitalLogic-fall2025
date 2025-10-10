module lut(
        input logic [6:0] op,
        output logic [2:0] instr_type
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