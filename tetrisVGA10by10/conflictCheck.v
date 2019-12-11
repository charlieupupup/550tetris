module conflictCheck(field, block, blockX, blockY, conflictTrue);

	input [0:99] field;
	input [0:8] block;
	input [3:0] blockX, blockY;
	output reg conflictTrue;

	initial conflictTrue = 1'b0;
	
	integer x, y;
	always @(*) begin
		conflictTrue = 1'b0;
		for (y = 0; y < 3; y = y + 1) begin
			for (x = 0; x < 3; x = x + 1) begin
				if (block[y * 3 + x] == 1'b0) conflictTrue = conflictTrue;
				else if (field[(blockY + y) * 10 + blockX + x] == 1'b1) conflictTrue = 1'b1;
				else conflictTrue = conflictTrue;
			end
		end
	end
	
	/*
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
	*/
	
endmodule
