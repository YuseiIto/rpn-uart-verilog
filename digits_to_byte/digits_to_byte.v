module digits_to_byte(clk,digit,wen,flush,ready,dout);
/* Parse series of decimal digits to number */

input clk;
input [3:0] digit; // Decimal digit as number. 0-9
input wen; // DO NOT set longer than 1 cycle
input flush; 
output reg ready;
output reg [15:0] dout;

reg [15:0] temp;

reg last_flush;

initial begin
	temp = 0;
	ready = 0;
	last_flush=0;
end

always @(posedge clk) begin
		if(flush& ~last_flush) begin
				temp<=0;
				dout<= temp;
				ready <= 1;
		end
		else if(wen) temp <= digit + (temp*10);

		if (ready) ready<=0;
		last_flush<=flush;
end

endmodule
