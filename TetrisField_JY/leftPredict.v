module leftPredict(field, block, oldBlockX, oldBlockY,
						 opOK, bottomTouch, newField);
						 
	input [0:399] field;
	input [0:15] block;
	input [4:0] oldBlockX, oldBlockY;
	output wire opOK, bottomTouch;
	output wire [0:399] newField;
	
	wire [4:0] blockX, blockY;
	assign blockX = oldBlockX - 16'd1;
	assign blockY = oldBlockY;
	
	integer blockXInt, blockYInt;
	always @(blockX) blockXInt <= blockX;
	always @(blockY) blockYInt <= blockY;
	
	wire conflictTrue, leftOutTrue;
	
	wire [0:15] rotateBlock;
	wire [1:0] leftEdgeX;
	conflictCheck left_cC(field, block, blockX, blockY, conflictTrue);
	rotateAntiClock my_rAC(block, rotateBlock);
	blockBottom left_bB(rotateBlock, leftEdgeX);
	assign leftOutTrue = ((oldBlockX % 'd20 == 'd0) && (leftEdgeX == 2'b0))? 1'b1 : 1'b0;
	assign opOK = (~conflictTrue && ~leftOutTrue)? 1'b1 : 1'b0;
	
	bottomTouchCheck left_bTC(field, block, blockX, blockY, bottomTouch);
	
	genvar x, y;
	generate // Combine field and block to newField
		for (y = 0; y < 20; y = y + 1) begin: newFieldY
			for (x = 0; x < 20; x = x + 1) begin: newFieldX
				assign newField[y * 20 + x] = (x-blockXInt>-1 && x-blockXInt<4 && y-blockYInt>-1 && y-blockYInt<4 && field[y * 20 + x]==1'b0)? block[(y-blockYInt)*4+x-blockXInt] : field[y * 20 + x];
			end
		end
	endgenerate
	
endmodule
