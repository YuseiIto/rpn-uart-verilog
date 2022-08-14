`timescale 1ns/1ps

module digit_to_byte_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
reg [3:0] digit;
reg wen,flush;
wire ready;
wire [15:0] dout;

digits_to_byte parser_inst (clk,digit,wen,flush,ready,dout);

initial begin
	clk=0;
	digit=0;
	wen =0;
	flush =0;
	#10 wen = 1;
			digit = 1;
	#(CLK_PERIOD) wen = 0;
	#2 wen=1;
		 digit = 2;
	#(CLK_PERIOD) wen = 0;
	#2 wen=1;
		 digit = 3;
	#(CLK_PERIOD) wen = 0;
	#2 flush = 1;
	#(CLK_PERIOD) flush = 0; // 123
	#2 wen=1;
		 digit = 4;
	#(CLK_PERIOD) wen = 0;
	#2 flush=1;
	#(CLK_PERIOD) flush = 0; // 4
	#2 flush=0;
	#10 $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("digit_to_byte.vcd");
	$dumpvars(0, parser_inst);
end

endmodule
