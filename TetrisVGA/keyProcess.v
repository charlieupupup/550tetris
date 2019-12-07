module keyProcess(ps2_out, leftTrue, rightTrue, rotateTrue);

	input [7:0]	 ps2_out;
	output leftTrue, rightTrue, rotateTrue;
	
	assign leftTrue = (ps2_out == 8'h23)? 1'b1 : 1'b0; 
	assign rightTrue = (ps2_out == 8'h34)? 1'b1 : 1'b0; 
	assign rotateTrue = (ps2_out == 8'h2d)? 1'b1 : 1'b0; 

endmodule
