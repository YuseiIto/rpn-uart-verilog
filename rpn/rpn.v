module rpn(clk,op_en,op,num_en,num,res_value,res_ready);
	input clk;
	input op_en;
	input [3:0] op;
	input num_en;
	input [15:0] num;
	
	output reg [15:0] res_value;
	output reg res_ready;

	wire [1:0] arg_cnt,pop_cnt; // Operand/ popped value count for current operator
	wire [15:0] first,second; // Operands (stack top 2)
	wire [15:0] ans;

	wire stack_wen; // Write enable for stack
	wire [15:0] stack_din; // Stack data input

	wire print_ready;


	// Delay operator enable signal for 1 cycle to reduce timing sensitivity
	reg op_en_synced; // Aligned to the clock cycle
	reg op_en_delayed; // Delayed for one clock cycle
	always@(posedge clk) begin
		op_en_synced <= op_en;
		op_en_delayed <= op_en_synced;
	end

	alu alu_inst (op,second,first,ans,arg_cnt);
	op_controller op_ctrl_inst (op_en_delayed,op,arg_cnt,pop_cnt,print_ready);	
	stack_controller stack_ctrl_inst (num,num_en,ans,op_en_delayed,op,stack_din,stack_wen);
	stack stack_inst (clk,stack_wen,stack_din,pop_cnt,first,second);

	// Delay to make it less timing sensitive
	reg [15:0] prev_ans;
	always@(posedge clk) begin
		prev_ans<=ans;
		if (print_ready) begin
			res_value<=prev_ans;
			res_ready<=1;
		end
	
		if(res_ready) res_ready<=0;
	end

endmodule
