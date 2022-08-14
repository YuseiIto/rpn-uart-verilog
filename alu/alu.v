module alu(op,left,right,ans,arg_cnt);
input [3:0] op;
input [15:0] left,right;
output [15:0] ans;
output [1:0] arg_cnt;

parameter OP_ADD = 4'd0, OP_SUB = 4'd1, OP_MUL = 4'd2, OP_DIV = 4'd3, OP_POP = 4'd4, OP_UNKKOWN = 4'hf;

assign is_op_add = op == OP_ADD;
assign is_op_sub = op == OP_SUB;
assign is_op_mul = op == OP_MUL;
assign is_op_div = op == OP_DIV;
assign is_op_pop = op == OP_POP;

assign ans = is_op_add ? (left+right) :
						 is_op_sub ? (left-right) :
						 is_op_mul ? (left*right) :
						 is_op_div ? (left/right) :
						 is_op_pop ? (right) :
						 left;

assign arg_cnt = is_op_add ? 2'd02 :
						 is_op_sub ? 2'd02 :
						 is_op_mul ? 2'd02 :
						 is_op_div ? 2'd02 :
						 is_op_pop ? 2'd01 :
						 2'b00;

endmodule
