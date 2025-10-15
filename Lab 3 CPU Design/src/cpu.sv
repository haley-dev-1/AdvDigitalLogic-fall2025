// haley lind csce611 oct15 2025

/* === EXAMPLE OF INSTANTIATION WITHIN TOP.SV ===
    cpu mycpu(
            .clk() //  1
            .res() //  1 
            .gpio_in() // 32   
            .gpio_out() // 32         ); 
================================================*/

module mycpu(
    input clk, res, 
    input [31:0] gpio_in, 
    input [31:0] gpio_out

    output
);



    riscv_32_instr_decoder decode (

            .full(instr)
            .opcode(opcode),
            
            .funct3(funct3),
            .funct7(funct7),
            
            .rs1(rs1),
            .rs2(rs2),
            .rd(rd),

            .imm12(imm12),
            .imm20(imm20),
            
            // .type_of_instruction(type_of_instruction) // no mas
    );

    /* We wire the control unit to above wires declared in "Control unit wiring" section
    ctrl_unit ctrlutrl (
            /*inputs*/
            // .instruction_type(),       
            .op(opcode)
            .funct3(funct3),
            .funct7(funct7),
            .imm12(imm12),
            .imm20(imm20), 

            /* outputs */
            .alusrc_EX(alusrc_EX),     
            .GPIO_we(GPIO_we),
            .regwrite_EX(regwrite_EX),
            .regsel_EX(regsel_EX), // 1 bit
            .aluop_EX(aluop_EX) // isn't that four bits*/
    );
endmodule