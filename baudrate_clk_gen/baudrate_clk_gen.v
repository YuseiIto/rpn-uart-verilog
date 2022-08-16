module baudrate_clk_gen(clk,en,baudrate_clk);

input clk,en;
output reg baudrate_clk;

reg [6:0] clk_counter; // Count up to 108 = 217/2
parameter BAUDRATE_CLK_PERIOD = 217; // 25MHz / 115200 bps = 217

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
