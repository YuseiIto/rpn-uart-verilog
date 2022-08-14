module println(clk,byte_in,wen,dout,ready);
input clk;
input [15:0] byte_in;
input wen;

output [7:0] dout;
output ready;

wire [3:0] digit;
wire [7:0] digit_ascii,lf_ascii;
wire lf_ready;

wire sending;
wire leading_zero;

byte_to_digits encoder(clk,byte_in,wen,digit,leading_zero,sending);
digit_to_ascii serializer(digit,digit_ascii);
newline_terminator lf(clk,sending,lf_ascii,lf_ready);

assign ready = (sending&~leading_zero) | lf_ready;
assign dout = sending ? digit_ascii : lf_ascii;
endmodule
