`timescale 1ns/1ps

module alu_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
parameter OP_ADD = 4'd0, OP_SUB = 4'd1, OP_MUL = 4'd2, OP_DIV = 4'd3, OP_POP = 4'd4, OP_UNKKOWN = 4'hf;

reg [3:0] op;
reg [15:0] left,right;
wire [15:0] ans;
wire [1:0] arg_cnt;
alu alu_inst(op,left,right,ans,arg_cnt);

initial begin
	clk=0;
	op=OP_ADD;
	left=10;
	right=20;
	#10 
	 op=OP_SUB;
	 left=20;
	 right=10;
	#10
	 op=OP_MUL;
	 left=10;
	 right=20;
	#10
	 op=OP_DIV;
	 left=20;
	 right=10;
	#10
	 op=OP_POP;
	 left=10;
	 right=20;
	#10
	 op=OP_UNKKOWN;
	 left=10;
	 right=20;
	#10 $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("alu.vcd");
	$dumpvars(0, alu_inst);
end

endmodule

