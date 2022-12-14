module byte_to_digits(clk,din,wen,dout,leading_zero,sending);
input clk;
input [15:0] din;
input wen;
output reg [3:0] dout;
output reg sending;
output reg leading_zero;

reg [15:0] tmp;

initial begin
	sending = 0;
	dout = 0;
	tmp = 0;
	leading_zero = 0;
end

reg [15:0] div_num;

always@(posedge clk) begin
	if (wen) begin
		tmp<=din%10**5;
		dout<=din/10**5;
		/* Since the number is 16 bit length,
		 & the first digit (din/10**5) is always zero and looks unnessessary at frist.
		 However, to make sure that the "sending" signal is not stuck at 1,
		 send a "definitely zero" msb */
		sending<=1;
		div_num<=10**4;
		leading_zero<=1;
	end

	if (div_num>0) begin
		dout<=tmp/div_num;

		if (leading_zero && tmp/div_num!=0) begin
			leading_zero<=0;
		end

		div_num<=div_num/10;
		tmp<= tmp%div_num;
	end
	else if (div_num==0 && sending)begin
		dout<=tmp;
		tmp<=0;
		sending<=0;
	end
end

endmodule
