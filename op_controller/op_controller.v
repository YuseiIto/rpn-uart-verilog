module op_controller(clk,is_op,op,arg_cnt,pop_cnt,ans_ready,print_ready);
	input clk;
	input is_op;
	input [3:0] op;
	input [1:0] arg_cnt;	

	output [1:0] pop_cnt;
	output reg ans_ready;
	output print_ready;

	parameter OP_ADD = 4'd0, OP_SUB = 4'd1, OP_MUL = 4'd2, OP_DIV = 4'd3, OP_POP = 4'd4, OP_UNKKOWN = 4'hf;

	reg prev_is_op;
	initial begin
		prev_is_op=0;
		ans_ready=0;
	end

	always@(posedge clk) begin
		if (is_op & ~prev_is_op) begin
			ans_ready<=1;
		end
		
	  if (ans_ready) ans_ready<=0;
		prev_is_op<=is_op;
	end

	assign pop_cnt=ans_ready?arg_cnt:0;	
	assign print_ready= (op==OP_POP) & ans_ready;

endmodule
