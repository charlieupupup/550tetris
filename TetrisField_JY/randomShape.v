module randomShape(blockType, randomBlockShape);

	input [2:0] blockType;
	output reg [0:15] randomBlockShape;
	
	always @(blockType) begin
		if (blockType == 3'd0) randomBlockShape <= 16'hccff;
		else if (blockType == 3'd1) randomBlockShape <= 16'h0660;
		else if (blockType == 3'd2) randomBlockShape <= 16'hff66;
		else if (blockType == 3'd3) randomBlockShape <= 16'h6ff6;
		else if (blockType == 3'd4) randomBlockShape <= 16'h6666;
		else randomBlockShape <= 16'h0;
	end

endmodule
