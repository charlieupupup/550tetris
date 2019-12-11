module lfsr(clock, seed, q);

	input clock;
	input [7:0] seed; //
	output wire [2:0] q;
	
	wire [7:0] dffeIn, dffeOut;
	wire [6:0] xorOut;
	reg [7:0] ranNum;
	reg loadFlag;
	reg [1:0] seedCount;
	
	genvar i;
	
	generate
		for (i = 0; i < 8; i = i + 1) begin: dffeMatrix8
			dffe_ref dffe_(dffeOut[i], dffeIn[i], clock, 1'b1, 1'b0);
		end
	endgenerate

	generate
		for (i = 5; i < 7; i = i + 1) begin: xorMatrix2
			xor xor_(xorOut[i], dffeOut[i+1], dffeOut[0]);
		end
	endgenerate
	
	generate
		for (i = 5; i < 7; i = i + 1) begin: muxMatri2
			mux2In mux_(xorOut[i], seed[i], loadFlag, dffeIn[i]); 
		end
	endgenerate
	
	xor xor_2(xorOut[2], dffeOut[3], dffeOut[0]);
	mux2In mux_2(xorOut[2], seed[2], loadFlag, dffeIn[2]); 
	
	mux2In mux_0(dffeOut[1], seed[0], loadFlag, dffeIn[0]); 
	mux2In mux_1(dffeOut[2], seed[1], loadFlag, dffeIn[1]); 
	mux2In mux_3(dffeOut[4], seed[3], loadFlag, dffeIn[3]); 	
	mux2In mux_4(dffeOut[5], seed[4], loadFlag, dffeIn[4]);
	mux2In mux_7(dffeOut[0], seed[7], loadFlag, dffeIn[7]);
	
	initial begin
		//seed <= 8'b00000001;
		loadFlag <= 1'b1;
		seedCount <= 2'b00;
	end
	
	always @(posedge clock) begin
		if (seedCount < 2'b01) seedCount <= seedCount + 2'b01;
		else loadFlag <= 1'b0;
	end
	
	assign q = dffeOut % 3'b110;
	
endmodule
