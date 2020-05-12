module sigmoid(X,Y);
	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 8;
	
	input signed [DATA_WIDTH-1:0] X;
	output wire [DATA_WIDTH-1:0] Y;
	
	wire signed [DATA_WIDTH-1:0] s1;
	assign s1 = X+16'h0200; // y = x + 2;
	
	assign Y = (X[DATA_WIDTH-1]) ? (
		// negative
		(X < -16'h0200)? 16'h0000 : (s1>>>2) )  // y = 1/4(x+2) = 1/4x+1/2
		// positive
		: ( (X>16'h0200) ? 16'h0100: (s1>>>2) );


endmodule
