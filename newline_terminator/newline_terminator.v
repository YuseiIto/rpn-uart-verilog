module newline_terminator(clk,sending,buf_din,ready);
input clk,sending;
output [7:0] buf_din;
output reg ready;

assign buf_din="\n";

reg prev_sending;

initial begin
	prev_sending = 0;
	ready =0;
end

always @(posedge clk) begin
	if (prev_sending&~sending) begin
		ready <= 1;
	end

	if (ready) ready<=0;
	prev_sending<=sending;

end

endmodule
