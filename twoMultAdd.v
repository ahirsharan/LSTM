module twoMultAdd(W,X,U,h,b, out);	
	// incoming data signed and fixed width
	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 8;
	
	input signed [DATA_WIDTH-1:0] W,X,U,h,b;
	output wire [DATA_WIDTH-1:0] out;
	
	
	// internal regs/wires
	wire [DATA_WIDTH+FRACT_WIDTH-1:0] p1,p2;
	
	// behavior: out = W*X + U*h + b
	assign p1 = (W*X)>>FRACT_WIDTH;
	assign p2 = (U*h)>>FRACT_WIDTH;
	assign out = p1 + p2 + b;

endmodule
