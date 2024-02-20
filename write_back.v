module writeBack(

input clk,
input [3:0] icode, 
input [3:0] rA,
input [3:0] rB,
input [63:0] valE,
input [63:0] valM,

// output reg [63:0] reg_file_0:4]);
output reg [63:0] reg_file_0,
output reg [63:0] reg_file_1,
output reg [63:0] reg_file_2,
output reg [63:0] reg_file_3,
output reg [63:0] reg_file_4,
output reg [63:0] reg_file_5,
output reg [63:0] reg_file_6,
output reg [63:0] reg_file_7,
output reg [63:0] reg_file_8,
output reg [63:0] reg_file_9,
output reg [63:0] reg_file_10,
output reg [63:0] reg_file_11,
output reg [63:0] reg_file_12,
output reg [63:0] reg_file_13,
output reg [63:0] reg_file_14);

reg [63:0] reg_memory [0:14];

initial 
    begin
        reg_memory[0] = 64'd0;
        reg_memory[1] = 64'd0;
        reg_memory[2] = 64'd0;
        reg_memory[3] = 64'd0;
        reg_memory[4] = 64'd0;
        reg_memory[5] = 64'd0;
        reg_memory[6] = 64'd0;
        reg_memory[7] = 64'd0;
        reg_memory[8] = 64'd0;
        reg_memory[9] = 64'd0;
        reg_memory[10] = 64'd0;
        reg_memory[11] = 64'd0;
        reg_memory[12] = 64'd0;
        reg_memory[13] = 64'd0;
        reg_memory[14] = 64'd0;

        // $dumpvars(0, reg_memory[2], reg_memory[3], reg_memory[4]);

    end

always @(*) begin

        reg_file_0 = reg_memory[0];
        reg_file_1 = reg_memory[1];
        reg_file_2 = reg_memory[2];
        reg_file_3 = reg_memory[3];
        reg_file_4 = reg_memory[4];
        reg_file_5 = reg_memory[5];
        reg_file_6 = reg_memory[6];
        reg_file_7 = reg_memory[7];
        reg_file_8 = reg_memory[8];
        reg_file_9 = reg_memory[9];
        reg_file_10 = reg_memory[10];
        reg_file_11 = reg_memory[11];
        reg_file_12 = reg_memory[12];
        reg_file_13 = reg_memory[13];
        reg_file_14 = reg_memory[14];      
    end

always@(posedge clk)
    begin
        case(icode)
        // halt (not sure if we have to include)
        4'b0000: begin end

        // nop
        1: begin end

        // cmovxx rA, rB
        2: begin reg_memory[rB] = valE; end

        // irmovq V, rB
        3: begin reg_memory[rB] = valE; end

        // rmmovq rA, D(rB)
        4: begin end

        // mrmovq D(rB), rA
        5: begin reg_memory[rA] = valM; end

        // Opq rA, rB
        6: begin reg_memory[rB] = valE; end

        // jXX Dest
        7: begin end

        // call Dest
        8: begin reg_memory[4] = valE; end

        // ret
        9: begin reg_memory[4] = valE; end

        // pushq rA
        10: begin reg_memory[4] = valE; end

        // popq rA
        11'b1011: 
        begin 
            reg_memory[4] = valE;
            reg_memory[rA] = valM;
        end
        endcase
    end

  
    
endmodule