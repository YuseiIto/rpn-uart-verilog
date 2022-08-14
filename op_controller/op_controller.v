module op_controller(op_en,op,arg_cnt,pop_cnt,print_ready);
	input op_en;
	input [3:0] op;
	input [1:0] arg_cnt;	

	output [1:0] pop_cnt;
	output print_ready;

	parameter OP_ADD = 4'd0, OP_SUB = 4'd1, OP_MUL = 4'd2, OP_DIV = 4'd3, OP_POP = 4'd4, OP_UNKKOWN = 4'hf;

	assign pop_cnt=op_en?arg_cnt:0;	
	assign print_ready= (op==OP_POP) & op_en;

endmodule
