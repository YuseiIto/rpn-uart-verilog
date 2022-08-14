module stack(clk,wen,din,pop_cnt,first,second);
input clk,wen;
input [1:0] pop_cnt;
input [15:0] din;
output [15:0] first,second;

parameter STACK_ADDR_WIDTH=5;
parameter STACK_DEPTH=2**STACK_ADDR_WIDTH;

reg [15:0] content[0:STACK_DEPTH-1];

reg [STACK_ADDR_WIDTH-1:0] sp;
assign first=content[sp-1];
assign second=sp>1 ? content[sp-2] : 0;

initial begin
	sp <= 0;
end

always@(posedge clk) begin

	if (sp>=pop_cnt) begin
		if(wen && sp<STACK_DEPTH) begin
				content[sp-pop_cnt] <= din;
				sp<=sp-pop_cnt+1;
		end else sp<=sp-pop_cnt;
	end
end

endmodule
