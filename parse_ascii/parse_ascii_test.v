`timescale 1ns/1ps

module parse_ascii_testbench();

/* Testbench body */
reg [7:0] ascii;
wire is_space,is_op;
wire [3:0] op;
wire [3:0] digit;

parse_ascii parser_inst(ascii,is_space,is_op,digit,op);

initial begin
	ascii <= "0";
	#10 ascii <= "1";
	#10 ascii <= "2";
	#10 ascii <= "3";
	#10 ascii <= "4";
	#10 ascii <= "5";
	#10 ascii <= "6";
	#10 ascii <= "7";
	#10 ascii <= "8";
	#10 ascii <= "9";
	#10 ascii <= "+";
	#10 ascii <= "-";
	#10 ascii <= "*";
	#10 ascii <= "/";
	#10 ascii <= "\n";
	#10 ascii <= " ";
	#10 $finish;
end


/* Icarus Verilog simulation */
initial begin
	$dumpfile("parser.vcd");
	$dumpvars(0, parser_inst);
end

endmodule
