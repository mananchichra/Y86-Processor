
module Sixty_Four_bit_adder(num1,num2,sum,control,overflow);
input [63:0] num1,num2;
input control;

output [63:0] sum;
wire [63:0] carry;
output overflow;

wire [63:0] w1,w2,w3,num2_change;

genvar i;
  generate
    for (i = 0; i < 64; i = i + 1) 
    begin
        xor x1(num2_change[i],num2[i],control); // xor of b
        xor x2(w1[i],num1[i],num2_change[i]);//xor of a and b'
        xor x3(sum[i],w1[i],i==0?control:carry[i-1]);//final sum using cin and second line
        and a1(w2[i],i==0?control:carry[i-1],w1[i]);
        and a2(w3[i],num1[i],num2_change[i]);
        or o1(carry[i],w2[i],w3[i]);

    end
  endgenerate
  assign overflow = carry[63]^sum[63];

endmodule


module ander_block(num1,num2,bit_wise_and);
input [63:0] num1, num2;

output [63:0] bit_wise_and;
genvar i;
    
  generate
    for (i = 0; i < 64; i = i + 1) 
    begin
        and a(bit_wise_and[i],num1[i],num2[i]);
    end
  endgenerate


endmodule

module xor_block(num1,num2,bit_wise_xor);
input [63:0] num1, num2;
input control;
output [63:0] bit_wise_xor,final;
genvar i;
    
  generate
    for (i = 0; i < 64; i = i + 1) 
    begin
        xor a(bit_wise_xor[i],num1[i],num2[i]);
        
    end
  endgenerate


endmodule




module final(num1,num2,control,overflow,out);
input [63:0] num1,num2;
input [1:0] control;
wire [63:0] add_sub,bitwise_and,bitwise_xor;
output overflow;
reg [63:0] FINAL;
output[63:0] out;


Sixty_Four_bit_adder ADDER(num1,num2,add_sub,control[0],overflow);
ander_block ANDER(num1,num2,bitwise_and);
xor_block XOR(num1,num2,bitwise_xor);     


always @*
    case (control)
      2'b00 , 2'b01:  begin 
        FINAL = add_sub;
      end
     
      2'b10: begin  
          FINAL = bitwise_and;
       end
      2'b11:begin   

         FINAL = bitwise_xor;
      end

       
    endcase

    assign out = FINAL;
endmodule