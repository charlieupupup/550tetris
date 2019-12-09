module field(clock, leftTrue, rightTrue, downTrue, rotateTrue, blockType, // Input
				 fieldOut, nextBlockTrue, gameOver, score); // Output
				 
	input clock, leftTrue, rightTrue, downTrue, rotateTrue;
	input [2:0] blockType;
	output [0:399] fieldOut;
	output nextBlockTrue, gameOver, score;
	
	wire [0:399] fieldOut;
	wire [0:399] fieldWire;
	wire [0:15] blockWire;
	
	reg field [0:19][0:19]; // [x][y]
	reg block [0:3][0:3]; // [x][y]
	
	reg [4:0] blockX, blockY; // Block top-left coordinate.
	integer blockXInt, blockYInt;
	
	genvar x, y;
	
	
	
	
	always @(blockX) blockXInt <= blockX;
	always @(blockY) blockYInt <= blockY;
	
	generate
		for (y = 0; y < 20; y = y + 1) begin: fieldWireY
			for (x = 0; x < 20; x = x + 1) begin: fieldWireX
				assign fieldWire[y * 20 + x] = field[x][y];
			end
		end
	endgenerate
	
	generate
		for (y = 0; y < 4; y = y + 1) begin: blockWireY
			for (x = 0; x < 4; x = x + 1) begin: blockWireX
				assign blockWire[y * 4 + x] = block[x][y];
			end
		end
	endgenerate
	
	generate
		for (y = 0; y < 20; y = y + 1) begin: fieldOutY
			for (x = 0; x < 20; x = x + 1) begin: fieldOutX
				assign fieldOut[y * 20 + x] = (x-blockXInt>-1 && x-blockXInt<4 && y-blockYInt>-1 && y-blockYInt<4 && field[x][y]==1'b0)? block[x-blockXInt][y-blockYInt] : field[x][y];
			end
		end
	endgenerate
		 
endmodule
