module rnn_cell (clk, rst, inputs, outputs);
// DESCRIPTION: takes variable inputs, sends through single tanh neural-net layer,
//					 and makes a prediction. The previous prediction is fed in as an input too.
// NOTE: This is using systemverilog 2005 for compilation in Quartus.
// 		This was done so you could use 2d array inputs and output ports instead of packing/unpacking
// 		right click file=>file properties=> HDL Version, to make sure that setting is chosen if compilation errors occur.

// input parameters
	parameter DATA_WIDTH = 16; // number of bits per input
	parameter FRACT_WIDTH = 8; // number of bits for fraction part of fixed-point num
	parameter N_IN = 3;			// number of inputs
	parameter N_OUT = 2;			// number of outputs

// define ports 
	input clk, rst;
	input [DATA_WIDTH-1:0] inputs[0:N_IN-1];
	output [DATA_WIDTH-1:0] outputs[0:N_OUT-1];
	
// internal use
	wire [DATA_WIDTH-1:0] tanh_in[0:N_IN+N_OUT-1];
	wire [DATA_WIDTH-1:0] tanh_out[0:N_OUT-1];
	
	//	concatinates tanh_in = {outputs, inputs};
	genvar i;
	generate for(i=0; i<N_OUT+N_IN; i=i+1) begin :GEN_INPUTS
		if(i<N_OUT) begin
			assign tanh_in[i] = outputs[i];
		end
		else begin
			assign tanh_in[i] = inputs[i-N_OUT];
		end
	end
	endgenerate
	
	
	tanh_layer #(DATA_WIDTH, FRACT_WIDTH, N_IN+N_OUT, N_OUT) inst1(
		.clk(clk), .rst(rst),
		.inputs(tanh_in),
		.outputs(tanh_out)
		);
	
	always @(posedge clk or posedge rst) begin
		outputs <= tanh_out;
//		if (rst) begin
//			out <= 0;
//		end
//		else begin
//			out <= tanh_out;
//		end
	end
	
endmodule
	