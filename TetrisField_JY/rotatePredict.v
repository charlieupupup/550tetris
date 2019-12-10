module rotatePredict(field, block, blockX, blockY, ///////
							opOK, score, bottomTouch, newField, newBlock);
							
	input [0:399] field;
	input [0:15] block;
	input [4:0] blockX, blockY;
	output wire opOK, score, bottomTouch;
	output wire [0:399] newField;
	output wire [0:15] newBlock;
	
	integer blockXInt, blockYInt;
	always @(blockX) blockXInt <= blockX;
	always @(blockY) blockYInt <= blockY;
	
	
	rotateClockWise operation_rCW(block, newBlock);
	
	wire conflictTrue, rightOutTrue, leftOutTrue;
	wire [0:15] clockWiseBlock, antiClockBlock;
	wire [1:0] rightEdgeX, leftEdgeX;
	
	conflictCheck rotate_cC(field, newBlock, blockX, blockY, conflictTrue);
	
	rotateClockWise my_rCW(newBlock, clockWiseBlock);
	blockBottom right_bB(clockWiseBlock, rightEdgeX);
	
	rotateAntiClock my_rAC(newBlock, antiClockBlock);
	blockBottom left_bB(antiClockBlock, leftEdgeX);
	
	assign rightOutTrue = (((blockX - 'd16) % 'd20 == 'd0) && (rightEdgeX == 2'b0))? 1'b1 : 1'b0;
	assign leftOutTrue = ((blockX % 'd20 == 'd0) && (leftEdgeX == 2'b0))? 1'b1 : 1'b0;
	assign opOK = (~conflictTrue && ~rightOutTrue && ~leftOutTrue)? 1'b1 : 1'b0;
	
	bottomTouchCheck rotate_bTC(field, newBlock, blockX, blockY, bottomTouch);
	
	wire [0:399] temField;
	genvar x, y;
	generate // Combine field and newBlock to temField
		for (y = 0; y < 20; y = y + 1) begin: temFieldY
			for (x = 0; x < 20; x = x + 1) begin: temFieldX
				assign temField[y * 20 + x] = (x-blockXInt>-1 && x-blockXInt<4 && y-blockYInt>-1 && y-blockYInt<4 && field[y * 20 + x]==1'b0)? newBlock[(y-blockYInt)*4+x-blockXInt] : field[y * 20 + x];
			end
		end
	endgenerate
	
	clearLines rotate_cl(temField, newField, score); //////////////
							
endmodule
