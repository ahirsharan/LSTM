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
		// Take not too large inputs such that they don't overflow and give proper results after right shift
		// Preferably, take inputs <4 && >-4
		// First 8 bits are integeral part and last 8 bits are fractional
		// All Numbers are signed 
		
                #200;
		X=-16'h0080;       // X = -0.5
		c_in=-16'h0100;    // c_in = -1
		h_in=16'h0280;     // h_in = 2.5

		$monitor("Cell State: %d, Output (After Activation):%d ",c_out,h_out);
		
		#200;
     		X=16'h0110;
		c_in=16'h0110;
		h_in=16'h0211;

		$monitor("Cell State: %d, Output (After Activation):%d ",c_out,h_out);
		
		#200;
	 	X=-16'h0110;
		c_in=16'h0120;
		h_in=16'h0011;

		$monitor("Cell State: %d, Output (After Activation):%d ",c_out,h_out);
		
		#200;
      		X=16'h0110;
		c_in=16'h0210;
		h_in=-16'h0011;

		$monitor("Cell State: %d, Output (After Activation):%d ",c_out,h_out);

	end
      
endmodule
