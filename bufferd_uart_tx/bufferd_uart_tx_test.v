`timescale 1ns/1ps

module bufferd_uart_tx_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
parameter TIMESCALE_PER_BIT = 8681;

reg wen;
reg [7:0] din;

wire tx_out;
bufferd_uart_tx bufferd_tx (clk,din,wen,tx_out);

integer c; // Char index
initial begin
	clk=0;
	wen=0;
	#8
	din="A";
	wen=1;
	#8
	din="B";
	#8 wen=0;
	#(TIMESCALE_PER_BIT*2*15) $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("uart_tx.vcd");
	$dumpvars(0, bufferd_uart_tx_testbench);
end

endmodule
