// haley lind csce611 oct15 2025

module mycpu(
    input logic clk, 
    input logic res, 
    input logic [31:0] gpio_in, 

    output logic [31:0] gpio_out
);

    // 3 stages ... 1. fetch, 2. execute, 3. writeback

    // read an assembled riscv program via instmem.dat (this is for testing) and reset the CPU
    // 

    /* FETCH DTAGE */
    logic [31:0] pc_F, pc_next_F;
    logic [31:0] instruction_F;

    // instruction memory
        // also where PC might live? based on CPU diagram
    // instr_mem imem (
   //     .clk (clk),
   //     .addr(pc_F),
   //     .data(instruction_F)        // valid next cycle
   // );

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
            .op(opcode),
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