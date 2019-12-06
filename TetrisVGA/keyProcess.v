module keyProcess(ps2_out, leftTrue, rightTrue, rotateTrue);

	input [7:0]	 ps2_out;
	output leftTrue, rightTrue, rotateTrue;
	
	assign leftTrue = (ps2_out == 'd1)? 1'b1 : 1'b0; ////////////
	assign rightTrue = (ps2_out == 'd2)? 1'b1 : 1'b0; /////////////
	assign rotateTrue = (ps2_out == 'd3)? 1'b1 : 1'b0; /////////////

endmodule
