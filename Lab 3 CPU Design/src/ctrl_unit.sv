/*
 * Haley Lind & Michael Stewart
 * CSCE611 RISCV 3 Stage CPU Design
 * Fall 2025
*/
// this is the brain of the cpu, it looks at the opcode, func3, funct7 fields from an instruction and decides what control signals to send to other parts of cpu

module ctrl_unit(
        // input logic [2:0] instruction_type      // from instruction decider
        input logic [6:0] op,   // design critique to directly pass op code if-else/case ... i guess form the 32 instruction decoder? 
        input logic [2:0] funct3,       // I and R; optional for U
        input logic [6:0] funct7,       // I, R, U is optional
        input logic [11:0] imm12            // exclusively (?) for use of cssrw instruction ... connect w/ gpio registers 0xF00 0xF02
        // FROM PDF: Suggested outputs are alusrc, regwrite, regsel, aluop, gpio_we

        output logic [1:0] alusrc_EX,
        output logic [0:0] GPIO_we,
        output logic [0:0] regwrite_EX,
        output logic [1:0] regsel_EX, // 1 bit
        output logic [3:0] aluop_EX, // isn't that four bits
);
        always_comb
        begin

                /* -------------------- Setting defaults ----------------------
                ...to avoid "latching" ... that is because in SYNTHESIS latches 
                get inferred when combinational block doesn't have an output for
                every path! */
                // literally just instantiate our variables with default 0 to start 
                
	regwrite_EX = 1'b0;
	alusrc_EX = 2'b00;
	GPIO_we = 1'b0; 
	regsel_EX = 2'b00;
	aluop_EX = 4'b0000;

                case(op)
                        
                        // R type encoding      
                        7'b0110011:
                                
                                begin

                                /* ______________________ R TYPE MODULE _____________________
                                   0-6 for op  |  7-11 for rd [11:7]  |  12-14 for funct3 [14:12]
                                   15-19 rs1 [19:15]  |  rs2 [24:20]  |  funct7 [31:25]           */

                                // overwrite the defaults set outside of the case
                                regwrite_EX = 1'b1;
                                alusrc_EX = 1'b0;
                                regsel_EX = 2'b10;  
                                GPIO_we = 1'b0; // for csrrw -- only thing to write to gpio

                                if(funct7 == 7'b000_0000)
                                        if(funct3 == 3'b000) // add
                                                aluop_EX = 4'b0011;
                                        else if (funct3 == 3'b100) // XOR
                                                aluop_EX = 4'b0001;
                                        else if (funct3 == 3'b110) // OR
                                                aluop_EX = 4'b0000;
                                        else if (funct3 == 3'b111) // AND
                                                aluop_EX = 4'b0000;
                                        else if (funct3 == 3'b001) // SLL
                                                aluop_EX = 4'b0101;
                                        else if (funct3 == 3'b101) // SRL
                                                aluop_EX = 4'b0110;
                                        else if (funct3 == 3'b010) // SLT
                                                aluop_EX = 4'b1000;
                                        else if (funct3 == 3'b011) // SLTU
                                                aluop_EX = 4'b1001;
                                end
                                else if(funct7 == 7'b010_0000) // is that a dont care? 
                                        if(funct3==3'b000) ;
                                                aluop_EX = 4'b0100; // SUB
                                        else if(funct3 == 3'b0101) 
                                                aluop_EX = 4'b0111; // SRA
                                end
                                else if(funct7 == 7'000_0001)
                                        if(funct3 == 3'b000) // MUL
                                                aluop_EX = 4'b1010;
                                        else if (funct3 == 3'b001) // MULH
                                                aluop_EX = 4'b1011;
                                        else if (funct3 == 3'b010) // MULHSU
                                                aluop_EX = 4'b1100;
                                        else if (funct3 == 3'b011) // MULHU
                                                aluop_EX = 4'b1101;
                                        else if (funct3 == 3'b100) // DIV
                                                aluop_EX = 4'b1110;
                                        else if (funct3 == 3'b101) // DIVU
                                                aluop_EX = 4'b1110;
                                        else if (funct3 == 3'b110) // REM
                                                aluop_EX = 4'b1111;
                                        else if (funct3 == 3'b111) // REMU
                                                aluop_EX = 4'b1111;
                                end
                        end

                        // I Type encoding
                        7'b0010011:
                                begin
                                        /*  _______________________ I TYPE MODULE ________________________
                                        0-6 for op  |  7-11 for rd [11:7]  |  12-14 for funct3 [14:12]  
                                        15-19 rs1 [19:15]  |  imm [31:20]                               */

                                        // These also overwrite the defaults set outside of the case
                                        regwrite_EX = 1'b1; 
                                        alusrc_EX   = 1'b1;  // rs1, imm
                                        regsel_EX   = 2'b10;
                                        GPIO_we     = 1'b0;
                                        
                                        if (funct3 == 3'b000) aluop_EX = 4'b0011; // ADDI
                                        else if (funct3 == 3'b001) aluop_EX = 4'b0101; // SLLI
                                        else if (funct3 == 3'b011) aluop_EX = 4'b1001; // SLTIU
                                        
                                        else if (funct3 == 3'b100) aluop_EX = 4'b0001; // XORI
                                        else if (funct3 == 3'b101) aluop_EX = 4'b0110; // SRLI
                                        //SRAI
                                        else if (funct3 == 3'b110) aluop_EX = 4'b0010; // ORI
                                        else if (funct3 == 3'b111) aluop_EX = 4'b0000; // ANDI
                                        
                                        // else if (funct3 == 3'b010) aluop_EX = 4'b1000; // SLTI

                                        end // ends the if statement 
                                end // matches the begin
                        //end <- this was extra, just leaving for documentation 

                        // U type LUI opcode
                        7'b0110111:  
                        begin
                        	regwrite_EX = 1'b1;
                        	alusrc_EX = 2'b10; 
                        	regsel_EX = 2'b01; 
                        	GPIO_we = 1'b0;
                        	aluop_EX = 4'b0000;
                        end 
                        7'b1110011: //CSRRW
                        begin 
                        	regwrite_EX = 1'b0;
                        	alusrc_EX = 2'b00; 
                        	regsel_EX = 2'b00;
                        	aluop_EX = 4'b0000; 
                        	if (imm12  == 12'hF00) // if our add imm is magic then turn on read and off write 
                        		GPIO_we = 1'b1;
                        		regwrite_EX = 1'b0;
                        	end
                        	else if (imm12 == 12'hF02) begin 
                        		GPIO_we = 1'b0; 
                        		regwrite_EX = 1'b1;
                        		regsel_EX = 2'b11;
                        		end 
                        	else begin 
                        		GPIO_we = 1'b0;
                        	end
                        end 
                        default:
                        begin
                        	regwrite_EX = 1'b0; 
                        	alusrc_EX, 
                        	output logic [0:0] GPIO_we,
                        	output logic [0:0] regwrite_EX,
                        	output logic [1:0] regsel_EX,
                        	output logic [3:0] aluop_EX,
                        end		 

// deleted all the extra commented code, was hard to look at lol. 

