module rnn(clk, rst, IN1, IN2, IN3, OUT1);
// DESCRIPTION: top layer RNN. design architecture here
// test arch is:
// 3 inputs => 2 neuron hidden layer => 1 neuron layer => 1 output

// input parameters
	parameter DATA_WIDTH = 16; // number of bits per input
	parameter FRACT_WIDTH = 8; // number of bits for fraction part of fixed-point num
	
// define ports
	input clk, rst;
	input  [DATA_WIDTH-1:0] IN1, IN2, IN3;
	output [DATA_WIDTH-1:0] OUT1;
	
// internal use
	// hidden layers
	wire [DATA_WIDTH-1:0] L1C1_IN[0:2];
	wire [DATA_WIDTH-1:0] L1C1_OUT;
	
	wire [DATA_WIDTH-1:0] L1C2_IN[0:2];
	wire [DATA_WIDTH-1:0] L1C2_OUT;
	
	wire [DATA_WIDTH-1:0] L2C1_IN[0:1];
	wire [DATA_WIDTH-1:0] L2C1_OUT;
	

// module behavior:

	// hidden layer 1
	assign L1C1_IN[0] = IN1;
	assign L1C1_IN[1] = IN2;
	assign L1C1_IN[2] = IN3;
	assign L1C2_IN[0] = IN1;
	assign L1C2_IN[1] = IN2;
	assign L1C2_IN[2] = IN3;
	
	rnn_cell #(DATA_WIDTH, FRACT_WIDTH, 3, 1) L1C1(
		.clk(clk), .rst(rst),
		.inputs(L1C1_IN),
		.outputs(L1C1_OUT)
		);
	
	rnn_cell #(DATA_WIDTH, FRACT_WIDTH, 3, 1) L1C2(
		.clk(clk), .rst(rst),
		.inputs(L1C2_IN),
		.outputs(L1C2_OUT)
		);
	
	// hidden layer 2
	assign L2C1_IN[0] = L1C1_OUT;
	assign L2C1_IN[1] = L1C2_OUT;
	
	rnn_cell #(DATA_WIDTH, FRACT_WIDTH, 2, 1) L2C1(
		.clk(clk), .rst(rst),
		.inputs(L2C1_IN),
		.outputs(L2C1_OUT)
		);
	
	assign OUT1 = L2C1_OUT;
	
endmodule
	