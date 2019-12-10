module fieldDisplay(ADDR, field, score, bgr_data_raw);

	input [18:0] ADDR;
	input [0:99] field;
	input [31:0] score;
	output reg [23:0] bgr_data_raw;
	
	wire [18:0] ADDRcolumn, ADDRrow;
	wire [23:0] score_data_raw;
	assign ADDRcolumn = ADDR % 'd640;
	assign ADDRrow = ADDR / 'd640;
	wire [3:0] x, y;
	assign x = ADDRcolumn / 'd48;
	assign y = ADDRrow / 'd48;
	
	integer /*fieldIndex,*/ xInt, yInt;
	always @(x) xInt = x;
	always @(y) yInt = y;	
	//fieldIndex = yInt * 10 + xInt;
	
	scoreDisplay my_scoreD(ADDRcolumn, ADDRrow, score, score_data_raw);
	
	always @(*) begin
		if (xInt > 9) bgr_data_raw = score_data_raw; // Score board background colour.
		else if (field[yInt * 10 + xInt] == 1'b1) bgr_data_raw = 24'h00aa00; // Square color.
		else if (field[yInt * 10 + xInt] == 1'b0) bgr_data_raw = 24'h000000; // Background color.
		else bgr_data_raw = 24'h000000;
	end
	
endmodule
