`timescale 1ns / 1ps

module Test;

	// Inputs
	reg [15:0] c_in;
	reg [15:0] h_in;
	reg [15:0] X;

	// Outputs
	wire [15:0] c_out;
	wire [15:0] h_out;

	// Instantiate the Unit Under Test (UUT)
	lstm_cell uut (
		.c_in(c_in), 
		.h_in(h_in), 
		.X(X), 
		.c_out(c_out), 
		.h_out(h_out)
	);

	initial begin
		// Initialize Inputs
		c_in = 0;
		h_in = 0;
		X = 0;

		// Wait 100 ns for global reset to finish
               #200;
		X=-16'h0010;
		c_in=-16'h0100;
		h_in=16'h0001;

		$monitor("Cell State: %d, Output (After Activation):%d ",c_out,h_out);
		
		#200;
     		 X=16'h0110;
		c_in=16'h0110;
		h_in=16'h0011;

		$monitor("Cell State: %d, Output (After Activation):%d ",c_out,h_out);
		
		#200;
	 	X=-16'h0110;
		c_in=16'h0110;
		h_in=16'h0011;

		$monitor("Cell State: %d, Output (After Activation):%d ",c_out,h_out);
		
		#200;
      		X=16'h0110;
		c_in=16'h0110;
		h_in=-16'h0011;

		$monitor("Cell State: %d, Output (After Activation):%d ",c_out,h_out);

	end
      
endmodule
