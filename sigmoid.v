module sigmoid(X,Y);
	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 8;
	
	input [DATA_WIDTH-1:0] X;
	output wire [DATA_WIDTH-1:0] Y;
	
	wire [DATA_WIDTH-1:0] s1;
	assign s1 = X+16'h0200; 
	
	assign Y = (X<16'h0000) ? (
		// negative
		(X < -16'h0200)? 16'h0000 : (s1>>>2) ) 
		// positive
		: ( (X>16'h0200) ? 16'h0100: (s1>>>2) );


endmodule
