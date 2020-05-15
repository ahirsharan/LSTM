module lstm_cell(c_in, h_in, X, Wf, Wi, Wc, Wo, bf, bi, bc, bo, c_out, h_out);
	
	// X, c_in and h_in are assumed to be of 1x1. Change dimensions accordingly.
	
	//Parameters
	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 8;
	
	//input clk, rst;
	
	//c_in : previous cell state 
	//h_in: tanh(o_in)
	input [DATA_WIDTH-1:0] c_in , h_in ;
	
        //X: current input
	input [DATA_WIDTH-1:0] X;
	
	//Weight arrays : {Wf, Wi ,Wc, Wo} where each element will be of size 2 x 1
	input [DATA_WIDTH-1:0] Wf[2], Wi[2], Wc[2], Wo[2];
	
	//Bias arrays : {bf, bi ,bc, bo} where each element will be of size 1 x 1
	input [DATA_WIDTH-1:0] bf, bi, bc ,bo;
	
	//c_out : current cell state
	//h_out : tanh(o_out)
	output wire [DATA_WIDTH-1:0] c_out, h_out;
	
	wire [DATA_WIDTH-1:0] f, i, iw, ct, cw, ot;
	wire [DATA_WIDTH + FRACT_WIDTH - 1:0] z1,z2;
	
	//f= Wf*{X h_in} + bf
	ConcatMultAdd A1(X, h_in, Wf, bf, f);
	
	//i= sigmoid(Wi*{X h_in} + bi)
	ConcatMultAdd A2(X, h_in, Wi, bi, iw);
	sigmoid S1(iw, i);
	
	//ct= tanh(Wc*{X h_in} + bc)
	ConcatMultAdd A3(X, h_in, Wc, bc, cw);
	tanh T1(cw, ct);
	
	assign z1 = (f*c_in)>>FRACT_WIDTH;
	assign z2 = (i*ct)>>FRACT_WIDTH;
	assign c_out = z1[DATA_WIDTH-1:0] + z2[DATA_WIDTH-1:0];
	
	//ot=  Wo*{X h_in} + bo
	ConcatMultAdd A4(X, h_in, Wo, bo, ot);
	
	//h_out =tanh(ot)
	tanh T2(ot,h_out);
	

endmodule
