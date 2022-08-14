module digit_to_ascii(digit,ascii);
input [3:0] digit;
output [7:0] ascii;
	assign ascii="0"+digit;
endmodule
