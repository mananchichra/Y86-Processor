module decode(input clk,input[3:0] icode,input[3:0] rA,input[3:0] rB,output reg[63:0] valA,output reg[63:0] valB
,input [63:0]reg_mem_0
,input [63:0]reg_mem_1
,input [63:0]reg_mem_2
,input [63:0]reg_mem_3
,input [63:0]reg_mem_4
,input [63:0]reg_mem_5
,input [63:0]reg_mem_6
,input [63:0]reg_mem_7
,input [63:0]reg_mem_8
,input [63:0]reg_mem_9
,input [63:0]reg_mem_10
,input [63:0]reg_mem_11
,input [63:0]reg_mem_12
,input [63:0]reg_mem_13
,input [63:0]reg_mem_14);


reg [63:0] registers [0:14];

always @ (*)  
    begin
        registers[0] = reg_mem_0;
        registers[1] = reg_mem_1;
        registers[2] = reg_mem_2;
        registers[3] = reg_mem_3;
        registers[4] = reg_mem_4 ;//sp
        registers[5] = reg_mem_5;
        registers[6] = reg_mem_6;
        registers[7] = reg_mem_7;
        registers[8] = reg_mem_8;
        registers[9] = reg_mem_9;
        registers[10] = reg_mem_10;
        registers[11] = reg_mem_11;
        registers[12] = reg_mem_12;
        registers[13] = reg_mem_13;
        registers[14] = reg_mem_14;

        
        // halt (not sure to include or not)
        if(icode == 0)
        begin end

        // nop
        else if(icode == 1) begin end

        // cmovxx rA, rB
        else if(icode == 2)
        begin 
            valA = registers[rA];
        end

        // irmovq V, rB
        else if(icode == 3)
        begin end

        // rmmovq rA, D(rB)
        else if(icode == 4)
        begin 
            valA = registers[rA];
            valB = registers[rB];
        end
            
        // mrmovq D(rB), rA
        else if(icode == 5)
        begin 
            valB = registers[rB];
        end

        // Opq rA, rB
        else if(icode == 6) 
        begin 
            valA = registers[rA];
            valB = registers[rB];
        end

        // jXX Dest
        else if(icode == 7)
        begin end

        // call Dest
        else if(icode == 8) 
        begin 
            valB = registers[4];
        end

        // ret
        else if(icode == 9)
        begin 
            valA = registers[4];
            valB = registers[4];
        end

        // pushq rA
        else if(icode == 10)
        begin 
            valA = registers[rA];
            valB = registers[4];
        end

        // popq rA
        else if(icode == 11) 
        begin 
            valA = registers[4];
            valB = registers[4];
        end
        
    end
endmodule