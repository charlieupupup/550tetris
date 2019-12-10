module field(clock, reset, leftTrue, rightTrue, downTrue, rotateTrue, blockType, // Input
				 fieldOut, gameOver, score); // Output
				 
	input clock, reset, leftTrue, rightTrue, downTrue, rotateTrue;
	input [2:0] blockType;
	output [0:99] fieldOut;////////
	output gameOver;
	output reg [31:0] score;
	
	reg [3:0] blockX, blockY; // Block top-left coordinate.
	
	
	wire [0:99] fieldOut; //// Final output for display.
	//assign fieldOut = field; ///// Only for testing.
	
	
	genvar x, y;
	generate // Combine field and block to fieldOut. Syntax pass.
		for (y = 0; y < 10; y = y + 1) begin: fieldOutY
			for (x = 0; x < 10; x = x + 1) begin: fieldOutX
				assign fieldOut[y * 10 + x] = (x-blockX>-1 && x-blockX<3 && y-blockY>-1 && y-blockY<3 && field[y * 10 + x]==1'b0)? block[(y-blockY)*3+(x-blockX)]: field[y * 10 + x];
			end
		end
	endgenerate
	
	
	/*
	reg [0:99] fieldOut;
	wire [7:0] blockIndex0, blockIndex1, blockIndex2;
	assign blockIndex0 = blockY * 10 + blockX;
	assign blockIndex1 = (blockY+1) * 10 + blockX;
	assign blockIndex2 = (blockY+2) * 10 + blockX;
	integer index;
	always @(clock) begin
		for (index = 0; index < 100; index = index + 1) begin
			if (index >=  blockIndex0 && index < blockIndex0 + 'd3 ) fieldOut[index] <= block[index - blockIndex0];
			else if (index >=  blockIndex1 && index < blockIndex1 + 'd3 ) fieldOut[index] <= block[index - blockIndex1 + 'd3];
			else if (index >=  blockIndex2 && index < blockIndex2 + 'd3 ) fieldOut[index] <= block[index - blockIndex2 + 'd6];
			else fieldOut[index] <= field[index];
		end
	end
	*/
	
	
	
	// Move prediction start --------------------------
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
	
	wire leftConflictTrue, leftOutTrue;
	wire [0:8] leftRotateBlock;
	wire [1:0] leftEdgeX;
	conflictCheck left_cC(field, block, leftBlockX, leftBlockY, leftConflictTrue);
	rotateAntiClock left_rAC(block, leftRotateBlock);
	blockBottom left_bB(leftRotateBlock, leftEdgeX);
	assign leftOutTrue = ((blockX % 'd10 == 'd0) && (leftEdgeX == 2'b0))? 1'b1 : 1'b0;
	assign leftOK = (~leftConflictTrue && ~leftOutTrue)? 1'b1 : 1'b0;
	
	bottomTouchCheck left_bTC(field, block, leftBlockX, leftBlockY, leftBottomTouch);
	
	// Right prediction
	wire rightOK, rightBottomTouch;
	wire [3:0] rightBlockX, rightBlockY;
	assign rightBlockX = blockX + 4'd1;
	assign rightBlockY = blockY;
	
	wire rightConflictTrue, rightOutTrue;
	wire [0:8] rightRotateBlock;
	wire [1:0] rightEdgeX;
	conflictCheck right_cC(field, block, rightBlockX, rightBlockY, rightConflictTrue);
	rotateClockWise right_rCW(block, rightRotateBlock);
	blockBottom right_bB(rightRotateBlock, rightEdgeX);
	assign rightOutTrue = (((blockX - 'd7) % 'd10 == 'd0) && (rightEdgeX == 2'b0))? 1'b1 : 1'b0;
	assign rightOK = (~rightConflictTrue && ~rightOutTrue)? 1'b1 : 1'b0;
	
	bottomTouchCheck right_bTC(field, block, rightBlockX, rightBlockY, rightBottomTouch);
	
	// Rotate prediction
	wire rotateOK, rotateBottomTouch;
	wire [3:0] rotateBlockX, rotateBlockY;
	assign rotateBlockX = blockX;
	assign rotateBlockY = blockY;
	
	wire [0:8] rotateNewBlock;
	rotateClockWise rotate_rCW(block, rotateNewBlock);
	
	wire rotateConflictTrue, rotateRightOutTrue, rotateLeftOutTrue;
	wire [0:8] rotateClockWiseBlock, rotateAntiClockBlock;
	wire [1:0] rotateRightEdgeX, rotateLeftEdgeX;
	
	conflictCheck rotate_cC(field, rotateNewBlock, rotateBlockX, rotateBlockY, rotateConflictTrue);
	
	rotateClockWise rotate_rCW2(rotateNewBlock, rotateClockWiseBlock);
	blockBottom rotateRight_bB(rotateClockWiseBlock, rotateRightEdgeX);
	
	rotateAntiClock rotate_rAC(rotateNewBlock, rotateAntiClockBlock);
	blockBottom rotateLeft_bB(rotateAntiClockBlock, rotateLeftEdgeX);
	
	assign rotateRightOutTrue = (((rotateBlockX - 'd7) % 'd10 == 'd0) && (rotateRightEdgeX == 2'b0))? 1'b1 : 1'b0;
	assign rotateLeftOutTrue = ((rotateBlockX % 'd10 == 'd0) && (rotateLeftEdgeX == 2'b0))? 1'b1 : 1'b0;
	assign rotateOK = (~rotateConflictTrue && ~rotateRightOutTrue && ~rotateLeftOutTrue)? 1'b1 : 1'b0;
	
	bottomTouchCheck rotate_bTC(field, rotateNewBlock, rotateBlockX, rotateBlockY, rotateBottomTouch);
	
	
	// Choose one from the four
	wire moveTrue;
	assign moveTrue = downTrue | rightTrue | leftTrue | rotateTrue;
	
	reg opOK, bottomTouch;
	wire [3:0] moveSelect;
	assign moveSelect[0] = downTrue;
	assign moveSelect[1] = rightTrue;
	assign moveSelect[2] = leftTrue;
	assign moveSelect[3] = rotateTrue;
	
	always @(*) begin
		if (moveSelect[0]) begin
			opOK = 1'b1;
			bottomTouch = downBottomTouch;
		end
		else if (moveSelect[1]) begin
			opOK = rightOK;
			bottomTouch = rightBottomTouch;
		end
		else if (moveSelect[2]) begin
			opOK = leftOK;
			bottomTouch = leftBottomTouch;
		end
		else if (moveSelect[3]) begin
			opOK = rotateOK;
			bottomTouch = rotateBottomTouch;
		end
		else begin
			opOK = 1'b0;
			bottomTouch = 1'b0;
		end
	end
	
	// Move prediction end --------------------------

	
	


	// Random shape production.
	wire [0:8] randomBlockShape;
	randomShape my_randomS(blockType, randomBlockShape); ////////////////
 
 

	// Main always block
	
	initial begin		
		blockX <= 4'd4;
		blockY <= 4'b0;
	end
	
	always @(posedge clock) begin
		if (reset) begin
			blockX <= 4'd4;
			blockY <= 4'b0;
		end
		else if (bottomTouch) begin
			blockX <= 4'd4;
			blockY <= 4'b0;
		end
		else if (leftTrue && leftOK) begin
			blockX <= blockX - 4'b1;
		end
		else if (rightTrue && rightOK) begin
			blockX <= blockX + 4'b1;
		end
		else if (rotateTrue && rotateOK) begin
			blockX <= blockX;
			blockY <= blockY;
		end
		else if (downTrue) begin		
			blockY <= blockY + 4'b1;
		end
	end
	
	// ----------------------------------------------
	
	
	// Core matrix registers start ----------------------------------	
		
		reg [0:8] block;
		initial block <= 9'h92;
		always@(posedge clock or posedge reset) begin
			if (reset) begin
				block <= 9'h92;
			end
  
			else if(rotateOK && rotateTrue) begin //player hits rotate button on keyboard and rotate is OK (no collision)
				block[0] <= block[6];
				block[1] <= block[3];
				block[2] <= block[0];
				block[3] <= block[7];
				block[4] <= block[4];
				block[5] <= block[1];
				block[6] <= block[8];
				block[7] <= block[5];
				block[8] <= block[2];
			end

			else if(bottomTouch) begin //last square is collided, load a new one
				block <= randomBlockShape;
			end

			else begin
				block <= block; //no new block, no rotate, then we hold the current block
			end
		end

		
	// Core matrix registers end----------------------------------
	
	
	
	// Background matrix start----------------------------------------------------
	
	reg [0:99] field;
	initial begin
		field <= 100'h0000000000;
		score <= 'd0; ////
	end
	
	integer i, j;
	always @(clock) begin
		if (moveTrue && opOK && bottomTouch) begin
			for (j = 0; j < 3; j = j + 1) begin: newFieldY
				for (i = 0; i < 3; i = i + 1) begin: newFieldX
					field[(blockY + j) * 10 + blockX + i] <= block[j * 3 + i];					
				end
			end
		end
	end
	
	
	// Background matrix end----------------------------------------------------
	
	
endmodule


