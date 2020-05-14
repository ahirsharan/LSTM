module ConcatMultAdd(X, h_in, W, b, out);	
	// Concatenates 
	// incoming data signed and fixed width
	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 8;
	
	input [DATA_WIDTH-1:0] X,h_in,b;
	input [DATA_WIDTH-1:0] W[2];
	output wire [DATA_WIDTH-1:0] out;

	// internal regs/wires
	wire [DATA_WIDTH+FRACT_WIDTH-1:0] p1,p2;
	
	// behavior: out = W*x + b
	assign p1 = (W[0]*X)>>FRACT_WIDTH; 
	assign p2 = (W[1]*h_in)>>FRACT_WIDTH;
	assign out = p1[DATA_WIDTH-1:0] + p2[DATA_WIDTH-1:0]+ b;

endmodule
