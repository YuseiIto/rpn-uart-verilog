module rpn_uart_computer(clk,rx_in,tx_out);
	input clk;
	input rx_in;

	output tx_out;

	wire op_ready;
	wire [3:0] op;
	wire num_ready;
	wire [15:0] num;

	iterpreter interpreter_inst(clk,rx_in,op_ready,op,num_ready,num);

	wire [15:0] res_value;
	wire res_ready;
	rpn rpn_inst(clk,op_ready,op,num_ready,num,res_value,res_ready);

	printer printer_inst (clk,res_ready,res_value,tx_out);
	
endmodule
