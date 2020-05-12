module tanh_layer(clk, rst, inputs, outputs);
// DESCRIPTION: takes array of inputs, weights & biases them, 
//					 and applies tanh per output value
// NOTE: This is using systemverilog 2005 for compilation in Quartus.
// 		This was done so you could use 2d array inputs and output ports instead of packing/unpacking
// 		right click file=>file properties=> HDL Version, to make sure that setting is chosen if compilation errors occur.

// input parameters
	parameter DATA_WIDTH = 16; // number of bits per input
	parameter FRACT_WIDTH = 8; // number of bits for fraction part of fixed-point num
	parameter N_IN = 1;			// number of inputs
	parameter N_OUT = 1;			// number of outputs

// define ports 
	input clk, rst;
	input [DATA_WIDTH-1:0] inputs[0:N_IN-1];
	output [DATA_WIDTH-1:0] outputs[0:N_OUT-1];

// internal use
	wire [DATA_WIDTH-1:0] tanh_in[0:N_OUT-1];
	
	
// module behavior:
	WeightAndBiasInputs #(DATA_WIDTH, FRACT_WIDTH, N_IN, N_OUT) inst1(
		.clk(clk), .rst(rst),
		.inputs(inputs),
		.outputs(tanh_in)
		);

	// perform element-wise tanh on outputs
	genvar i;
	generate	for(i=0; i<N_OUT; i=i+1) begin : GEN
		tanh #(DATA_WIDTH, FRACT_WIDTH) tanh(
			.X(tanh_in[i]),
			.Y(outputs[i])
			);
	end
	endgenerate	
	
endmodule
