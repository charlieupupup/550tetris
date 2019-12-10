module bottomTouchCheck(field, block, blockX, blockY, bottomTouch); 
	// Warning: the solid shape (1'b1) in the block: strictly bottomY< 2!!!!
	input [0:399] field;
	input [0:15] block;
	input [4:0] blockX, blockY;
	output wire bottomTouch;
	
	wire [0:15] bottomTouchFlag;
	
	integer blockXInt, blockYInt;
	always @(blockX) blockXInt <= blockX;
	always @(blockY) blockYInt <= blockY;

	genvar x, y;
	generate
		for (y = 0; y < 4; y = y + 1) begin: andGateY
			for (x = 0; x < 4; x = x + 1) begin: andGateX
				and and_(bottomTouchFlag[y * 4 + x], block[y * 4 + x], field[(blockYInt + y + 1) * 20 + blockXInt + x]);
			end
		end
	endgenerate
	
	wire [1:0] bottomY;
	blockBottom my_bB(block, bottomY);
	
	assign bottomTouch = ((bottomTouchFlag == 16'b0) &&  blockY < (5'd16 + bottomY))? 1'b0 : 1'b1; // strictly bottomY< 2!!!!

endmodule
