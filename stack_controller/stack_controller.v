module stack_controller(push_din,push_en,ans_din,ans_en,op,dout,wen);
input push_en,ans_en;
input [3:0] op;
input [15:0] push_din,ans_din;

output [15:0] dout;
output wen;

parameter OP_ADD = 4'd0, OP_SUB = 4'd1, OP_MUL = 4'd2, OP_DIV = 4'd3, OP_POP = 4'd4, OP_UNKKOWN = 4'hf;

assign dout = push_en? push_din : ans_en? ans_din : 0;
assign wen = push_en | (ans_en && (op!=OP_POP));

endmodule
