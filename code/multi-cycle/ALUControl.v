`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Fundamentals of Digital Logic and Processor
// Designer: Shulin Zeng
// 
// Create Date: 2021/04/30
// Design Name: MultiCycleCPU
// Module Name: ALUControl
// Project Name: Multi-cycle-cpu
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALUControl(ALUOp, Funct, ALUConf, Sign);
	//Control Signals
	input [3:0] ALUOp;
	//Inst. Signals
	input [5:0] Funct;
	//Output Control Signals
	output reg [4:0] ALUConf;
	output reg Sign;

    //--------------Your code below-----------------------

    parameter ADD = 5'd0;
    parameter SUB = 5'd1;
    parameter AND = 5'd2;
    parameter OR = 5'd3;
    parameter XOR = 5'd4;
    parameter NOR = 5'd5;
    parameter SL = 5'd6;
    parameter SR = 5'd7;
    parameter COMP = 5'd8;
    parameter DC = 5'd9;   // Don't care

    initial begin
        ALUConf <= 5'b0;
        Sign <= 1'b0;
    end


    always@*
        begin
            case(ALUOp)
                4'b0000: begin
                    // add
                    ALUConf <= ADD;
                end
				4'b0001: begin
                    // beq-sub
                    ALUConf <= SUB;
                end
				4'b0011: begin
                    // andi
                    ALUConf <= AND;
				end
				4'b0100: begin
                    // slti
                    ALUConf <= COMP;
                    Sign <= 1'b1;
                end      
				4'b0101: begin
                    // sltiu
                    ALUConf <= COMP;
                    Sign <= 1'b0;
                end
                4'b0010: begin
                    case(Funct)
                        6'h20: begin
                            // add
                            ALUConf <= ADD;
                            Sign <= 1'b1;
                        end
                        6'h21: begin
                            // addu
                            ALUConf <= ADD;
                            Sign <= 1'b0;
                        end
                        6'h22: begin
                            // sub
                            ALUConf <= SUB;
                            Sign <= 1'b1;
                        end
                        6'h23: begin
                            // subu
                            ALUConf <= SUB;
                            Sign <= 1'b0;
                        end
                        6'h24: begin
                            // and
                            ALUConf <= AND;
                            Sign <= 1'b0;
                        end
                        6'h25: begin
                            // or
                            ALUConf <= OR;
                            Sign <= 1'b0;
                        end
                        6'h26: begin
                            // xor
                            ALUConf <= XOR;
                            Sign <= 1'b0;
                        end
                        6'h27: begin
                            // nor
                            ALUConf <= NOR;
                            Sign <= 1'b0;
                        end
                        6'h00: begin
                            // sll
                            ALUConf <= SL;
                            Sign <= 1'b0;
                        end
                        6'h02: begin
                            // srl
                            ALUConf <= SR;
                            Sign <= 1'b0;
                        end
                        6'h03: begin
                            // sra
                            ALUConf <= SR;
                            Sign <= 1'b1;
                        end
                        6'h2a: begin
                            // slt
                            ALUConf <= COMP;
                            Sign <= 1'b1;
                        end
                        6'h2b: begin
                            // sltu
                            ALUConf <= COMP;
                            Sign <= 1'b0;
                        end
                        6'h08: begin
                            // jr
                            ALUConf <= ADD;
                            Sign <= 1'b1;
                        end
                        6'h09: begin
                            // jalr
                            ALUConf <= ADD;
                            Sign <= 1'b1;
                        end
                        default: begin
                            ALUConf <= DC;
                            Sign <= 1'b0;
                        end
                    endcase
                end
                default: begin
                    //ALUConf <= DC;
                    //Sign <= 1'b0;
                end
            endcase
        end
        
    //--------------Your code above-----------------------

endmodule
