`timescale 1ns/1ps

module baudrate_clk_gen_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
reg inst;
reg en;
wire baudrate_clk;
baudrate_clk_gen baudrate_clk_inst (clk,en,baudrate_clk);

parameter TIMESCALE_PER_BIT = 8681;

initial begin
	clk=0;
	en=0;
	#(TIMESCALE_PER_BIT*5) en = 1;
	#(TIMESCALE_PER_BIT*5) $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("baudrate_clk.vcd");
	$dumpvars(0, baudrate_clk_inst);
end

endmodule
