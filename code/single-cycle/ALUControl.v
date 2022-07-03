module ALUControl(
        input [5:0] OpCode,
        input [5:0] Funct,
        output reg [4:0] ALUCtrl,
        output reg Sign
    );

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
        ALUCtrl <= 5'b0;
        Sign <= 1'b0;
    end


    always@*
        begin
            case(OpCode)
                6'h23: begin
                    // lw
                    ALUCtrl <= ADD;
                    Sign <= 1'b1;
                end
                6'h2b: begin
                    // sw
                    ALUCtrl <= ADD;
                    Sign <= 1'b1;
                end
                6'h0f: begin
                    // lui
                    ALUCtrl <= ADD;
                    Sign <= 1'b0;
                end
                6'h08: begin
                    // addi
                    ALUCtrl <= ADD;
                    Sign <= 1'b1;
                end
                6'h09: begin
                    // addiu
                    ALUCtrl <= ADD;
                    Sign <= 1'b0;
                end
                6'h0c: begin
                    // andi
                    ALUCtrl <= AND;
                    Sign <= 1'b0;
                end
                6'h0a: begin
                    // slti
                    ALUCtrl <= COMP;
                    Sign <= 1'b1;
                end
                6'h0b: begin
                    // sltiu
                    ALUCtrl <= COMP;
                    Sign <= 1'b0;
                end
                6'h04: begin
                    // beq
                    ALUCtrl <= SUB;
                    Sign <= 1'b0;   // Don't care
                end
                6'h00: begin
                    case(Funct)
                        6'h20: begin
                            // add
                            ALUCtrl <= ADD;
                            Sign <= 1'b1;
                        end
                        6'h21: begin
                            // addu
                            ALUCtrl <= ADD;
                            Sign <= 1'b0;
                        end
                        6'h22: begin
                            // sub
                            ALUCtrl <= SUB;
                            Sign <= 1'b1;
                        end
                        6'h23: begin
                            // subu
                            ALUCtrl <= SUB;
                            Sign <= 1'b0;
                        end
                        6'h24: begin
                            // and
                            ALUCtrl <= AND;
                            Sign <= 1'b0;
                        end
                        6'h25: begin
                            // or
                            ALUCtrl <= OR;
                            Sign <= 1'b0;
                        end
                        6'h26: begin
                            // xor
                            ALUCtrl <= XOR;
                            Sign <= 1'b0;
                        end
                        6'h27: begin
                            // nor
                            ALUCtrl <= NOR;
                            Sign <= 1'b0;
                        end
                        6'h00: begin
                            // sll
                            ALUCtrl <= SL;
                            Sign <= 1'b0;
                        end
                        6'h02: begin
                            // srl
                            ALUCtrl <= SR;
                            Sign <= 1'b0;
                        end
                        6'h03: begin
                            // sra
                            ALUCtrl <= SR;
                            Sign <= 1'b1;
                        end
                        6'h2a: begin
                            // slt
                            ALUCtrl <= COMP;
                            Sign <= 1'b1;
                        end
                        6'h2b: begin
                            // sltu
                            ALUCtrl <= COMP;
                            Sign <= 1'b0;
                        end
                        default: begin
                            ALUCtrl <= DC;
                            Sign <= 1'b0;
                        end
                    endcase
                end
                default: begin
                    ALUCtrl <= DC;
                    Sign <= 1'b0;
                end
            endcase
        end


endmodule