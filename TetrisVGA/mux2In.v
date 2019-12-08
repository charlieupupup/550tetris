module mux2In(low, high, cond, out);

	input high, low, cond;
	output out;
	
	assign out = cond ? high : low;

endmodule
