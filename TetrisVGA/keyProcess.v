module keyProcess(stableKey, leftTrue, rightTrue, rotateTrue);

	input [7:0]	 stableKey;
	output leftTrue, rightTrue, rotateTrue;
	
	assign leftTrue = (stableKey == 8'h23)? 1'b1 : 1'b0; 
	assign rightTrue = (stableKey == 8'h34)? 1'b1 : 1'b0; 
	assign rotateTrue = (stableKey == 8'h2d)? 1'b1 : 1'b0; 

endmodule
