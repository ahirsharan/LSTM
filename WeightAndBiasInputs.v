module WeightAndBiasInputs(clk, rst, inputs, outputs);
//	DESCRIPTION: weights and biases variable number of inputs to variable number of outputs
// 
// NOTE: This is using systemverilog 2005 for compilation in Quartus.
// 		This was done so you could use 2d array inputs and output ports instead of packing/unpacking
// 		right click file=>file properties=> HDL Version, to make sure that setting is chosen if compilation errors occur.
//
// NOTE: clk and rst not used at the moment (purely combinational)
// 		In the future will add option for gating with flip flops so clock speed can increase

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
	wire [DATA_WIDTH-1:0] weights [0:N_IN-1][0:N_OUT-1];
	wire [DATA_WIDTH+FRACT_WIDTH-1:0] products [0:N_IN-1][0:N_OUT-1];
	wire [DATA_WIDTH-1:0] biases[0:N_OUT-1];
	wire [DATA_WIDTH-1:0] sums[0:N_OUT-1];

// module behavior:

	/** LOAD WEIGHTS AND BIASES FROM .MIF FILE **
		mif file format: for n inputs & m outputs
		Wout0in1
		Wout0in2
		...Wout0in[n]
		Wout1in1 
		Wout1in2
		...Wout1in[n] etc. for m outputs, then after weights come biases:
		bias1
		bias2
		...bias[m]
	**/
	reg [DATA_WIDTH-1:0] mem[0:N_IN*N_OUT+N_OUT-1];
	initial begin
		$readmemh("WeightBiasVals.mif", mem, 0, N_IN*N_OUT+N_OUT-1); // replace with desired .mif file 
	end
	
	// generate combinational logic for matrix product and element wise sum with biases
	genvar i,j;
	generate for(i=0; i<N_OUT; i=i+1) begin : GEN1
		assign biases[i] = mem[N_IN*N_OUT+i]; // bias values listed after the weights
		wire [DATA_WIDTH-1:0] sum_in[0:N_IN-1];
		
		for(j=0;j<N_IN; j=j+1) begin : GEN2
			always@* weights[j][i] = mem[i*N_IN+j];
			always@* products[j][i] = ( inputs[j] * weights[j][i] ) >> FRACT_WIDTH;
			assign sum_in[j] = products[j][i];
		end
		
		// adding up all inputs in log2(N_IN) with recursive adder tree generation
		VariableInputAdd #(DATA_WIDTH,FRACT_WIDTH,N_IN) final_answer(
			.inputs(sum_in),
			.out(sums[i])
			);
	
		// add biases corresponding to each output
		assign outputs[i] = sums[i] + biases[i];
	
	end
	endgenerate

endmodule
