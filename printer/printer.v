module printer(clk,print_en,value,tx_out);
input clk;
input print_en;
input [15:0] value;

output tx_out;

wire [7:0] ascii;
wire ascii_ready;

println writer(clk,value,print_en,ascii,ascii_ready);
bufferd_uart_tx tx(clk,ascii,ascii_ready,tx_out);

endmodule
