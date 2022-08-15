`timescale 1ns/1ps

module bufferd_uart_rx_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
parameter TIMESCALE_PER_BIT = 8681;


parameter INPUT_STRING="1 2 + \n";
parameter INPUT_STRING_LENGTH = 7;

integer c,b; // Char/Bit index

reg rx_in;
reg ren;
initial ren=0;

wire [7:0] out;
wire ready;
bufferd_uart_rx bufferd_rx (clk,rx_in,ren,out,ready);

reg [7:0] received_data; // Just for debuging
always@(posedge clk) begin
	if(ready)
		received_data <= out;
end

initial begin
	clk=0;
	rx_in=1;
	for (c=0;c<INPUT_STRING_LENGTH;c++) begin
		#(TIMESCALE_PER_BIT) rx_in = 0; // Start bit
		#8 
		for (b=0;b<8;b++) begin
			#(TIMESCALE_PER_BIT-8) rx_in = INPUT_STRING[(INPUT_STRING_LENGTH-1-c)*8+b];
			if (c>=INPUT_STRING_LENGTH-2) ren = 1;
			#8 ren=0;
		end
		#(TIMESCALE_PER_BIT) rx_in = 1; //Stop bit
	end
	#(TIMESCALE_PER_BIT*INPUT_STRING_LENGTH*10) $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("uart_rx.vcd");
	$dumpvars(0, bufferd_uart_rx_testbench);
end

endmodule
