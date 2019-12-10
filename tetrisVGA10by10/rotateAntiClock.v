module rotateAntiClock(block, rotateBlock);

	input [0:8] block;
	output wire [0:8] rotateBlock;
	
	genvar x, y;
	generate
		for (y = 0; y < 3; y = y + 1) begin: rotateMatrixY
			for (x = 0; x < 3; x = x + 1) begin: rotateMatrixX
				assign rotateBlock[(2 - x) * 3 + y] = block[y * 3 + x];
			end
		end
	endgenerate

endmodule
