module baudrate_clk_gen(clk,en,baudrate_clk);

input clk,en;
output reg baudrate_clk;

reg [9:0] clk_counter; // Count up to 542= 1085/2= ((1s / 115200 bps)/8ns)/2
parameter BAUDRATE_CLK_PERIOD = 1086; // 1085 = (1s / 115200 bps)/8ns, but odd number to avoid division errors

initial begin
		clk_counter = 0;
		baudrate_clk = 0;
end


// Baudrate clk
always@(posedge clk) begin
	if(en) begin
		if(clk_counter < BAUDRATE_CLK_PERIOD/2) clk_counter <= clk_counter + 1;
		else begin
			clk_counter<=0;
			baudrate_clk<=~baudrate_clk;
		end
	end else begin
		clk_counter<=0;
		baudrate_clk<=0;
	end
end


endmodule
