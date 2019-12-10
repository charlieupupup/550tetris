module conflictCheck(field, block, blockX, blockY, conflictTrue);

	input [0:99] field;
	input [0:8] block;
	input [3:0] blockX, blockY;
	output wire conflictTrue;

	wire [0:8] conflictFlag;

	genvar x, y;
	generate // Detect conflict. Syntax pass.
		for (y = 0; y < 3; y = y + 1) begin: andGateY
			for (x = 0; x < 3; x = x + 1) begin: andGateX
				and and_(conflictFlag[y * 3 + x], block[y * 3 + x], field[(blockY + y) * 10 + blockX + x]);
			end
		end
	endgenerate

	assign conflictTrue = (conflictFlag == 9'b0)? 1'b0 : 1'b1;
	
endmodule
