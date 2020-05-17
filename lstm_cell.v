module lstm_cell(c_in, h_in, X, c_out, h_out);
	
	// X, c_in and h_in are assumed to be of 1x1. Change dimensions accordingly.
	
	//Parameters
	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 8;
	
	//input clk, rst;
	
	//c_in : previous cell state 
	//h_in: tanh(o_in)
	input signed [DATA_WIDTH-1:0] c_in , h_in ;
	
        //X: current input
	input signed [DATA_WIDTH-1:0] X;
	
	//Weight arrays : {Wf, Wi ,Wc, Wo} where each element will be of size 2 x 1
	wire [DATA_WIDTH-1:0] Wf0, Wf1, Wi0, Wi1, Wc0, Wc1, Wo0, Wo1;
	
	//Bias arrays : {bf, bi ,bc, bo} where each element will be of size 1 x 1
	wire [DATA_WIDTH-1:0] bf, bi, bc ,bo;
	
	//Assign weights and biases
	//Random values assigned
	
	assign Wf0=16'h0001;
	assign Wf1=16'h0001;
	
	assign Wi0=16'h0001;
	assign Wi1=16'h0001;
	
	assign Wc0=16'h0001;
	assign Wc1=16'h0001;
	
	assign Wo0=16'h0001;
   assign Wo1=16'h0001;
	
	assign bf=16'h0001;
	assign bi=16'h0001;	
	assign bc=16'h0001;
   assign bo=16'h0001;

	//c_out : current cell state
	//h_out : tanh(o_out)
	output wire [DATA_WIDTH-1:0] c_out, h_out;
	
	wire [DATA_WIDTH-1:0] f, i, iw, ct, cw, ot, out, c_act;
	wire [DATA_WIDTH + FRACT_WIDTH - 1:0] z1, z2;
	
	//f= Wf*{X h_in} + bf
	ConcatMultAdd A1(X, h_in, Wf0, Wf1, bf, f);
	
	//i= sigmoid(Wi*{X h_in} + bi)
	ConcatMultAdd A2(X, h_in, Wi0, Wi1, bi, iw);
	sigmoid S1(iw, i);
	
	//ct= tanh(Wc*{X h_in} + bc)
	ConcatMultAdd A3(X, h_in, Wc0, Wc1, bc, cw);
	tanh T1(cw, ct);
	
	assign z1 = (f*c_in)>>FRACT_WIDTH;
	assign z2 = (i*ct)>>FRACT_WIDTH;
	assign c_out = z1[DATA_WIDTH-1:0] + z2[DATA_WIDTH-1:0];
	
	//out=  sigmoid(Wo*{X h_in} + bo)
	ConcatMultAdd A4(X, h_in, Wo0, Wo1, bo, ot);
	sigmoid S2(ot,out);
	
	//h_out =(out*tanh(c_out))
	tanh T2(c_out,c_act);
	assign h_out = (out*c_act)>>FRACT_WIDTH;
	
endmodule
