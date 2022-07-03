module CPU(reset, clk, PC, v0, a0, sp, ra);
	input reset, clk;
	output reg [31:0] PC;
	output [31:0] v0, a0, sp, ra;

    // Decode
    wire [5:0] OpCode;
    wire [4:0] Rs;
    wire [4:0] Rt;
    wire [4:0] Rd;
    wire [4:0] Shamt;
    wire [5:0] Funct;
    wire [15:0] imm;
    wire [25:0] target;
    
    wire [31:0] Instruction;
    assign OpCode = Instruction[31:26];
    assign Rs = Instruction[25:21];
    assign Rt = Instruction[20:16];
    assign Rd = Instruction[15:11];
    assign Shamt = Instruction[10:6];
    assign Funct = Instruction[5:0];
    assign imm = Instruction[15:0];
    assign target = Instruction[25:0];

    // Control Unit
    wire [1:0] RegDst;
	wire [1:0] PCSrc;
	wire Branch;
	wire MemRead;
	wire [1:0] MemtoReg;
	wire ExtOp;
	wire LuOp;
	wire MemWrite;
	wire ALUSrc1;
	wire ALUSrc2;
	wire RegWrite;
    Control myCont(OpCode, Funct, PCSrc, Branch, RegWrite, RegDst, MemRead, MemWrite, MemtoReg, ALUSrc1, ALUSrc2, ExtOp, LuOp);

    // Imm Extend
    wire [31:0] imm_ext;
    assign imm_ext = {ExtOp? {16{imm[15]}} : 16'h0000, imm}; // ExtOp 1-Sign_extension 0-zero_extension

    // Regfile
    wire [4:0] Write_register;
    wire [31:0] Write_reg_data;
    wire [31:0] Read_data1;
    wire [31:0] Read_data2;
    assign Write_register = RegDst == 2'b00 ? Rd:
                            RegDst == 2'b01 ? Rt: 5'b11111; // RedDst 00-Rd 01-Rt 10-$31
    RegisterFile myRF(reset, clk, RegWrite, Rs, Rt, Write_register, Write_reg_data, Read_data1, Read_data2, v0, a0, sp, ra);

    // ALU
    wire [4:0] ALUCtrl;
    wire Sign;
    wire [31:0] in1;
    wire [31:0] in2;
    wire [31:0] out;
    wire zero;
    assign in1 = ALUSrc1 ? {17'b0, Shamt} : Read_data1; // ALUSrc1 0-Rs 1-Shamt
    assign in2 = ALUSrc2 ? (LuOp ? {imm, 16'b0} : imm_ext) : Read_data2;   // ALUSrc2 1-imm 0-rt
    ALUControl myALUC(OpCode, Funct, ALUCtrl, Sign);
    ALU myALU(ALUCtrl, Sign, in1, in2, out, zero);

    // Memory
    wire [31:0] Write_mem_data;
    wire [31:0] Read_mem_data;
    // lw rt = mem[R[rs] + Signext(imm)]
    assign Write_mem_data = Read_data2;
    DataMemory myDM(reset, clk, out, Write_mem_data, Read_mem_data, MemRead, MemWrite);

    // Write back to reg
    wire [31:0] PC_plus_4;
    assign Write_reg_data = MemtoReg == 2'b00 ? out :
                            MemtoReg == 2'b01 ? Read_mem_data : PC_plus_4;

    // Fetch instruction
    //reg [31:0] PC;
    wire [31:0] PC_next;
    
    always @(posedge reset or posedge clk)
    begin
        if(reset) PC <= 32'b0;
        else PC <= PC_next;
    end
    assign PC_plus_4 = PC + 4;
    assign PC_next = PCSrc == 2'b00 ? (zero && Branch ? PC_plus_4 + {imm_ext[29:0], 2'b00} : PC_plus_4):   // sequence
                    PCSrc == 2'b10 ? {PC_plus_4[31:28], Instruction[25:0], 2'b00}: Read_data1; 

    InstructionMemory myIM(PC, Instruction);

endmodule
	