
`timescale 1ns/1ps

module byte_to_digits_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */

reg [15:0] din;
reg wen;

wire [3:0] dout;
wire sending;
wire leading_zero;

byte_to_digits encoder (clk,din,wen,dout,leading_zero,sending);

initial begin
	clk=0;
	din=16'd123;
	wen=0;
	#10 wen=1;
	#8 wen=0;
	#50 wen=1;
		  din=16'd65535;
	#8 wen=0;
	#50 $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("byte_to_digits.vcd");
	$dumpvars(0, encoder);
end

endmodule
