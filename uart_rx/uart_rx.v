module uart_rx(clk,rx_in,out,ready);
/* clk has to be 125MHz to generate the correct baudrate */

input clk,rx_in;
output [7:0] out;
output reg ready;

reg [9:0] rx_data; // start bits + data + stop bit

reg baudrate_clk_en; // If runnning baudrate clk

reg [9:0] baudrate_clk_counter; // Count up to 542= 1085/2= ((1s / 115200 bps)/8ns)/2
parameter BAUDRATE_CLK_PERIOD = 1086; // 1085 = (1s / 115200 bps)/8ns, but odd number to avoid divisiob errors
reg baudrate_clk;

initial begin
	baudrate_clk_en = 0;
	baudrate_clk_counter = 0;
	baudrate_clk = 0;
	ready = 0;
end

always @(negedge rx_in) begin
	if (baudrate_clk_en==0) begin
		baudrate_clk_en<=1;
		rx_data<= 10'b1111111111; // Fill with 1 to detect start bit
	end
end


always@(posedge clk) begin
	if(baudrate_clk_en) begin
		// Baudrate counter
		if(baudrate_clk_counter < BAUDRATE_CLK_PERIOD/2) baudrate_clk_counter <= baudrate_clk_counter + 1;
		else begin
			baudrate_clk_counter<=0;
			baudrate_clk<=~baudrate_clk;
		end

		// Check if data is ready by start/stop bit
		if(~rx_data[9] & rx_data[0]) begin
			// Byte is ready
			ready <= 1;
			baudrate_clk_en<=0;
		end
	end

	if (ready) ready<=0; // Ready is high only for one clock cycle

end

always@(posedge baudrate_clk) begin 
 rx_data[0] <= rx_in;
 rx_data[1] <= rx_data[0];
 rx_data[2] <= rx_data[1];
 rx_data[3] <= rx_data[2];
 rx_data[4] <= rx_data[3];
 rx_data[5] <= rx_data[4];
 rx_data[6] <= rx_data[5];
 rx_data[7] <= rx_data[6];
 rx_data[8] <= rx_data[7];
 rx_data[9] <= rx_data[8];
end

// Remove stop/start bit. Pay attention to the bit order
assign out = {rx_data[1],rx_data[2],rx_data[3],rx_data[4],rx_data[5],rx_data[6],rx_data[7],rx_data[8]}; 
endmodule
