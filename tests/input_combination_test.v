`timescale 1ns/1ps

module input_combination_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
parameter TIMESCALE_PER_BIT = 8681;

/* Input */
reg rx_in;


// Uart
wire [7:0] rx_recv;
wire rx_ready;
uart_rx rx_inst(clk,rx_in,rx_recv,rx_ready);

//Buffer
wire [7:0] buf_out;
wire fifo_set;
ring_buffer input_fifo(clk,rx_recv,rx_ready, buf_out,1'b1,fifo_set);

// Parse ASCII
wire is_space,is_op;
wire [3:0] op;
wire [3:0] digit;
parse_ascii parseASCII_inst(buf_out,is_space,is_op,digit,op);

// Digit sequence parser
wire number_ready;
wire [15:0] number; // Output

wire is_numseq= fifo_set & ~is_op & ~is_space;
digits_to_byte parseInt_inst (clk,digit,is_numseq,is_space,number_ready,number);


parameter START_BIT=1'b0, STOP_BIT=1'b1;
parameter [9:0] RX_1 = {STOP_BIT,"1",START_BIT};
parameter [9:0] RX_2 = {STOP_BIT,"2",START_BIT};
parameter [9:0] RX_SPACE = {STOP_BIT," ",START_BIT};
parameter [9:0] RX_PLUS = {STOP_BIT,"+",START_BIT};
parameter [9:0] RX_ENTER = {STOP_BIT,"\n",START_BIT};

parameter CHARSEQ_LENGTH=7;
parameter RX_BITSEQ_LENGTH=CHARSEQ_LENGTH*10;
parameter [RX_BITSEQ_LENGTH-1:0]RX_BITSEQ_REVERSE = {RX_ENTER,RX_PLUS,RX_SPACE,RX_2,RX_SPACE,RX_2,RX_1}; // `12 + 2 \n`

// Helper
reg [7:0] rx_bitseq_index;

initial begin
	clk=0;
	rx_in=1;
	rx_bitseq_index=0;
	#(TIMESCALE_PER_BIT*2)
	repeat (RX_BITSEQ_LENGTH) begin
		#(TIMESCALE_PER_BIT) rx_in=RX_BITSEQ_REVERSE[rx_bitseq_index];
		rx_bitseq_index = rx_bitseq_index + 1;
	end
	#(TIMESCALE_PER_BIT*3) $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("input_test.vcd");
	$dumpvars(0, rx_inst);
	$dumpvars(0, input_fifo);
	$dumpvars(0, parseASCII_inst);
	$dumpvars(0, parseInt_inst);
end

endmodule
