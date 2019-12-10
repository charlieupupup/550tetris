module digitDisplay(x, y, digit, score_raw);

	input [2:0] x, y;
	input [3:0] digit;
	output wire [23:0] score_raw;
	
	reg [0:14] digitShape;
	always @(digit) begin
		case (digit)
			4'd0 : digitShape <= 15'h7b6f;
			4'd1 : digitShape <= 15'h2492;
			4'd2 : digitShape <= 15'h73e7;
			4'd3 : digitShape <= 15'h73cf;
			4'd4 : digitShape <= 15'h5bc9;
			4'd5 : digitShape <= 15'h79cf;
			4'd6 : digitShape <= 15'h79ef;
			4'd7 : digitShape <= 15'h7249;
			4'd8 : digitShape <= 15'h7bef;
			4'd9 : digitShape <= 15'h7bcf;
			default : digitShape <= 15'h0;
		endcase
	end

	integer xInt, yInt;
	always @(x) xInt = x;
	always @(y) yInt = y;
	assign score_raw = (digitShape[yInt * 3 + xInt] == 1'b1)? 24'h00aa00 : 24'h4f223b;
	
endmodule
