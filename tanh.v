module tanh(X,Y);
// DESCRIPTION: takes 1 input number and returns an approx of tanh as output

// input parameters
	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 8;
	
// define ports
	input signed [DATA_WIDTH-1:0] X;
	output wire [DATA_WIDTH-1:0] Y;
	
// internal use
	//	wire [2*DATA_WIDTH-1:0] p1,p2;

// module behavior:
	//	assign p1 = 16'h0040*X; // 0.25*X
	//	assign p2 = 16'h0098*X; // 0.5938*X = (1/2+1/16+1/32)*X
	
	assign Y = (X[DATA_WIDTH-1]) ? (
		// negative
		(X < -16'h0100)? -16'h0100 : X )
		// positive
		: ( (X>16'h0100) ? 16'h0100: X );
endmodule
