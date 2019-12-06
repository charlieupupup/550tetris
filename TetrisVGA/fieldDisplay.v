module fieldDisplay(ADDR, field, bgr_data_raw);

	input [18:0] ADDR;
	input [399:0] field;
	output reg [23:0] bgr_data_raw;
	
	wire [18:0] ADDRcolumn, ADDRrow;
	assign ADDRcolumn = ADDR % 'd640;
	assign ADDRrow = ADDR / 'd640;
	wire [4:0] x, y;
	assign x = ADDRcolumn / 'd24;
	assign y = ADDRrow / 'd24;
	
	integer /*fieldIndex,*/ xInt, yInt;
	always @(x) xInt = x;
	always @(y) yInt = y;	
	//fieldIndex = yInt * 20 + xInt;
	
	always @(*) begin
		if (xInt > 19) bgr_data_raw <= 24'hd3b06b; // Score board background colour.
		else if (field[yInt * 20 + xInt] == 1'b1) bgr_data_raw <= 24'hb47c3c; // Square color.
		else if (field[yInt * 20 + xInt] == 1'b0) bgr_data_raw <= 24'h000000; // Background color.
	end
	
endmodule
