`timescale 1ns/1ps

module printer_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
parameter TIMESCALE_PER_BIT = 8681;


reg print_en;
reg [15:0] value;

wire tx_out;

printer printer_inst(clk,print_en,value,tx_out);

initial begin
	clk=0;
	value=16'd10;
	print_en=0;
	#(TIMESCALE_PER_BIT) print_en=1;
	#8 print_en=0;
	#(TIMESCALE_PER_BIT) value= 16'd30;
	print_en=1;
	#8 print_en=0;
	#(TIMESCALE_PER_BIT*6*14) $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("printer.vcd");
	$dumpvars(0, printer_testbench);
end

endmodule
