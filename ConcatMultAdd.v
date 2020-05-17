module ConcatMultAdd(X, h_in, W0, W1, b, out);	
	// Concatenates 
	// incoming data signed and fixed width
	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 8;
	
	input signed [DATA_WIDTH-1:0] X, h_in;
	input signed [DATA_WIDTH-1:0] W0, W1, b;
	output[DATA_WIDTH-1:0] out;

	// internal regs/wires
	wire [DATA_WIDTH+FRACT_WIDTH-1:0] p1,p2;
	
	// behavior: out = W*{x,h_in} + b where W={W0,W1}
	assign p1 = (W0*X)>>>FRACT_WIDTH; 
	assign p2 = (W1*h_in)>>>FRACT_WIDTH;
	assign out = p1 + p2 + b;

endmodule
