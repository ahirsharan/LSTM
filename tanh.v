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

// TODO: fix this in the future, for more precise approx of tanh
//	always @(*) begin
//		if(X> -16'h0200) // really X < -2;
//			Y = -1;
//		if(X> 16'h0200)
//			Y= 1;
//		else
//			Y = X;
//		// [-inf,-2]
//		if(X<= -16'h0200)
//			Y = -16'h0100; // Y = -1;
//		
//		// [-2,-1]
//		if((X> -16'h0200)&&(X<= -16'h0100))												
//			Y = (p1>>FRACT_WIDTH) - 16'h0080; // Y = 0.25*X - 0.5;
//		
//		// [-1,-0.375]
//		if((X> -16'h0100)&&(X<= -16'h0060))
//			Y = (p2>>FRACT_WIDTH) - 16'h0028; // Y = 0.5938*X - 0.1563 = (1/2+1/16+1/32)*X - (1/8+1/32);
//			
//		// [-0.375,0.375]
//		if((X> -16'h0060)&&(X<= 16'h0060))
//			Y = X;
//		
//		// [0.375,1]
//		if((X> 16'h0060)&&(X<= 16'h0100))
//			Y = (p2>>FRACT_WIDTH) + 16'h0028; // Y = 0.5938*X - 0.1563 = (1/2+1/16+1/32)*X - (1/8+1/32);
//			
//		// [1,2]				= [0000 0001 0000 0000, 0000 0010 0000 0000]
//		if((X> 16'h0100)&&(X<= 16'h0200))
//			Y = (p1>>FRACT_WIDTH) + 16'h0080; // Y = 0.25*X + 0.5;
//		
//		// [2,inf]
//		if(X> 16'h0200)
//			Y = 16'h0100; // Y = 1;
//	end
endmodule
