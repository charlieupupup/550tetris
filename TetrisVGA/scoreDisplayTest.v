module scoreDisplayTest(reset, clock_b, clock_a2, speedTrue, score);

	input reset, clock_b, clock_a2, speedTrue;
	output reg [31:0] score;
	
	wire clock;
	assign clock = (speedTrue)? clock_b : clock_a2;
	
	initial score <= 32'h00000000;
	
	always @(posedge clock or posedge reset) begin
		if (reset) score <= 32'h00000000;
		else score <= score + 32'b1;
	end

endmodule
