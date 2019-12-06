module clkCounter(CLOCK_50M, clock_10, clock_1);

	input CLOCK_50M;
	output reg clock_10, clock_1;
	
	integer count_10, count_1;
	initial begin
		count_10 <= 1;
		count_1 <= 1;
		clock_10 <= 0;
		clock_1 <= 0;
	end
	
	always @(posedge CLOCK_50M) begin
		count_10 = count_10 + 1;
		if (count_10 > 'd5000000) begin
			clock_10 <= ~clock_10;
			count_10 <= 1;
		end
	end
	
	always @(posedge clock_10) begin
		count_1 = count_1 + 1;
		if (count_1 > 'd10) begin
			clock_1 <= ~clock_1;
			count_1 <= 1;
		end
	end 

endmodule
