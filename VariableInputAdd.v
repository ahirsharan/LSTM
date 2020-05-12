module VariableInputAdd(inputs, out);
// DESCRIPTION: adds a variable number of inputs
// 
// NOTE: This is using systemverilog 2005 for compilation in Quartus.
// 		This was done so you could use 2d array inputs and output ports instead of packing/unpacking
// 		right click file=>file properties=> HDL Version, to make sure that setting is chosen if compilation errors occur.

// input parameters
	parameter DATA_WIDTH = 16; // number of bits per input
	parameter FRACT_WIDTH = 8; // number of bits for fraction part of fixed-point num
	parameter N_IN; 				// number of inputs
	
// define ports
	input [DATA_WIDTH-1:0] inputs[0:N_IN-1];
	output [DATA_WIDTH-1:0] out;

// module behavior:
	generate
		if(N_IN==1) begin
			assign out = inputs[0];
		end
		else if (N_IN==2) begin
			assign out = inputs[0]+inputs[1];
		end
		else begin
			if(N_IN%2==0) begin
				wire [DATA_WIDTH-1:0] outL, outR;
				VariableInputAdd#(DATA_WIDTH, FRACT_WIDTH, (N_IN/2) ) left(
					.inputs(inputs[0:(N_IN/2)-1]),
					.out(outL)
					);
				VariableInputAdd#(DATA_WIDTH, FRACT_WIDTH, (N_IN/2) ) right(
					.inputs(inputs[(N_IN/2):N_IN-1]),
					.out(outR)
					);
				assign out = outL + outR;
			end
			else begin
				wire [DATA_WIDTH-1:0] outL, outR;
				VariableInputAdd#(DATA_WIDTH, FRACT_WIDTH, (N_IN-1)/2 ) left(
					.inputs(inputs[0:((N_IN-1)/2) -1]),
					.out(outL)
					);
				VariableInputAdd#(DATA_WIDTH, FRACT_WIDTH, ((N_IN-1)/2)+1 ) right(
					.inputs(inputs[(N_IN-1)/2 : N_IN-1]),
					.out(outR)
					);
				assign out = outL + outR;
			end
		end
		 
	endgenerate

	
	
endmodule
