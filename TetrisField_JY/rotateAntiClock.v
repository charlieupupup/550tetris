module rotateAntiClock(block, rotateBlock);

	input [0:15] block;
	output wire [0:15] rotateBlock;
	
	genvar x, y;
	generate
		for (y = 0; y < 4; y = y + 1) begin: rotateMatrixY
			for (x = 0; x < 4; x = x + 1) begin: rotateMatrixX
				assign rotateBlock[(3 - x) * 4 + y] = block[y * 4 + x];
			end
		end
	endgenerate

endmodule
