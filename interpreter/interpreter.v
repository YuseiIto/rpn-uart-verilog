module iterpreter(clk,rx_in,op_ready,op,num_ready,num);
input clk,rx_in;

output op_ready;
output [3:0] op;
output num_ready;
output [15:0]num;

wire buf_read_en=1; // Read buffer permanently

wire [7:0] ascii_buf_out;
wire buf_ready;

bufferd_uart_rx bufferd_rx (clk,rx_in,buf_read_en,ascii_buf_out,buf_ready);

wire is_space,is_op;
wire [3:0] digit;

reg flush;
reg prev_is_op,prev_is_space;

always@(posedge clk) begin
	prev_is_op<=is_op;
	prev_is_space<=is_space;
	if(flush) flush<=0;
	else if (~prev_is_space&& is_space && ~prev_is_op) flush<=1;
end

parse_ascii ascii_parser(ascii_buf_out,is_space,is_op,digit,op);
digits_to_byte decimal_parser(clk,digit,buf_ready&~is_op&~is_space,flush,num_ready,num);

assign op_ready=is_op&buf_ready;


endmodule

