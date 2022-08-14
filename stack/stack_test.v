`timescale 1ns/1ps

module stack_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
reg wen;
reg [15:0] din;
reg [1:0] pop_cnt;
wire [15:0] first,second;

stack stack_inst(clk,wen,din,pop_cnt,first,second);

initial begin
	clk=0;
	wen=0;
	din=15'd1;
	pop_cnt=0;
	#10 // Simply push [] <- 1
		wen=1;
	#10 // Pop [] -> 1
		wen=0;
		pop_cnt=1;
	#10 // Simply push again [] <- 2
		wen=1;
		din=15'd2;
		pop_cnt=0;
	#10 // Simply push  more [2] <- 3
		wen=1;
		din=15'd3;
		pop_cnt=0;
	#10 // Push with 1 offset [2,3*] <-  4
		wen=1;
		din=15'd4;
		pop_cnt=1;
	#10 // Push with 2 offset [2*,4*] <-  5
		wen=1;
		pop_cnt=2;
		din=15'd5;
	#10 // [5]
		$finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("stack_test.vcd");
	$dumpvars(0, stack_inst);
end

endmodule
