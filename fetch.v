module fetch(input [63:0] PC, 
input clk,
output reg [3:0] icode,
output reg [3:0] ifun,
output reg [3:0] rA,
output reg [3:0] rB,
output reg [63:0] valC,
output reg [63:0] valP,
output reg invalid_instr,
output reg dmem,
output reg halt
);
reg [7:0] instr_mem[127:0];

initial begin
    $readmemb("1.txt",instr_mem);


end

// always @(posedge clk)
// begin
//     halt <= 0;

// if(PC>=0 && PC<=128)
//     begin
//     icode = instr_mem[PC][7:4];
//     ifun  = instr_mem[PC][3:0];
//     invalid_instr <= 0;
//     dmem <= 0;
//     end

//     else 
//         begin
//         invalid_instr <= 1;
//         dmem <= 1;
//         end
// end

always @(*)
begin    
    dmem = 0;
    halt <= 0;

    if(PC>=0 && PC<=128)
    begin
    icode <= instr_mem[PC][7:4];
    ifun  <= instr_mem[PC][3:0];
    invalid_instr <= 0;
    
    end

    else 
        begin
        invalid_instr <= 1;
        dmem <= 1;
        end



    if(icode == 1)
    begin
        halt <= 1;
    end
    //    opq         popq        cmov
    else if(icode==6 || icode ==11 || icode ==2)
        begin
        valP <= PC +2;
        rB <= instr_mem[PC+1][3:0];
        rA <= instr_mem[PC+1][7:4];
        end
     //rmmovq
    else if(icode==4)
        begin 
        valP <= PC + 10;
        valC <= {instr_mem[PC+2],instr_mem[PC+3],instr_mem[PC+4],instr_mem[PC+5],instr_mem[PC+6],instr_mem[PC+7],instr_mem[PC+8],instr_mem[PC+9]};
        // valC[7:0] <= instr_mem[PC+2];
        // val[15:8] <= instr_mem[PC+3];
        // valC[23:16] <= instr_mem[PC+4];
        // val[31:24] <= instr_mem[PC+5];
        // valC[39:32] <= instr_mem[PC+6];
        // val[47:40] <= instr_mem[PC+7];
        // valC[55:48] <= instr_mem[PC+8];
        // val[63:56] <= instr_mem[PC+9];

        rB <= instr_mem[PC+1][3:0];
        rA <= instr_mem[PC+1][7:4];
        end
    else if(icode==3)
        begin
            valP <= PC + 10;
            // valC <= {instr_mem[PC+2], instr_mem[PC+3], instr_mem[PC+4], instr_mem[PC+5], instr_mem[PC+6], instr_mem[PC+7], instr_mem[PC+8], instr_mem[PC+9]};
            valC[7:0] <= instr_mem[PC+2];
            valC[15:8] <= instr_mem[PC+3];
            valC[23:16] <= instr_mem[PC+4];
            valC[31:24] <= instr_mem[PC+5];
            valC[39:32] <= instr_mem[PC+6];
            valC[47:40] <= instr_mem[PC+7];
            valC[55:48] <= instr_mem[PC+8];
            valC[63:56] <= instr_mem[PC+9];
            rA <= 0; 
            rB <= instr_mem[PC+1][3:0];
        end

    else if(icode==5)
        begin 
            valP <= PC + 10;
            valC <= {instr_mem[PC+2], instr_mem[PC+3], instr_mem[PC+4], instr_mem[PC+5], instr_mem[PC+6], instr_mem[PC+7], instr_mem[PC+8], instr_mem[PC+9]};
            rB <= instr_mem[PC+1][3:0];
            rA <= instr_mem[PC+1][7:4];
        end
    else if(icode==7)
     begin
            valP <= PC+9;
            valC <= {instr_mem[PC+2], instr_mem[PC+3], instr_mem[PC+4], instr_mem[PC+5], instr_mem[PC+6], instr_mem[PC+7], instr_mem[PC+8], instr_mem[PC+9]};

     end
    else if(icode==11)
        begin
        valP <= PC+2;
        rB <= instr_mem[PC+1][3:0];
        rA <= instr_mem[PC+1][7:4];
        end
    else if(icode==8)
        begin
            valP<=PC +9;
            valC<={instr_mem[PC+2], instr_mem[PC+3], instr_mem[PC+4], instr_mem[PC+5], instr_mem[PC+6], instr_mem[PC+7], instr_mem[PC+8], instr_mem[PC+9]};
        end
end
endmodule 




    
    





