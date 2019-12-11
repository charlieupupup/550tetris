module field(clock, reset, leftTrue, rightTrue, downTrue, rotateTrue, blockType, // Input
				 fieldOut, score); // Output
				 
	input clock, reset, leftTrue, rightTrue, downTrue, rotateTrue;
	input [2:0] blockType;
	output [0:99] fieldOut;////////
	output reg [31:0] score;
	
	reg [0:99] fieldOut;
	//wire [0:99] fieldOut;
	
	// Abandon the merge codes. Does not work.
	/*
	wire [0:99] fieldOut; //// Final output for display.
	genvar x, y;
	generate // Combine field and block to fieldOut. Syntax pass.
		for (y = 0; y < 10; y = y + 1) begin: fieldOutY
			for (x = 0; x < 10; x = x + 1) begin: fieldOutX
				assign fieldOut[y * 10 + x] = (x-blockX>-1 && x-blockX<3 && y-blockY>-1 && y-blockY<3 && field[y * 10 + x]==1'b0)? block[(y-blockY)*3+(x-blockX)]: field[y * 10 + x];
			end
		end
	endgenerate
	*/
	

	wire [7:0] blockIndex0, blockIndex1, blockIndex2;
	assign blockIndex0 = blockY * 10 + blockX;
	assign blockIndex1 = (blockY+1) * 10 + blockX;
	assign blockIndex2 = (blockY+2) * 10 + blockX;
	integer index;
	always @(*) begin
		for (index = 0; index < 100; index = index + 1) begin
			if (index >=  blockIndex0 && index < blockIndex0 + 'd3 && block[index - blockIndex0] == 1'b1) fieldOut[index] <= block[index - blockIndex0];
			else if (index >=  blockIndex1 && index < blockIndex1 + 'd3 && block[index - blockIndex1 + 'd3] == 1'b1) fieldOut[index] <= block[index - blockIndex1 + 'd3];
			else if (index >=  blockIndex2 && index < blockIndex2 + 'd3 && block[index - blockIndex2 + 'd6] == 1'b1) fieldOut[index] <= block[index - blockIndex2 + 'd6];
			else fieldOut[index] <= field[index];
		end
	end
	
	
	
	
	// Move prediction start --------------------------
	// Game stop prediction
	reg gameOver;
	initial gameOver = 1'b0;
	wire gameOverConflict;
	conflictCheck gameOver_cC(field, block, blockX, blockY, gameOverConflict);
	always @(*) begin
		if (blockX == 4'd4 && blockY == 4'd0 && gameOverConflict) gameOver = 1'b1;
		else gameOver = 1'b0;
	end
	
	
	// Down prediction
	wire downBottomTouch;
	wire [3:0] downBlockX, downBlockY;
	assign downBlockX = blockX;
	assign downBlockY = blockY + 4'b1;
	
	bottomTouchCheck down_bTC(field, block, downBlockX, downBlockY, downBottomTouch);
	
	//Left prediction
	wire leftOK, leftBottomTouch;
	wire [3:0] leftBlockX, leftBlockY;
	assign leftBlockX = blockX - 4'd1;
	assign leftBlockY = blockY;
	
	wire leftConflictTrue;
	reg leftOutTrue;
	initial leftOutTrue <= 1'b0;
	conflictCheck left_cC(field, block, leftBlockX, leftBlockY, leftConflictTrue);
	always @(*) begin
		if (blockX == 4'd0 && (block[0] || block[3] || block[6])) leftOutTrue = 1'b1;
		else if (blockX == 4'd9 && (block[1] || block[4] || block[7])) leftOutTrue = 1'b1;
		else if (blockX == 4'd8 && (block[2] || block[5] || block[8])) leftOutTrue = 1'b1;
		else leftOutTrue = 1'b0;
	end
	assign leftOK = (~leftConflictTrue && ~leftOutTrue)? 1'b1 : 1'b0;
	
	bottomTouchCheck left_bTC(field, block, leftBlockX, leftBlockY, leftBottomTouch);
	
	// Right prediction
	wire rightOK, rightBottomTouch;
	wire [3:0] rightBlockX, rightBlockY;
	assign rightBlockX = blockX + 4'd1;
	assign rightBlockY = blockY;
	
	wire rightConflictTrue;
	reg rightOutTrue;
	initial rightOutTrue <= 1'b0;
	conflictCheck right_cC(field, block, rightBlockX, rightBlockY, rightConflictTrue);
	always @(*) begin
		if (blockX == 4'd7 && (block[2] || block[5] || block[8])) rightOutTrue = 1'b1;
		else if (blockX == 4'd8 && (block[1] || block[4] || block[7])) rightOutTrue = 1'b1;
		else if (blockX == 4'd9 && (block[0] || block[3] || block[6])) rightOutTrue = 1'b1;
		else rightOutTrue = 1'b0;
	end
	assign rightOK = (~rightConflictTrue && ~rightOutTrue)? 1'b1 : 1'b0;
	
	bottomTouchCheck right_bTC(field, block, rightBlockX, rightBlockY, rightBottomTouch);
	
	// Rotate prediction
	wire rotateOK, rotateBottomTouch;
	wire [3:0] rotateBlockX, rotateBlockY;
	assign rotateBlockX = blockX;
	assign rotateBlockY = blockY;
	
	wire [0:8] rotateNewBlock;
	rotateClockWise rotate_rCW(block, rotateNewBlock);
	
	wire rotateConflictTrue/*, rotateRightOutTrue, rotateLeftOutTrue*/;
	//wire [0:8] rotateClockWiseBlock, rotateAntiClockBlock;
	//wire [1:0] rotateRightEdgeX, rotateLeftEdgeX;
	conflictCheck rotate_cC(field, rotateNewBlock, rotateBlockX, rotateBlockY, rotateConflictTrue);
	/*
	rotateClockWise rotate_rCW2(rotateNewBlock, rotateClockWiseBlock);
	blockBottom rotateRight_bB(rotateClockWiseBlock, rotateRightEdgeX);
	
	rotateAntiClock rotate_rAC(rotateNewBlock, rotateAntiClockBlock);
	blockBottom rotateLeft_bB(rotateAntiClockBlock, rotateLeftEdgeX);
	
	assign rotateRightOutTrue = (((rotateBlockX - 'd7) % 'd10 == 'd0) && (rotateRightEdgeX == 2'b0))? 1'b1 : 1'b0;
	assign rotateLeftOutTrue = ((rotateBlockX % 'd10 == 'd0) && (rotateLeftEdgeX == 2'b0))? 1'b1 : 1'b0;
	*/
	assign rotateOK = (~rotateConflictTrue && blockX >= 4'd0 && blockX <= 4'd7)? 1'b1 : 1'b0;
	
	
	
	bottomTouchCheck rotate_bTC(field, rotateNewBlock, rotateBlockX, rotateBlockY, rotateBottomTouch);
	
	
	// Choose one from the four
	//wire moveTrue;
	//assign moveTrue = downTrue | rightTrue | leftTrue | rotateTrue;
	
	reg opOK, bottomTouch;
	//wire [3:0] moveSelect;
	//assign moveSelect[0] = downTrue;
	//assign moveSelect[1] = rightTrue;
	//assign moveSelect[2] = leftTrue;
	//assign moveSelect[3] = rotateTrue;
	
	reg [3:0] nextBlockX, nextBlockY;
	reg [0:8] nextBlock;
	
	always @(*) begin
		if (downTrue) begin
			opOK = 1'b1;
			bottomTouch = downBottomTouch;
			nextBlockX = blockX;
			nextBlockY = blockY + 4'b1;
			nextBlock = block;
		end
		else if (rightTrue) begin
			opOK = rightOK;
			bottomTouch = rightBottomTouch;
			nextBlockX = blockX + 1'b1;
			nextBlockY = blockY;
			nextBlock = block;
		end
		else if (leftTrue) begin
			opOK = leftOK;
			bottomTouch = leftBottomTouch;
			nextBlockX = blockX - 1'b1;
			nextBlockY = blockY;
			nextBlock = block;
		end
		else if (rotateTrue) begin
			opOK = rotateOK;
			bottomTouch = rotateBottomTouch;
			nextBlockX = blockX;
			nextBlockY = blockY;
			nextBlock = rotateNewBlock;
		end
		else begin
			opOK = 1'b0;
			bottomTouch = 1'b0;
			nextBlockX = blockX;
			nextBlockY = blockY;
			nextBlock = block;
		end
	end
	
	
	// Move prediction end --------------------------

	
	


	// Random shape production.
	reg [0:8] randomBlockShape;
	initial randomBlockShape = 9'h17;
	always @(blockType) begin
		if (blockType == 3'd0 && ~gameOver) randomBlockShape <= 9'h198;
		else if (blockType == 3'd1 && ~gameOver) randomBlockShape <= 9'h1e0;
		else if (blockType == 3'd2 && ~gameOver) randomBlockShape <= 9'h92;
		else if (blockType == 3'd3 && ~gameOver) randomBlockShape <= 9'h1b0;
		else if (blockType == 3'd4 && ~gameOver) randomBlockShape <= 9'h1d0;
		else if (blockType == 3'd5 && ~gameOver) randomBlockShape <= 9'hf0;
		else randomBlockShape <= randomBlockShape;
	end
 
 

	// Main always block
	
	reg [3:0] blockX, blockY; // Block top-left coordinate.
	reg [3:0] realblockX, realblockY;
	initial begin		
		realblockX <= 4'd4;
		realblockY <= 4'b0;
	end
	
	always @(negedge clock) begin //////////////
		if (reset) begin
			realblockX <= 4'd4;
			realblockY <= 4'b0;
		end
		else if (bottomTouch) begin
			realblockX <= 4'd4;
			realblockY <= 4'b0;
		end
		else if (leftTrue && leftOK) begin
			realblockX <= realblockX - 4'b1;
		end
		else if (rightTrue && rightOK) begin
			realblockX <= realblockX + 4'b1;
		end
		else if (rotateTrue && rotateOK) begin
			realblockX <= realblockX;
			realblockY <= realblockY;
		end
		else if (downTrue) begin		
			realblockY <= realblockY + 4'b1;
		end
				
	end
	
	// ----------------------------------------------
	
	
	// Core matrix registers start ----------------------------------	
		
		reg [0:8] block;
		reg [0:8] realblock;
		initial realblock <= 9'h92;
		always@(negedge clock or posedge reset) begin ////////////////
			if (reset) begin
				realblock <= 9'h92;
			end
			else if(rotateOK && rotateTrue) begin //player hits rotate button on keyboard and rotate is OK (no collision)
				realblock[0] <= realblock[6];
				realblock[1] <= realblock[3];
				realblock[2] <= realblock[0];
				realblock[3] <= realblock[7];
				realblock[4] <= realblock[4];
				realblock[5] <= realblock[1];
				realblock[6] <= realblock[8];
				realblock[7] <= realblock[5];
				realblock[8] <= realblock[2];
			end
			else if(bottomTouch) begin //last square is collided, load a new one
				realblock <= randomBlockShape;
			end
			else begin
				realblock <= realblock; //no new block, no rotate, then we hold the current block
			end
			
		end

		
	// Core matrix registers end----------------------------------
	
	
	
	// Background matrix start----------------------------------------------------
	
	reg [0:99] field;
	reg [0:99] realfield;
	initial begin
		realfield <= 100'h0000000000;
		score <= 'd0; ////
	end
	
	integer i, j;
	always @(negedge clock or posedge reset) begin ////////////
		if (reset) realfield <= 100'h0000000000;
		else if (/*moveTrue &&*/ opOK && bottomTouch) begin
			for (j = 0; j < 3; j = j + 1) begin
				for (i = 0; i < 3; i = i + 1) begin
					if (nextBlock[j * 3 + i] == 1'b1) realfield[(nextBlockY + j) * 10 + nextBlockX + i] <= nextBlock[j * 3 + i];					
				end
			end
		end
		
	end
	
	
	// Background matrix end----------------------------------------------------
	
	// Update matrixes for prediction from real.
	always @(posedge clock) begin
		if (reset) begin
			blockX <= 4'd4;
			blockY <= 4'd0;
			block <= 9'h92;
			field <= 100'b0;
		end
		else begin
			blockX <= realblockX;
			blockY <= realblockY;
			block <= realblock;
			field <= realfield;
		end
	end
	
	
endmodule


