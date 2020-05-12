module WeightAndSumInputs(clk, rst, in1, in2, out);
	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 8;
	
	input clk, rst;
	input [DATA_WIDTH-1:0] in1, in2;
	output wire [DATA_WIDTH-1:0] out;
	
	// internal regs/wires
	reg  [DATA_WIDTH-1:0] W, U, b;
	
	localparam one = 16'h0100;
	localparam zero = 16'h0000;
	
	
	// tanh layer behavior:	
	twoMultAdd #(DATA_WIDTH,FRACT_WIDTH) inst1(
		.W(W),
		.X(in1),
		.U(U),
		.h(in2),
		.out(out)
	);
	
	
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			W <= 0;
			U <= 0;
			b <= 0;
		end
		else begin
			W <= one;
			U <= one;
			b <= zero;
		end
	end
	
	
endmodule
