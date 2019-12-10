module downPredict(field, block, oldBlockX, oldBlockY,
						 score, bottomTouch, newField);
						 
	input [0:399] field;
	input [0:15] block;
	input [4:0] oldBlockX, oldBlockY;
	output wire score, bottomTouch;
	output wire [0:399] newField;
	
	wire [4:0] blockX, blockY;
	assign blockX = oldBlockX;
	assign blockY = oldBlockY + 16'b1;
	
	integer blockXInt, blockYInt;
	always @(blockX) blockXInt <= blockX;
	always @(blockY) blockYInt <= blockY;
	
	bottomTouchCheck down_bTC(field, block, blockX, blockY, bottomTouch);
	
	wire [0:399] temField;
	genvar x, y;
	generate // Combine field and block to temField
		for (y = 0; y < 20; y = y + 1) begin: temFieldY
			for (x = 0; x < 20; x = x + 1) begin: temFieldX
				assign temField[y * 20 + x] = (x-blockXInt>-1 && x-blockXInt<4 && y-blockYInt>-1 && y-blockYInt<4 && field[y * 20 + x]==1'b0)? block[(y-blockYInt)*4+x-blockXInt] : field[y * 20 + x];
			end
		end
	endgenerate
	
	clearLines down_cl(temField, newField, score); ////////
						 
endmodule
