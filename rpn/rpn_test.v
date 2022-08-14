`timescale 1ns/1ps

module rpn_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
parameter TIMESCALE_PER_BIT = 8681;
parameter OP_ADD = 4'd0, OP_SUB = 4'd1, OP_MUL = 4'd2, OP_DIV = 4'd3, OP_POP = 4'd4, OP_UNKKOWN = 4'hf;


reg op_en;
reg [3:0] op;
reg num_en;
reg [15:0] num;

wire [15:0] res_value;
wire res_ready;

rpn computer (clk,op_en,op,num_en,num,res_value,res_ready);

initial begin
		clk=0;
		op_en = 0;
		op = OP_UNKKOWN;
		num_en = 1;
		num = 16'd12;
	#8 num_en=0;
	#(TIMESCALE_PER_BIT-8)
		num_en = 1;
		num = 16'd2;
	#8 num_en=0;
	#(TIMESCALE_PER_BIT-8)
		op_en = 1;
		op = OP_ADD;
	#8 op_en=0;
	#(TIMESCALE_PER_BIT-8)
		num_en=1;
		num=16'd2;
	#8 num_en=0;
	#(TIMESCALE_PER_BIT-8)
		op_en=1;
		op=OP_MUL;
	#8 op_en=0;
	#(TIMESCALE_PER_BIT-8)
		op = OP_POP;
		op_en=1;
	#8 op_en=0; 
	#(TIMESCALE_PER_BIT*2) $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("rpn.vcd");
	$dumpvars(0, computer);
end

endmodule
