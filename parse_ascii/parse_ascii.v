module parse_ascii(ascii,is_space,is_op,digit,op);
	
input [7:0] ascii; // Basic ascii codes are 7-bits, but set for 8 bits for convience

	output is_space; // 1 if space, 0 if not
	output is_op; // 1 if op, 0 if number or space
	output [3:0] digit;
	output [3:0] op; // Operator flag. 4bit width.

	parameter OP_ADD = 4'd0, OP_SUB = 4'd1, OP_MUL = 4'd2, OP_DIV = 4'd3, OP_POP = 4'd4, OP_UNKKOWN = 4'hf;
	
	parameter ASCII_SPACE = 8'd32;
	parameter ASCII_PLUS = 8'd43;
	parameter ASCII_MINUS = 8'd45;
	parameter ASCII_MUL = 8'd42;
	parameter ASCII_DIV = 8'd47;
	parameter ASCII_0 = 8'd48;
	parameter ASCII_LF= 8'd10;

	assign is_space = (ascii==ASCII_SPACE);
	assign is_op = (ascii==ASCII_PLUS || ascii==ASCII_MINUS || ascii==ASCII_MUL || ascii==ASCII_DIV||ascii == ASCII_LF);
	assign digit = ascii-ASCII_0;

	assign op= (ascii==ASCII_PLUS) ? OP_ADD :
						 (ascii==ASCII_MINUS) ? OP_SUB:
						 (ascii==ASCII_MUL) ? OP_MUL:
						 (ascii==ASCII_DIV) ? OP_DIV:
						 (ascii==ASCII_LF) ? OP_POP:
						 OP_UNKKOWN;

endmodule
