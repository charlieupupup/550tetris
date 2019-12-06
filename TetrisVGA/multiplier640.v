module multiplier640(p1, p0);

	input wire [18:0] p0;
	output wire [18:0] p1;

	assign p1 = p0 * 19'd640;
	
	
endmodule
