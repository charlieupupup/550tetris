module bottomTouchCheck(field, block, blockX, blockY, bottomTouch); 
	input [0:99] field;
	input [0:8] block;
	input [3:0] blockX, blockY;
	output reg bottomTouch; ////

	initial bottomTouch = 1'b0;
	
	integer x, y;
	always @(*) begin
		bottomTouch = 1'b0;
		for (y = 0; y < 3; y = y + 1) begin
			for (x = 0; x < 3; x = x + 1) begin
				if (block[y * 3 + x] == 1'b1) begin
					if (blockY + y == 'd9) bottomTouch = 1'b1;
					else if (field[(blockY + y + 1) * 10 + blockX + x] == 1'b1) bottomTouch = 1'b1;
					else bottomTouch = bottomTouch;
				end
				else bottomTouch = bottomTouch;
			end
		end
	end
	
	/*
	// Warning: the solid shape (1'b1) in the block: strictly bottomY< 2!!!!
	wire [0:8] bottomTouchFlag;
	genvar x, y;
	generate
		for (y = 0; y < 3; y = y + 1) begin: andGateY
			for (x = 0; x < 3; x = x + 1) begin: andGateX
				and and_(bottomTouchFlag[y * 3 + x], block[y * 3 + x], field[(blockY + y + 1) * 10 + blockX + x]);
			end
		end
	endgenerate
	
	wire [1:0] bottomY;
	blockBottom my_bB(block, bottomY);
	
	assign bottomTouch = ((bottomTouchFlag == 9'b0) &&  blockY < (4'd7 + bottomY))? 1'b0 : 1'b1; // strictly bottomY< 2!!!!
	*/
	
endmodule
