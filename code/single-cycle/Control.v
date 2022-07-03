
module Control(OpCode, Funct,
	PCSrc, Branch, RegWrite, RegDst, 
	MemRead, MemWrite, MemtoReg, 
	ALUSrc1, ALUSrc2, ExtOp, LuOp);
	input [5:0] OpCode;
	input [5:0] Funct;
	output [1:0] PCSrc;
	output Branch;
	output RegWrite;
	output [1:0] RegDst;
	output MemRead;
	output MemWrite;
	output [1:0] MemtoReg;
	output ALUSrc1;
	output ALUSrc2;
	output ExtOp;
	output LuOp;

	reg [1:0] PCSrc;
	reg Branch;
	reg RegWrite;
	reg [1:0] RegDst;
	reg MemRead;
	reg MemWrite;
	reg [1:0] MemtoReg;
	reg ALUSrc1;
	reg ALUSrc2;
	reg ExtOp;
	reg LuOp;
	
	always@*
        begin
            case(OpCode)
                6'h23: begin
                    // lw
					PCSrc <= 2'b00;
					Branch <= 1'b0;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b1;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b01;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b1;
					LuOp <= 1'b0;
                end
                6'h2b: begin
                    // sw
					PCSrc <= 2'b00;
					Branch <= 1'b0;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b1;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b1;
					LuOp <= 1'b0;
                    
                end
                6'h0f: begin
                    // lui
					PCSrc <= 2'b00;
					Branch <= 1'b0;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					LuOp <= 1'b1;
                    
                end
                6'h08: begin
                    // addi
					PCSrc <= 2'b00;
					Branch <= 1'b0;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b1;
					LuOp <= 1'b0;
                    
                end
                6'h09: begin
                    // addiu
					PCSrc <= 2'b00;
					Branch <= 1'b0;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b1;
					LuOp <= 1'b0;
                    
                end
                6'h0c: begin
                    // andi
                    PCSrc <= 2'b00;
					Branch <= 1'b0;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b0;
					LuOp <= 1'b0;
                end
                6'h0a: begin
                    // slti
                    PCSrc <= 2'b00;
					Branch <= 1'b0;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b1;
					LuOp <= 1'b0;
                end
                6'h0b: begin
                    // sltiu
                    PCSrc <= 2'b00;
					Branch <= 1'b0;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b1;
					LuOp <= 1'b0;
                end
                6'h04: begin
                    // beq
                    PCSrc <= 2'b00;
					Branch <= 1'b1;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b0;
					ExtOp <= 1'b1;
					LuOp <= 1'b0;
                end
				6'h02: begin
                    // j
					PCSrc <= 2'b10;
					Branch <= 1'b0;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
                    
                end
				6'h03: begin
                    // jal
					PCSrc <= 2'b10;
					Branch <= 1'b0;
					RegWrite <= 1'b1;
					RegDst <= 2'b10;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b10;
                    
                end
                6'h00: begin
                    case(Funct)
                        6'h20: begin
                            // add
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            
                        end
                        6'h21: begin
                            // addu
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            
                        end
                        6'h22: begin
                            // sub
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            
                        end
                        6'h23: begin
                            // subu
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            
                        end
                        6'h24: begin
                            // and
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            
                        end
                        6'h25: begin
                            // or
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            
                        end
                        6'h26: begin
                            // xor
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            
                        end
                        6'h27: begin
                            // nor
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            
                        end
                        6'h00: begin
                            // sll
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b1;
							ALUSrc2 <= 1'b0;
                            
                        end
                        6'h02: begin
                            // srl
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b1;
							ALUSrc2 <= 1'b0;
                            
                        end
                        6'h03: begin
                            // sra
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b1;
							ALUSrc2 <= 1'b0;
                            
                        end
                        6'h2a: begin
                            // slt
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            
                        end
                        6'h2b: begin
                            // sltu
							PCSrc <= 2'b00;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            
                        end
						6'h08: begin
                            // jr
							PCSrc <= 2'b11;
							Branch <= 1'b0;
							RegWrite <= 1'b0;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
                            
                        end
						6'h09: begin
                            // jalr
							PCSrc <= 2'b11;
							Branch <= 1'b0;
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b10;
                            
                        end
                        default: begin
                            
                        end
                    endcase
                end
                default: begin
                end
            endcase
        end
	
endmodule