module top_level_tester(clk, in, out);
	parameter DATA_WIDTH = 16; // number of bits per input
	parameter FRACT_WIDTH = 8; // number of bits for fraction part of fixed-point num
	parameter N_IN = 500;
	
	input clk;
	input [DATA_WIDTH-1:0] in;
	output [DATA_WIDTH-1:0] out;
	reg [DATA_WIDTH-1:0] inputs[0:N_IN-1];
	integer i;
	always@ (posedge clk) begin
		for (i=0; i<N_IN; i=i+1)
			inputs[i] = in; //{N_IN{16'h0000}};
	end
	
	VariableInputAdd_Tester #(DATA_WIDTH,FRACT_WIDTH, N_IN) final_answer(
		.inputs(inputs),
		.out(out)
		);
	

endmodule
