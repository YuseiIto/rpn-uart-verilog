module uart_tx(clk,din,wen,ready,tx_out);
input clk;
input [7:0] din;
input wen;

output reg ready;
output reg tx_out;

reg [7:0] tx_data;

reg baudrate_clk_en; // If runnning baudrate clk
wire baudrate_clk;
baudrate_clk_gen clk_gen_inst (clk,baudrate_clk_en,baudrate_clk);

reg [3:0] send_index; // Count up to 9 (1 startbit + 8 data bits + 1 stop bit)
wire [9:0] send_data = {1'b1,tx_data,1'b0}; // Start/stop bit.

initial begin
	ready=1;
	tx_out=1;
	send_index=0;
end

always@(posedge clk) begin
	if (ready && wen) begin
			tx_data<=din;
			ready<=0;

			// Start transmission
			baudrate_clk_en<=1;
			send_index<=0;
	end
end


always@(posedge baudrate_clk) begin
	tx_out<=send_data[send_index];
	if(send_index==10) begin
		send_index<=0;
		baudrate_clk_en<=0;
		ready<=1;
		tx_out<=1;
		end
	else 	send_index<=send_index+1;

end


endmodule
