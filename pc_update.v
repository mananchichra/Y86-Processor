module pc_update(clk, icode, cnd, valC, valM, valP, PC_new);

input cnd;
input clk;
input [3:0] icode;
input [63:0] valC, valM, valP;

output reg [63:0] PC_new;

always@(*)
    begin
        // jXX instruction
        if(icode == 4'b0111)
        begin
            if(cnd)
                PC_new = valC;
            else
                PC_new = valP;
        end

        // call
        else if(icode == 4'b1000)
        begin 
            PC_new = valC; 
        end
        
        // ret
        else if(icode == 4'b1001) 
        begin 
            PC_new = valM; 
        end

        // by default we use valP
        else
        begin 
            PC_new = valP; 
        end
        
    end

endmodule