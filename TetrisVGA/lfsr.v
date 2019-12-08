module lfsr(clock, q);

	input clock;
	output reg [2:0] q;
	
	wire [7:0] dffeIn, dffeOut;
	wire [6:0] xorOut;
	reg [7:0] seed;
	reg loadFlag;
	
	genvar i;
	
	generate
		for (i = 0; i < 8; i = i + 1) begin: dffeMatrix8
			dffe dffe_(dffeOut[i], dffeIn[i], clock, 1'b1, 1'b0);
		end
	endgenerate
	
	generate
		for (i = 0; i < 7; i = i + 1) begin: xorMatrix7
			xor xor_(xorOut[i], dffeOut[i+1], dffeOut[0]);
		end
	endgenerate
	
	generate
		for (i = 0; i < 7; i = i + 1) begin: muxMatrix7
			mux2In mux_(xorOut[i], seed[i], laodFlag, dffeIn[i]);
		end
	endgenerate
	
	mux2In mux_7(dffeOut[0], seed[7], loadFlag, dffeIn[7]);
	
	initial begin
		seed <= 8'b10101101;
		loadFlag <= 1'b1;
	end
	
	always @(posedge clock) begin
		q <= dffeOut % 3'd5;
		loadFlag <= 1'b0;
	end
	
endmodule
