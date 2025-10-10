module ctrl_unit(
        input logic [2:0] instruction_type// from instruction decider
//      input logic [6:0] op,
        input logic [2:0] funct3, // I and R; optional for U
        input logic [6:0] funct7, // I, R, U is optional

        output logic [1:0] alusrc_EX,
        output logic [0:0] GPIO_we,
        output logic [0:0] regwrite_EX,
        output logic [1:0] regsel_EX, // 1 bit
        output logic [3:0] aluop_EX, // isn't that four bits

                );

        // we use the instruction decoder, and know what type of instruction it is. Now what?


        // combinational logic ...

        // LUI vs AUIPC (U type)

        always_comb
        begin
                case(instruction_type)
                        3'b000:
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
                                /* WE DIVIDE THE R TYPES INTO 2 THINGS */
                                if(funct7 == 7'b0000_0000)
                                        if(funct3 == 3'b000) // add
                                                aluop_EX = 4'b0011
                                        else if (funct3 == 4'b0100) // XOR
                                                //
                                        else if (funct3 == 4'b0110) // OR
                                                aluop_EX = 4'b0000;
                                        else if (funct3 == 4'b0111) // AND
                                                aluop_EX = 4'b0000
                                        else if (funct3 == 4'b0001) // SLL
                                                //
                                        else if (funct3 == 4'b0101) // SRL
                                                //
                                        else if (funct3 == 4'b0010) // SLT
                                                //
                                        else if (funct3 == 4'b0011) // SLTU
                                                //

                                /** *** ** FUNCT 7 IS NOT 0! Tis 0x20 ** *** **/
                                else if(funct7 == 7'0010_0000)
                                        if(funct3==4'b0000) // SUB
                                                //
                                        else if(funct3 == 4'0101) // SRA
                                                //

                                /** *** ** FUNCT 7 IS NOT 0! Tis 0x01 ** *** **/
                                else if(funct7 == 7'0000_0001)

                                        if(funct3 == 3'b000) // MUL
                                                //
                                        else if (funct3 == 3'b001) // MULH
                                                //
                                        else if (funct3 == 3'b010) // MULHSU
                                                //
                                        else if (funct3 == 3'b011) // MULHU
                                                //
                                        else if (funct3 == 3'b100) // DIV
                                                //
                                        else if (funct3 == 3'b101) // DIVU
                                                //
                                        else if (funct3 == 3'b110) // REM
                                                //
                                        else if (funct3 == 3'b111) // REMU
                                                //
                                end

                                default:
                                begin
                                aluop_EX = 4'b0000; // default
                                end
                                endcase


                        //      mul rd,rs1,rs2
                        //      mulh rd,rs1,rs2
                        //      mulhu rd,rs1,rs2
                        //      slt rd,rs1,rs2
                        //      sltu rd,rs1,rs2
                        //
                        //      or rd,rs1,rs2
                        //      xor rd,rs1,rs2
                        //      sll rd,rs1,rs2
                        //      srl rd,rs1,rs2
                        //      sra rd,rs1,rs2
                                // ---- end of r ----

                        3'b001:
                                /*
                                    I TYPE MODULE
                                    ------------------
                                    0-6 for op
                                    7-11 for rd [11:7]
                                    12-14 for funct3 [14:12]
                                    15-19 rs1 [19:15]
                                    imm [31:20]
                                 */

                        3'b010:
                                /*
                                    U TYPE MODULE
                                    ------------------
                                    0-6 for op
                                    7-11 for rd [11:7]
                                    12-14 for funct3 [31:12]
                                 */
        end
endmodule