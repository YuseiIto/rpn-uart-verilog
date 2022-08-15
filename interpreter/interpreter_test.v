`timescale 1ns/1ps

module interpreter_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
parameter TIMESCALE_PER_BIT = 8681;


parameter INPUT_STRING="1 12 + 2 *\n";
parameter INPUT_STRING_LENGTH = 11;

integer c,b; // Char/Bit index

reg rx_in;

wire op_ready,num_ready;
wire [15:0] num;
wire [3:0] op;

iterpreter interpreter_inst (clk,rx_in,op_ready,op,num_ready,num);

initial begin
	clk=0;
	rx_in=1;
	for (c=0;c<INPUT_STRING_LENGTH;c++) begin
		#(TIMESCALE_PER_BIT) rx_in = 0; // Start bit
		#8 
		for (b=0;b<8;b++) begin
			#(TIMESCALE_PER_BIT) rx_in = INPUT_STRING[(INPUT_STRING_LENGTH-1-c)*8+b];
		end
		#(TIMESCALE_PER_BIT) rx_in = 1; //Stop bit
	end
	#(TIMESCALE_PER_BIT*INPUT_STRING_LENGTH*10) $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("interpreter.vcd");
	$dumpvars(0, interpreter_testbench);
end

endmodule
