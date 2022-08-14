`timescale 1ns/1ps

module println_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
reg [15:0] byte_in;
reg wen;

wire [7:0] dout;
wire ready;

println inst (clk,byte_in,wen,dout,ready);

initial begin
	clk=0;
	byte_in=0;
	wen=0;
	#10
		byte_in=16'd65535;
		wen=1;
	#8
		wen=0;
	#100 
		wen=1;
		byte_in=16'd123;
	#8 
		wen=0;
	#100 $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("println.vcd");
	$dumpvars(0, inst);
end

endmodule
