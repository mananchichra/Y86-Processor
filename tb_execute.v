`include "execute.v"

module tb_execute;

reg clk,
reg [3:0] icode,
reg [3:0] ifun,
reg [63:0] valA,
reg [63:0] valB,
reg [63:0] valC,
wire [63:0] valE,
wire cnd,
wire ZF,
wire SF,
wire OF;

execute dut(clk,icode,ifun,valA,valB,valC,valE,cnd,ZF,SF,OF);

initial begin
    $dumpfile("execute_out.vcd");
    $dumpvars(0,tb_execute);
    clk = 1;
    forever begin
        #5
        clk = ~clk;
    end
end

always(@posedge clk)
begin
    $monitor("clk = %d , icode = %d , ifun = %d , valA = %d ,valB = %d ,valC = %d ,valE = %d ,cnd = %d, ZF = %d , SF = %d , OF = %d");

        icode = 11;
        valA = 

    end



endmodule