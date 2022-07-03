`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Fundamentals of Digital Logic and Processor
// Designer: Shulin Zeng
// 
// Create Date: 2021/04/30
// Design Name: MultiCycleCPU
// Module Name: ALU
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


module ALU(ALUConf, Sign, In1, In2, Zero, Result);
    // Control Signals
    input [4:0] ALUConf;
    input Sign;
    // Input Data Signals
    input [31:0] In1;
    input [31:0] In2;
    // output 
    output reg Zero;
    output reg [31:0] Result;

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
        Result <= 32'b0;
        Zero <= 1'b0;
    end

    always@* 
    begin
        case(ALUConf)
            ADD: begin
                Result <= In1 + In2;
                Zero <= 1'b0;
            end
            SUB: begin
                Result <= In1 - In2;
                if(In1 == In2) Zero <= 1'b1;
                else Zero <= 1'b0;
            end
            AND: begin
                Result <= In1 & In2;
                Zero <= 1'b0;
            end
            OR: begin
                Result <= In1 | In2;
                Zero <= 1'b0;
            end
            XOR: begin
                Result <= In1 ^ In2;
                Zero <= 1'b0;
            end
            NOR: begin
                Result <= ~(In1 | In2);
                Zero <= 1'b0;
            end
            SL: begin
                Result <= In2 << In1;
                Zero <= 1'b0;
            end
            SR: begin
                if(Sign) Result <= $signed(In2) >>> $signed(In1);
                else Result <= In1 >> In2;
                Zero <= 1'b0;
            end
            COMP: begin
                if(Sign) Result <= $signed(In1) < $signed(In2) ;
                else Result <= In1 < In2;
                Zero <= 1'b0;
            end
            default: begin
                Result <= 32'b0;
                Zero <= 1'b0;
            end
        endcase
    end
        
    //--------------Your code above-----------------------

endmodule
