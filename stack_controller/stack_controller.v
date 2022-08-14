module stack_controller(push_din,push_en,ans_din,ans_en,dout,wen);
input push_en,ans_en;
input [15:0] push_din,ans_din;

output [15:0] dout;
output wen;

assign dout = push_en? push_din : ans_en? ans_din : 0;
assign wen = push_en | ans_en;

endmodule
