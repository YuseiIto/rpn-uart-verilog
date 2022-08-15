module ring_buffer(clk,in,wen,out,ren,available);
input clk;
input [7:0] in;
input wen; // Write enable

output reg [0:7] out; // Output
input ren; // Read enable
output reg available; // Is not empty

localparam address_width = 4; // Address width. Change this to configure depth.
localparam depth = 2**address_width; // Do not change here. Depth has to be power of 2 to avoid modulo operation.


reg [0:7] buffer[0:depth-1];
reg [0:address_width-1] write_cursor;
reg [0:address_width-1] read_cursor;

initial begin
	out <=0;
	available <=0;
	write_cursor <= 0;
	read_cursor <= 0;
end

// WARN:This does NOT handle the buffer overflow
wire empty = (read_cursor == write_cursor);

always@(posedge clk)begin

	if(wen) begin
		buffer[write_cursor] <= in;
		write_cursor <= write_cursor + 1;
	end

	if(ren) begin
		if (empty) available <=0; // Does not pop data if empty
		else begin // Pop date and notify via available pin
			out <= buffer[read_cursor];
			read_cursor <= read_cursor + 1;
			available <=1;
		end
	end
	else 
		if(available) available <=0; // Available is set only for one cycle.
end


endmodule
