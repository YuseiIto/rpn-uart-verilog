`timescale 1ns/1ps

module uart_rx_testbench();

/* Test bench common setup */
parameter CLK_PERIOD = 8; // Clock period in timescale(1ns in this case)
reg clk;
always #(CLK_PERIOD/2) clk = ~clk;


/* Testbench body */
reg [15:0] push_din,ans_din;
reg push_en,ans_en;

wire [15:0] dout;
wire wen;

stack_controller stack_ctrl_inst(push_din,push_en,ans_din,ans_en,dout,wen);

initial begin
		push_din=15'd10;
		push_en=0;
		ans_din=15'd20;
		ans_en=0;
	#10  // Push mode
		push_en=1;
		ans_en=0;
	#10  // Ansewr mode
		push_en=0;
		ans_en=1;
	#10 // Standby mode
		push_en=0;
		ans_en=0;
	#10 $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("stack_controller.vcd");
	$dumpvars(0, stack_ctrl_inst);
end

endmodule
