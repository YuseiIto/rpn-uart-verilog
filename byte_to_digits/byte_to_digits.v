module byte_to_digits(clk,din,wen,dout,leading_zero,sending);
input clk;
input [15:0] din;
input wen;
output reg [3:0] dout;
output reg sending;
output reg leading_zero;

reg [15:0] tmp;
reg [2:0] power;
reg finish;

initial begin
	sending = 0;
	dout = 0;
	tmp = 0;
	power = 0;
	finish = 0;
	leading_zero = 0;
end

always@(posedge clk) begin
	if (wen) begin
		tmp<=din%10**5;
		dout<=din/10**5;
		/* Since the number is 16 bit length,
		 & the first digit (din/10**5) is always zero and looks unnessessary at frist.
		 However, to make sure that the "sending" signal is not stuck at 1,
		 send a "definitely zero" msb */
		sending<=1;
		power<=4;
		leading_zero<=1;
	end

	if (power>0) begin
		dout<=tmp/10**power;

		if (leading_zero && tmp/10**power!=0) begin
			leading_zero<=0;
		end

		power<=power-1;
		tmp<= tmp%10**power;
	end
	else if (power==0 && sending)begin
		dout<=tmp;
		tmp<=0;
		finish <=1;
	end

	if (finish) begin
		sending<=0;
		finish<=0;
	end
end

endmodule
