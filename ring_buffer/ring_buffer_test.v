`timescale 1ns/1ps

module ring_buffer_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
reg [7:0] in;
reg write_en;
reg read_en;
wire [7:0] out;
wire available;

ring_buffer fifo(clk,in,write_en, out,read_en,available);

initial begin
	clk=0;
	in=0;
	write_en=0;
	read_en=0;
	#10 in<=10;
			write_en<=1;
	#(CLK_PERIOD) in<=9;
	#(CLK_PERIOD) in<=8;
	#(CLK_PERIOD) in<=7;
	#(CLK_PERIOD) in<=6;
		read_en=1;
	#(CLK_PERIOD) in<=5;
	#(CLK_PERIOD) in<=4;
	#(CLK_PERIOD) in<=3;
	#(CLK_PERIOD) in<=2; // Final valid input data
	#(CLK_PERIOD) in<=1; 
		write_en=0;
	#(CLK_PERIOD) in<=11;
	#100 $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("fifo.vcd");
	$dumpvars(0, fifo);
end

endmodule
