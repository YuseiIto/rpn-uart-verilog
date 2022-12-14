module uart_rx(clk,rx_in,out,ready);
/* clk has to be 25MHz to generate the correct baudrate */

input clk,rx_in;
output [7:0] out;
output reg ready;

reg [9:0] rx_data; // start bits + data + stop bit

reg baudrate_clk_en; // If runnning baudrate clk
wire baudrate_clk;
baudrate_clk_gen clk_gen_inst (clk,baudrate_clk_en,baudrate_clk);

reg prev_rx_in;
reg prev_baudrate_clk;

initial begin
	baudrate_clk_en = 0;
	ready = 0;
	prev_rx_in=0;
	prev_baudrate_clk<=0;
end

always@(posedge clk) begin
	if(baudrate_clk_en) begin
		// Check if data is ready by start/stop bit
		if(~rx_data[9] & rx_data[0]) begin
			// Byte is ready
			ready <= 1;
			baudrate_clk_en<=0;
		end else if(~prev_baudrate_clk&&baudrate_clk) begin
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

	end else if (prev_rx_in&&~rx_in && baudrate_clk_en==0) begin // negedge rx_in
		baudrate_clk_en<=1;
		rx_data <= 10'b1111111111;
	end
  
	if (ready) ready<=0; // Ready is high only for one clock cycle
	prev_rx_in<=rx_in;
	prev_baudrate_clk<=baudrate_clk;
end

// Remove stop/start bit. Pay attention to the bit order
assign out = {rx_data[1],rx_data[2],rx_data[3],rx_data[4],rx_data[5],rx_data[6],rx_data[7],rx_data[8]}; 
endmodule
