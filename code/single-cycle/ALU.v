module ALU(
    input [4:0] ALUCtrl,
    input Sign,
    input [31:0] in1,
    input [31:0] in2,
    output reg [31:0] out,
    output reg zero
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
        out <= 32'b0;
        zero <= 1'b0;
    end

    always@* 
    begin
        case(ALUCtrl)
            ADD: begin
                out <= in1 + in2;
                zero <= 1'b0;
            end
            SUB: begin
                out <= in1 - in2;
                if(in1 == in2) zero <= 1'b1;
                else zero <= 1'b0;
            end
            AND: begin
                out <= in1 & in2;
                zero <= 1'b0;
            end
            OR: begin
                out <= in1 | in2;
                zero <= 1'b0;
            end
            XOR: begin
                out <= in1 ^ in2;
                zero <= 1'b0;
            end
            NOR: begin
                out <= ~(in1 | in2);
                zero <= 1'b0;
            end
            SL: begin
                out <= in2 << in1;
                zero <= 1'b0;
            end
            SR: begin
                if(Sign) out <= $signed(in2) >>> $signed(in1);
                else out <= in2 >> in1;
                zero <= 1'b0;
            end
            COMP: begin
                if(Sign) out <= $signed(in1) < $signed(in2) ;
                else out <= in1 < in2;
                zero <= 1'b0;
            end
            default: begin
                out <= 32'b0;
                zero <= 1'b0;
            end
        endcase
    end

endmodule