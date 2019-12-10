module field(clock, leftTrue, rightTrue, downTrue, rotateTrue, blockType, // Input
				 fieldOut, /*nextBlockTrue,*/ gameOver, score); // Output
				 
	input clock, leftTrue, rightTrue, downTrue, rotateTrue;
	input [2:0] blockType;
	output [0:399] fieldOut;
	output /*nextBlockTrue,*/ gameOver; //// nextBlockTrue ??
	output reg score; ////////////////// Score might be larger than one!!!!!
	
	wire [0:399] fieldOut; // Final output for display.
	
	
	
	// Internal core storage.
	reg [0:399] field;
	reg [0:15] block;
	wire fieldMatrix [0:19][0:19]; // [x][y]
	wire blockMatrix [0:3][0:3]; // [x][y]
	
	// 5 types of block
	reg [0:15] shape0, shape1, shape2, shape3, shape4; //////////
	
	reg [4:0] blockX, blockY; // Block top-left coordinate.
	integer blockXInt, blockYInt;
	always @(blockX) blockXInt <= blockX;
	always @(blockY) blockYInt <= blockY;
	
	genvar x, y;
	
	generate
		for (y = 0; y < 20; y = y + 1) begin: fieldMatrixY
			for (x = 0; x < 20; x = x + 1) begin: fieldMatrixX
				assign fieldMatrix[x][y] = field[y * 20 + x];
			end
		end
	endgenerate
	
	generate
		for (y = 0; y < 4; y = y + 1) begin: blockMatrixY
			for (x = 0; x < 4; x = x + 1) begin: blockMatrixX
				assign blockMatrix[x][y] = block[y * 4 + x];
			end
		end
	endgenerate
	
	generate // Combine field and block to fieldOut. Syntax pass.
		for (y = 0; y < 20; y = y + 1) begin: fieldOutY
			for (x = 0; x < 20; x = x + 1) begin: fieldOutX
				assign fieldOut[y * 20 + x] = (x-blockXInt>-1 && x-blockXInt<4 && y-blockYInt>-1 && y-blockYInt<4 && fieldMatrix[x][y]==1'b0)? blockMatrix[x-blockXInt][y-blockYInt] : fieldMatrix[x][y];
			end
		end
	endgenerate
 
	wire leftOK, leftBottomTouch, rightOK, rightBottomTouch, downScore, downBottomTouch, 
		  rotateOK, rotateScore, rotateBottomTouch;
	wire [0:399] leftNewField, rightNewField, downNewField, rotateNewField;
	wire [0:15] rotateNewBlock;
 
	leftPredict my_left(field, block, blockX, blockY,
							  leftOK, leftBottomTouch, leftNewField);
							  
	rightPredict my_right(field, block, blockX, blockY,
								 rightOK, rightBottomTouch, rightNewField);
								 
	downPredict my_down(field, block, blockX, blockY, ///////
							  downScore, downBottomTouch, downNewField);
							  
	rotatePredict my_rotate(field, block, blockX, blockY, ///////
									rotateOK, rotateScore, rotateBottomTouch, rotateNewField, rotateNewBlock);
									
	reg nextBlockTrue;
	wire [0:15] randomBlockShape;
	randomShape my_randomS(blockType, randomBlockShape); ////////////////
									
	initial begin
		nextBlockTrue <= 1'b1;
		field <= 400'b0;
		block <= 16'b0;
		blockX <= 5'd8;
		blockY <= 5'b0;
	end
	
	always @(posedge clock) begin
		if (nextBlockTrue) begin
			block <= randomBlockShape;
			nextBlockTrue <= 1'b0;
		end
		else if (downTrue) begin
			score <= downScore;
			if (downBottomTouch == 1'b1) begin
				field <= downNewField;
				blockX <= 5'd8;
				blockY <= 5'b0;
				block <= 16'b0;
				nextBlockTrue <= 1'b1;
			end
			else blockY <= blockY + 16'b1;
		end
		else if (leftTrue && leftOK) begin
			if (leftBottomTouch == 1'b1) begin
				field <= leftNewField;
				blockX <= 5'd8;
				blockY <= 5'b0;
				block <= 16'b0;
				nextBlockTrue <= 1'b1;
			end
			else blockX <= blockX - 16'b1;
		end
		else if (rightTrue && rightOK) begin
			if (rightBottomTouch == 1'b1) begin
				field <= rightNewField;
				blockX <= 5'd8;
				blockY <= 5'b0;
				block <= 16'b0;
				nextBlockTrue <= 1'b1;
			end
			else blockX <= blockX + 16'b1;
		end
		else if (rotateTrue && rotateOK) begin
			score <= rotateScore;
			if (rotateBottomTouch == 1'b1) begin
				field <= rotateNewField;
				blockX <= 5'd8;
				blockY <= 5'b0;
				block <= 16'b0;
				nextBlockTrue <= 1'b1;
			end
			else block <= rotateNewBlock;
		end
	end
 
endmodule

// Syntax test for clear lines. Syntax Pass.
	/*
	wire [0:399] fW0;
	reg [0:399] field0;
	wire [0:19] lineCancel;
	always @(fW0) field0 <= fW0;
	always @(lineCancel) begin
		if (lineCancel[0] == 1'b1) field0[0:19] = field0[0:19] >> 'd20;
		if (lineCancel[1] == 1'b1) field0[0:39] = field0[0:39] >> 'd20;	
	end
	*/
