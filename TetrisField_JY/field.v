module field(clock, reset, leftTrue, rightTrue, downTrue, rotateTrue, blockType, // Input
				 fieldOut, gameOver, score); // Output
				 
	input clock, reset, leftTrue, rightTrue, downTrue, rotateTrue;
	input [2:0] blockType;
	output [0:399] fieldOut;
	output gameOver;
	output reg score; ////////////////// Score might be larger than one!!!!!
	
	wire [0:399] fieldOut; // Final output for display.
	reg [0:399] field; ////
	/*
	wire [399:0] reverseField;
	genvar i;
	generate
		for (i = 0; i < 400; i = i + 1) begin: reverseFieldArray
			assign field[i] = reverseField[i];
		end
	endgenerate*/
	
	wire [0:15] block;
	reg [4:0] blockX, blockY; // Block top-left coordinate.
	
	integer blockXInt, blockYInt;
	always @(blockX) blockXInt <= blockX;
	always @(blockY) blockYInt <= blockY;
	genvar x, y;
	generate // Combine field and block to fieldOut. Syntax pass.
		for (y = 0; y < 20; y = y + 1) begin: fieldOutY
			for (x = 0; x < 20; x = x + 1) begin: fieldOutX
				assign fieldOut[y * 20 + x] = (x-blockXInt>-1 && x-blockXInt<4 && y-blockYInt>-1 && y-blockYInt<4 && field[y * 20 + x]==1'b0)? block[(y-blockYInt)*4+(x-blockXInt)]: field[y * 20 + x];
			end
		end
	endgenerate
	
	
	
	
	// Move prediction start --------------------------
	// Down prediction
	wire downBottomTouch;
	wire [4:0] downBlockX, downBlockY;
	assign downBlockX = blockX;
	assign downBlockY = blockY + 5'b1;
	
	bottomTouchCheck down_bTC(field, block, downBlockX, downBlockY, downBottomTouch);
	
	//Left prediction
	wire leftOK, leftBottomTouch;
	wire [4:0] leftBlockX, leftBlockY;
	assign leftBlockX = blockX - 5'd1;
	assign leftBlockY = blockY;
	
	wire leftConflictTrue, leftOutTrue;
	wire [0:15] leftRotateBlock;
	wire [1:0] leftEdgeX;
	conflictCheck left_cC(field, block, leftBlockX, leftBlockY, leftConflictTrue);
	rotateAntiClock left_rAC(block, leftRotateBlock);
	blockBottom left_bB(leftRotateBlock, leftEdgeX);
	assign leftOutTrue = ((blockX % 'd20 == 'd0) && (leftEdgeX == 2'b0))? 1'b1 : 1'b0;
	assign leftOK = (~leftConflictTrue && ~leftOutTrue)? 1'b1 : 1'b0;
	
	bottomTouchCheck left_bTC(field, block, leftBlockX, leftBlockY, leftBottomTouch);
	
	// Right prediction
	wire rightOK, rightBottomTouch;
	wire [4:0] rightBlockX, rightBlockY;
	assign rightBlockX = blockX + 5'd1;
	assign rightBlockY = blockY;
	
	wire rightConflictTrue, rightOutTrue;
	wire [0:15] rightRotateBlock;
	wire [1:0] rightEdgeX;
	conflictCheck right_cC(field, block, rightBlockX, rightBlockY, rightConflictTrue);
	rotateClockWise right_rCW(block, rightRotateBlock);
	blockBottom right_bB(rightRotateBlock, rightEdgeX);
	assign rightOutTrue = (((blockX - 'd16) % 'd20 == 'd0) && (rightEdgeX == 2'b0))? 1'b1 : 1'b0;
	assign rightOK = (~rightConflictTrue && ~rightOutTrue)? 1'b1 : 1'b0;
	
	bottomTouchCheck right_bTC(field, block, rightBlockX, rightBlockY, rightBottomTouch);
	
	// Rotate prediction
	wire rotateOK, rotateBottomTouch;
	wire [4:0] rotateBlockX, rotateBlockY;
	assign rotateBlockX = blockX;
	assign rotateBlockY = blockY;
	
	wire [0:15] rotateNewBlock;
	rotateClockWise rotate_rCW(block, rotateNewBlock);
	
	wire rotateConflictTrue, rotateRightOutTrue, rotateLeftOutTrue;
	wire [0:15] rotateClockWiseBlock, rotateAntiClockBlock;
	wire [1:0] rotateRightEdgeX, rotateLeftEdgeX;
	
	conflictCheck rotate_cC(field, rotateNewBlock, rotateBlockX, rotateBlockY, rotateConflictTrue);
	
	rotateClockWise rotate_rCW2(rotateNewBlock, rotateClockWiseBlock);
	blockBottom rotateRight_bB(rotateClockWiseBlock, rotateRightEdgeX);
	
	rotateAntiClock rotate_rAC(rotateNewBlock, rotateAntiClockBlock);
	blockBottom rotateLeft_bB(rotateAntiClockBlock, rotateLeftEdgeX);
	
	assign rotateRightOutTrue = (((rotateBlockX - 'd16) % 'd20 == 'd0) && (rotateRightEdgeX == 2'b0))? 1'b1 : 1'b0;
	assign rotateLeftOutTrue = ((rotateBlockX % 'd20 == 'd0) && (rotateLeftEdgeX == 2'b0))? 1'b1 : 1'b0;
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
	wire [0:15] randomBlockShape;
	randomShape my_randomS(blockType, randomBlockShape); ////////////////
 
 
 
 
	
	// Core matrix registers start ----------------------------------	
		
		reg [0:15] current_block;
		assign block = current_block;
		initial current_block <= 16'h6666;
		always@(posedge clock or posedge reset) begin
			if (reset) begin
				current_block <= 16'h6666;
			end
  
			else if(rotateOK && rotateTrue) begin //player hits rotate button on keyboard and rotate is OK (no collision)
				current_block[0] <= current_block[12];
				current_block[1] <= current_block[8];
				current_block[2] <= current_block[4];
				current_block[3] <= current_block[0];
				current_block[4] <= current_block[13];
				current_block[5] <= current_block[9];
				current_block[6] <= current_block[5];
				current_block[7] <= current_block[1];
				current_block[8] <= current_block[14];
				current_block[9] <= current_block[10];
				current_block[10] <= current_block[6];
				current_block[11] <= current_block[2];
				current_block[12] <= current_block[15];
				current_block[13] <= current_block[11];
				current_block[14] <= current_block[7];
				current_block[15] <= current_block[3];
			end

			else if(bottomTouch) begin //last square is collided, load a new one
				current_block <= randomBlockShape;
			end

			else begin
				current_block <= current_block; //no new block, no rotate, then we hold the current block
			end
		end

		
	// Core matrix registers end----------------------------------

	
	

	// Main always block
	initial begin		
		blockX <= 5'd8;
		blockY <= 5'b0;
	end
	
	always @(posedge clock) begin
		if (reset) begin
			blockX <= 5'd8;
			blockY <= 5'b0;
		end
		else if (bottomTouch) begin
			blockX <= 5'd8;
			blockY <= 5'b0;
		end
		else if (leftTrue && leftOK) begin
			blockX <= blockX - 5'b1;
		end
		else if (rightTrue && rightOK) begin
			blockX <= blockX + 5'b1;
		end
		else if (rotateTrue && rotateOK) begin
			blockX <= blockX;
			blockY <= blockY;
		end
		else if (downTrue) begin		
			blockY <= blockY + 5'b1;
		end
	end
	
	
	// Background matrix start----------------------------------------------------
	initial field = 400'b0;
	integer i, j;
	always @(clock) begin
		if (moveTrue && opOK && bottomTouch) begin
			for (j = 0; j < 4; j = j + 1) begin: newFieldY
				for (i = 0; i < 4; i = i + 1) begin: newFieldX
					field[(blockY + j) * 20 + blockX + i] <= block[j * 4 + i];					
				end
			end
		end
	end
	
	
	
	/*
	background_always coreBackground(
		clock,
		reset,
		bottomTouch, //1'b1 means the block is collided.
		blockX,
		blockY,
		block,// 4*4 matrix ////////
		reverseField, //20*20 new background
		total_line_num); // Number of cancelled lines.
	
	
	wire clk;
   wire rst;
   wire require_new_block; //1'b1 means the block is collided.
	wire [15:0] block_rev;// 4*4 matrix
	reg [399:0] field_display_out; //20*20 new background
	wire [9:0] total_line_num;
	
	assign clk = clock;
	assign rst = reset;
   assign require_new_block = bottomTouch; //1'b1 means the block is collided.
   generate
		for (i = 0; i < 16; i = i + 1) begin: block_rev_Array
			assign block_rev[i] = block[i];
		end
	endgenerate
	assign reverseField = field_display_out; //20*20 new background assign total_line_num
	
	
	
	
	
	
	
	
	reg [9:0] total_line_num_inner;

wire [19:0] line; //representing whether each single line is full
wire is_any_line_full;

genvar gv_i;
generate for(gv_i = 0; gv_i < 20; gv_i = gv_i + 1)
    begin: line_check
        assign line[gv_i] = & field_display_out[(20 * gv_i + 19):(20 * gv_i)];
    end
endgenerate

assign is_any_line_full = | line[19:0]; //"is_any_line_full" is 1'd1 when at lease one line is full

initial begin
field_display_out <= 400'd0;
end

always @(posedge clk) begin
     if(is_any_line_full) begin
        if(line[0]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[39:20]  ;
            field_display_out[59:40]    <= field_display_out[59:40]  ;
            field_display_out[79:60]    <= field_display_out[79:60]  ;
            field_display_out[99:80]    <= field_display_out[99:80]  ;
            field_display_out[119:100]  <= field_display_out[119:100];
            field_display_out[139:120]  <= field_display_out[139:120];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[1]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[59:40]  ;
            field_display_out[79:60]    <= field_display_out[79:60]  ;
            field_display_out[99:80]    <= field_display_out[99:80]  ;
            field_display_out[119:100]  <= field_display_out[119:100];
            field_display_out[139:120]  <= field_display_out[139:120];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[2]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[79:60]  ;
            field_display_out[99:80]    <= field_display_out[99:80]  ;
            field_display_out[119:100]  <= field_display_out[119:100];
            field_display_out[139:120]  <= field_display_out[139:120];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[3]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[99:80]  ;
            field_display_out[119:100]  <= field_display_out[119:100];
            field_display_out[139:120]  <= field_display_out[139:120];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[4]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[119:100];
            field_display_out[139:120]  <= field_display_out[139:120];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[5]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[139:120];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[6]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[7]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[8]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[9]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[10]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[11]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[12]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[13]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[14]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[279:260];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[15]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[279:260];
            field_display_out[319:300]  <= field_display_out[299:280];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[16]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[279:260];
            field_display_out[319:300]  <= field_display_out[299:280];
            field_display_out[339:320]  <= field_display_out[319:300];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[17]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[279:260];
            field_display_out[319:300]  <= field_display_out[299:280];
            field_display_out[339:320]  <= field_display_out[319:300];
            field_display_out[359:340]  <= field_display_out[339:320];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[18]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[279:260];
            field_display_out[319:300]  <= field_display_out[299:280];
            field_display_out[339:320]  <= field_display_out[319:300];
            field_display_out[359:340]  <= field_display_out[339:320];
            field_display_out[379:360]  <= field_display_out[359:340];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end

        if(line[19]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[279:260];
            field_display_out[319:300]  <= field_display_out[299:280];
            field_display_out[339:320]  <= field_display_out[319:300];
            field_display_out[359:340]  <= field_display_out[339:320];
            field_display_out[379:360]  <= field_display_out[359:340];
            field_display_out[399:380]  <= field_display_out[379:360];

            total_line_num_inner <= total_line_num_inner + 1; //full line recorder
        end
    end

    else if( require_new_block ) begin
        field_display_out[blockY * 20 + blockX + 5'd0] <= block_rev[0] || field_display_out[blockY * 20 + blockX + 5'd0];
        field_display_out[blockY * 20 + blockX + 5'd1] <= block_rev[1] || field_display_out[blockY * 20 + blockX + 5'd1];
        field_display_out[blockY * 20 + blockX + 5'd2] <= block_rev[2] || field_display_out[blockY * 20 + blockX + 5'd2];
        field_display_out[blockY * 20 + blockX + 5'd3] <= block_rev[3] || field_display_out[blockY * 20 + blockX + 5'd3];        
        field_display_out[blockY * 20 + blockX + 5'd20] <= block_rev[4] || field_display_out[blockY * 20 + blockX + 5'd20];
        field_display_out[blockY * 20 + blockX + 5'd21] <= block_rev[5] || field_display_out[blockY * 20 + blockX + 5'd21];
        field_display_out[blockY * 20 + blockX + 5'd22] <= block_rev[6] || field_display_out[blockY * 20 + blockX + 5'd22];
        field_display_out[blockY * 20 + blockX + 5'd23] <= block_rev[7] || field_display_out[blockY * 20 + blockX + 5'd23];    
        field_display_out[blockY * 20 + blockX + 5'd40] <= block_rev[8] || field_display_out[blockY * 20 + blockX + 5'd40];
        field_display_out[blockY * 20 + blockX + 5'd41] <= block_rev[9] || field_display_out[blockY * 20 + blockX + 5'd41];
        field_display_out[blockY * 20 + blockX + 5'd42] <= block_rev[10] || field_display_out[blockY * 20 + blockX + 5'd42];
        field_display_out[blockY * 20 + blockX + 5'd43] <= block_rev[11] || field_display_out[blockY * 20 + blockX + 5'd43];        
        field_display_out[blockY * 20 + blockX + 5'd60] <= block_rev[12] || field_display_out[blockY * 20 + blockX + 5'd60];
        field_display_out[blockY * 20 + blockX + 5'd61] <= block_rev[13] || field_display_out[blockY * 20 + blockX + 5'd61];
        field_display_out[blockY * 20 + blockX + 5'd62] <= block_rev[14] || field_display_out[blockY * 20 + blockX + 5'd62];
        field_display_out[blockY * 20 + blockX + 5'd63] <= block_rev[15] || field_display_out[blockY * 20 + blockX + 5'd63];
        total_line_num_inner <= total_line_num_inner ;
      end
		end

  assign total_line_num = total_line_num_inner;
	
	
	*/
	// Background matrix end----------------------------------------------------
	
	
endmodule


