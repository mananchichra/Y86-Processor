`include "alu.v" // correct this before testing

module execute(
input clk,
input [3:0] icode,
input [3:0] ifun,
input [63:0] valA,
input [63:0] valB,
input [63:0] valC,
output reg [63:0] valE,
output reg cnd,
output reg ZF,output reg SF,output reg OF);

reg [1:0] control;
reg signed [63:0] aluA;
reg signed [63:0] aluB;
reg signed [63:0] ans;

wire signed [63:0] out;
wire overflow;



always @(*)
    begin
        cnd = 0;
        // ZF = 0; OF = 0; SF=0; not sure right now

        case(icode)
        // halt 
        4'b0000: begin end

        // nop
        4'b0001: begin end

        // cmovXX rA, rB
        4'b0010:
        begin            
            case(ifun)
            // rrmovq
            4'b0000: 
            begin 
                cnd = 1; // unconditional move instr              
            end
                
            // cmovle
            4'b0001: 
            begin
                cndA = SF; cndB = OF;
                cndA = xor_out; cndB = ZF;
                if(or_out)
                    cnd = 1;
            end

            // cmovl
            4'b0010: 
            begin 
                cndA = SF; cndB = OF;
                if(xor_out)
                    cnd = 1;
            end

            // cmove
            4'b0011: 
            begin 
                if(ZF)
                    cnd = 1;
            end

            // cmovne
            4'b0100: 
            begin 
                cndA = ZF;
                if(not_out)
                    cnd = 1;
            end

            // cmovge
            4'b0101: 
            begin 
                cndA = SF;
                cndB = OF;
                cndA = xor_out;
                if(not_out)
                    cnd = 1;
            end

            // cmovg
            4'b0110: 
            begin 
                cndA = SF; cndB = OF;
                cndA = xor_out;
                if(not_out)
                    begin
                        cndA = ZF;
                        if(not_out)
                            cnd = 1;
                    end
            end
            endcase
            aluA = valA;
            aluB = 0;
            control = 0; // valE = valA + 0
        end

        // irmovq V, rB
        4'b0011: 
        begin 
            // valE = 0 + valC
            aluA = valC;
            aluB = 64'd0;
            control = 0;
        end

        // rmmovq rA, D(rB)
        4'b0100: 
        begin 
            // valE = valB + valC
            aluA = valC;
            aluB = valB;
            control = 0;
        end

        // mrmovq D(rB), rA
        4'b0101: 
        begin 
            // valE = valB + valC
            aluA = valC;
            aluB = valB;
            control = 0;
        end

        // Opq rA, rB
        4'b0110: 
        begin
            aluA = valA;
            aluB = valB;

            case(ifun)
            
            4'b0000: 
            begin 
                control = 0; //addq
            end

            
            4'b0001: 
            begin 
                control = 1; // subq
            end

            
            4'b0010: 
            begin 
                control = 2; // andq
            end

           
            4'b0011: 
            begin 
                control = 3;  // xorq
            end
            endcase
        end

        // jXX Dest
        4'b0111:
        begin
            case(ifun)
            // jmp
            4'b0000: 
            begin 
                cnd = 1; // unconditional jump
            end

            // jle
            4'b0001: 
            begin 
                cndA = SF; cndB = OF;
                cndA = xor_out; cndB = ZF;
                if(or_out)
                    cnd = 1;
            end

            // jl
            4'b0010: 
            begin 
                cndA = SF; cndB = OF;
                if(xor_out)
                    cnd = 1;
            end

            // je
            4'b0011:
            begin 
                if(ZF)
                    cnd = 1;
            end

            // jne
            4'b0100: 
            begin 
                cndA = ZF;
                if(not_out)
                    cnd = 1;
            end

            // jge
            4'b0101: 
            begin 
                cndA = SF;
                cndB = OF;
                cndA = xor_out;
                if(not_out)
                    cnd = 1;
            end

            // jg
            4'b0110: 
            begin 
                cndA = SF; cndB = OF;
                cndA = xor_out;
                cndA = not_out;
                if(not_out)
                    begin
                        cndA = ZF;
                        if(not_out)
                            cnd = 1;
                    end
            end
            endcase
        end 

        // call Dest
        4'b1000: 
        begin 
            // valE = valB - 8
            aluA = -8;
            aluB = valB;
            control = 0; // to decrement the stack pointer by 8 on call
        end

        // ret
        4'b1001: 
        begin 
            // valE = valB + 8
            aluA = 8;
            aluB = valB;
            control = 0; // to increment the stack pointer by 8 on ret
        end

        // pushq rA
        4'b1010: 
        begin 
            // valE = valB - 8
            aluA = -8;
            aluB = valB;
            control = 0; // to decrement the stack pointer by 8 on pushq
        end

        // popq rA
        4'b1011: 
        begin 
            // valE = valB + 8
            aluA = 8;
            aluB = valB;
            control = 0; // to increment the stack pointer by 8 on popq
        end
        endcase
        // ans = out;
        // valE = ans;
        valE = out;
    end

final alu(aluA, aluB,control,overflow, out);

always @(out or aluA or aluB)
    begin
        ZF = (out == 0); 
        SF = (out < 64'b0); 
        OF = (aluA < 1'b0 == aluB < 1'b0) && (out < 64'b0 != aluA < 1'b0); 
    end

reg cndA;
reg cndB;
reg xor_out;
reg and_out;
reg or_out;
reg not_out;

always @(cndA or cndB)
    begin
        // and A1(and_out, cndA, cndB);
        // or O1(or_out, cndA, cndB);
        // xor X1(xor_out, cndA, cndB);
        // not N1(not_out, cndA);
        and_out = cndA & cndB;
        or_out = cndA | cndB;
        xor_out = cndA ^ cndB;
        not_out = ~cndA;
    end
endmodule