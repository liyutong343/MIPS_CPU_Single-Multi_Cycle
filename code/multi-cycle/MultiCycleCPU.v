`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Fundamentals of Digital Logic and Processor
// Designer: Shulin Zeng
// 
// Create Date: 2021/04/30
// Design Name: MultiCycleCPU
// Module Name: MultiCycleCPU
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

module MultiCycleCPU (reset, clk, PC_o, v0, a0, sp, ra);
    //Input Clock Signals
    input reset;
    input clk;
    output [31:0] PC_o;
    output [31:0] v0, a0, sp, ra;

    wire [31:0] Mem_data;
    // Decode
    wire [5:0] OpCode;
    wire [4:0] Rs;
    wire [4:0] Rt;
    wire [4:0] Rd;
    wire [4:0] Shamt;
    wire [5:0] Funct;
    //wire [15:0] imm;
    //wire [25:0] target;

    // Controller
    wire PCWrite;
    wire PCWriteCond;
    wire IorD;
    wire MemWrite;
    wire MemRead;
    wire IRWrite;
    wire [1:0] MemtoReg;
    wire [1:0] RegDst;
    wire RegWrite;
    wire ExtOp;
    wire LuiOp;
    wire [1:0] ALUSrcA;
    wire [1:0] ALUSrcB;
    wire [3:0] ALUOp;
    wire [1:0] PCSource;
    Controller myController(reset, clk, OpCode, Funct, 
                PCWrite, PCWriteCond, IorD, MemWrite, MemRead,
                IRWrite, MemtoReg, RegDst, RegWrite, ExtOp, LuiOp,
                ALUSrcA, ALUSrcB, ALUOp, PCSource);
    
    // InstReg
    InstReg myInstReg(reset, clk, IRWrite, Mem_data, OpCode, Rs, Rt, Rd, Shamt, Funct);


    // ImmProcess
    wire [31:0] ImmExtOut;
    wire [31:0] ImmExtShift;
    ImmProcess myImmProcess(ExtOp, LuiOp, {Rd, Shamt, Funct}, ImmExtOut, ImmExtShift); 

    // RegisterFile
    wire [4:0] Write_register;
    wire [31:0] Write_reg_data;
    wire [31:0] Read_data1;
    wire [31:0] Read_data2;
    assign Write_register = RegDst == 2'b00 ? Rt :
                            RegDst == 2'b01 ? Rd : 5'b11111;
    RegisterFile myRegisterFile(reset, clk, RegWrite, Rs, Rt, Write_register, Write_reg_data, Read_data1, Read_data2,v0, a0, sp, ra);

    // 2 data reg
    wire [31:0] Read_data1_reg;
    wire [31:0] Read_data2_reg;
    RegTemp RegTemp1(reset, clk, Read_data1, Read_data1_reg);
    RegTemp RegTemp2(reset, clk, Read_data2, Read_data2_reg);

    // ALU
    wire [4:0] ALUConf;
    wire Sign;
    wire [31:0] In1;
    wire [31:0] In2;
    wire Zero;
    wire [31:0] Result;
    wire [31:0] Result_reg;
    //wire [31:0] PC_o;
    assign In1 = ALUSrcA == 2'b00 ? PC_o : 
                ALUSrcA == 2'b01 ? Read_data1_reg :{17'b0, Shamt};
    assign In2 = ALUSrcB == 2'b00 ? Read_data2_reg :
                ALUSrcB == 2'b01 ? 16'd4 :
                ALUSrcB == 2'b10 ? ImmExtOut : ImmExtShift; 
    ALUControl myALUControl(ALUOp, Funct, ALUConf, Sign);
    ALU myALU(ALUConf, Sign, In1, In2, Zero, Result);
    RegTemp RegTempAlu(reset, clk, Result, Result_reg);

    // PC
    wire [31:0] PC_i;
    // wire [31:0] PC_o;
    wire PC_Write;
    assign PC_Write = (PCWriteCond && Zero) || PCWrite;
    assign PC_i = PCSource == 2'b00 ? Result :
                    PCSource == 2'b01 ? Result_reg : {PC_o[31:28], {Rs, Rt, Rd, Shamt, Funct}, 2'b00};
    PC myPC(reset, clk, PC_Write, PC_i, PC_o);

    // Memory
    wire [31:0] Address;
    wire [31:0] Write_mem_data;
    // wire [31:0] Mem_data;
    assign Address = IorD ? Result_reg : PC_o;
    assign Write_mem_data = Read_data2_reg;
    InstAndDataMemory myInstAndDataMemory(reset, clk, Address, Write_mem_data, MemRead, MemWrite, Mem_data);

    // MDR
    wire [31:0] Mem_data_reg;
    RegTemp RegTempMDR(reset, clk, Mem_data, Mem_data_reg);

    // Write back to reg
    assign Write_reg_data = MemtoReg == 2'b00 ? Mem_data_reg :
                            MemtoReg == 2'b01 ? Result_reg : PC_o;        
    
endmodule