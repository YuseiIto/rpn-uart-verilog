`timescale 1ns/1ps

module op_controller_rx_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
parameter TIMESCALE_PER_BIT = 8681;
parameter OP_ADD = 4'd0, OP_SUB = 4'd1, OP_MUL = 4'd2, OP_DIV = 4'd3, OP_POP = 4'd4, OP_UNKKOWN = 4'hf;

reg is_op;
reg [1:0] arg_cnt;
reg [3:0] op;
wire [1:0] pop_cnt;
wire ans_ready;
wire print_ready;

op_controller op_ctrl_inst(clk,is_op,op,arg_cnt,pop_cnt,ans_ready,print_ready);

initial begin
		clk=0;
		is_op=0;
		op=OP_ADD;
		arg_cnt = 2'd2;
	#(TIMESCALE_PER_BIT) 
		is_op = 1;
	#(TIMESCALE_PER_BIT) 
		is_op = 0;
	#(TIMESCALE_PER_BIT)
		op = OP_POP;
		is_op=1;
	#(TIMESCALE_PER_BIT)
		is_op=0;
	#10 $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("op_controller.vcd");
	$dumpvars(0, op_ctrl_inst);
end

endmodule
