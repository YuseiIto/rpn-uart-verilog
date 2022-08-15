module bufferd_uart_tx(clk,din,wen,tx_out);

input clk;
input [7:0] din;
input wen;

output tx_out;

wire [7:0] send_data;
wire tx_ready;
wire data_ready;

assign ren = tx_ready&~data_ready; // Use ~data_ready to avoid sending data before tx's busy flag set

ring_buffer buffer(clk,din,wen,send_data,ren,data_ready);
// module ring_buffer(clk,in,wen,out,ren,available);
uart_tx tx(clk,send_data,data_ready,tx_ready,tx_out);

endmodule
