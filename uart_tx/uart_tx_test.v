`timescale 1ns/1ps

module uart_tx_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
parameter TIMESCALE_PER_BIT = 8681;

reg [7:0] din;
reg wen;

wire ready;
wire tx_out;

uart_tx tx_inst(clk,din,wen,ready,tx_out);


initial begin
	clk=0;
	din= "A";
	wen=0;
	#(TIMESCALE_PER_BIT) wen=1;
	#8 wen=0;
	#(TIMESCALE_PER_BIT*11) din="0"; wen= 1;
	#8 wen=0;
	#(TIMESCALE_PER_BIT*11) $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("uart_tx.vcd");
	$dumpvars(0, tx_inst);
end

endmodule
