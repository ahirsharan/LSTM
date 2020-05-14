module twoMultAdd(X, w, b, out);	
	// incoming data signed and fixed width
	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 8;
	
	input signed [DATA_WIDTH-1:0] X,w,b;
	output wire [DATA_WIDTH-1:0] out;

	// internal regs/wires
	wire [DATA_WIDTH+FRACT_WIDTH-1:0] p;
	
	// behavior: out = W*x + b
	assign p = (W*X)>>FRACT_WIDTH;
	assign out = p + b;

endmodule
