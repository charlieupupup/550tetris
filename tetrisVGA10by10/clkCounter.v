module clkCounter(CLOCK_50M, clock_b, clock_a2, clock_a);

	input CLOCK_50M;
	output reg clock_b, clock_a2, clock_a;
	
	integer count_b, count_a2, count_a;
	initial begin
		count_b <= 1;
		count_a2 <= 1;
		count_a <= 1;
		clock_b <= 0;
		clock_a2 <= 0;
		clock_a <= 0;
	end
	
	always @(posedge CLOCK_50M) begin
		count_b = count_b + 1;
		if (count_b > 'd2500000) begin
			clock_b <= ~clock_b;
			count_b <= 1;
		end
	end
	
	always @(posedge CLOCK_50M) begin
		count_a2 = count_a2 + 1;
		if (count_a2 > 'd12500000) begin
			clock_a2 <= ~clock_a2;
			count_a2 <= 1;
		end
	end
	
	always @(posedge clock_b) begin
		count_a = count_a + 1;
		if (count_a > 'd5) begin
			clock_a <= ~clock_a;
			count_a <= 1;
		end
	end 

endmodule
