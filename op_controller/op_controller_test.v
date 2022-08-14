`timescale 1ns/1ps

module op_controller_rx_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
parameter TIMESCALE_PER_BIT = 8681;
parameter OP_ADD = 4'd0, OP_SUB = 4'd1, OP_MUL = 4'd2, OP_DIV = 4'd3, OP_POP = 4'd4, OP_UNKKOWN = 4'hf;

reg op_en;
reg [1:0] arg_cnt;
reg [3:0] op;
wire [1:0] pop_cnt;
wire ans_ready;
wire print_ready;

op_controller op_ctrl_inst(op_en,op,arg_cnt,pop_cnt,print_ready);

initial begin
		clk=0;
		op_en=0;
		op=OP_ADD;
		arg_cnt = 2'd2;
	#10 
		op_en = 1;
	#10 
		op_en = 0;
	#10
		op = OP_POP;
		op_en=1;
	#10
		op_en=0;
	#10 $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("op_controller.vcd");
	$dumpvars(0, op_ctrl_inst);
end

endmodule
