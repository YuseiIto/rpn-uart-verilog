module bufferd_uart_rx(clk,rx_in,ren,out,data_ready);

input clk,rx_in,ren;
output [7:0] out;
output data_ready;

wire rx_ready;
wire [7:0] recv_data;

uart_rx uart(clk,rx_in,recv_data,rx_ready);
ring_buffer buffer(clk,recv_data,rx_ready,out,ren,data_ready);

endmodule
