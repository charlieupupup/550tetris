module conflictCheck(field, block, blockX, blockY, conflictTrue);

	input [0:399] field;
	input [0:15] block;
	input [4:0] blockX, blockY;
	output wire conflictTrue;

	wire [0:15] conflictFlag;
	
	integer blockXInt, blockYInt;
	always @(blockX) blockXInt <= blockX;
	always @(blockY) blockYInt <= blockY;

	genvar x, y;
	generate // Detect conflict. Syntax pass.
		for (y = 0; y < 4; y = y + 1) begin: andGateY
			for (x = 0; x < 4; x = x + 1) begin: andGateX
				and and_(conflictFlag[y * 4 + x], block[y * 4 + x], field[(blockYInt + y) * 20 + blockXInt + x]);
			end
		end
	endgenerate

	assign conflictTrue = (conflictFlag == 16'b0)? 1'b0 : 1'b1;
	
endmodule
