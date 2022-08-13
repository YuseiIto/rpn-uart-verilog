`timescale 1ns/1ps

module uart_rx_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
parameter TIMESCALE_PER_BIT = 8681;

reg rx_in;

wire [7:0] out;
wire ready;
uart_rx rx_inst(clk,rx_in,out,ready);

initial begin
	clk=0;
	rx_in=1;
	#(TIMESCALE_PER_BIT) rx_in = 0; // Start bit
	#(TIMESCALE_PER_BIT) rx_in = 1;
	#(TIMESCALE_PER_BIT) rx_in = 0;
	#(TIMESCALE_PER_BIT) rx_in = 0;
	#(TIMESCALE_PER_BIT) rx_in = 1;
	#(TIMESCALE_PER_BIT) rx_in = 0;
	#(TIMESCALE_PER_BIT) rx_in = 0;
	#(TIMESCALE_PER_BIT) rx_in = 1;
	#(TIMESCALE_PER_BIT) rx_in = 0;
	#(TIMESCALE_PER_BIT) rx_in = 1; //Stop bit
	#(TIMESCALE_PER_BIT*2) $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("uart_rx.vcd");
	$dumpvars(0, rx_inst);
end

endmodule
