module op_controller(clk,is_op,arg_cnt,pop_cnt,ans_ready);
	input clk;
	input is_op;
	input [1:0] arg_cnt;
	
	output [1:0] pop_cnt;
	output reg ans_ready;

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
endmodule
