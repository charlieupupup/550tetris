module randomShape(blockType, randomBlockShape);

	input [2:0] blockType;
	output reg [0:8] randomBlockShape;
	
	always @(blockType) begin
		if (blockType == 3'd0) randomBlockShape <= 9'h198;
		else if (blockType == 3'd1) randomBlockShape <= 9'h27;
		else if (blockType == 3'd2) randomBlockShape <= 9'h92;
		else if (blockType == 3'd3) randomBlockShape <= 9'h36;
		else if (blockType == 3'd4) randomBlockShape <= 9'h17;
		else if (blockType == 3'd5) randomBlockShape <= 9'h97;
		else randomBlockShape <= 9'h0;
	end

endmodule
