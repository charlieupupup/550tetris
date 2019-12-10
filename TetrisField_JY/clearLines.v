module clearLines(temField, newField, score); ///////

	input [0:399] temField;
	output wire [0:399] newField;
	output wire score;
	
	assign score = 1'b0; /////
	assign newField = temField; //////
	
	

endmodule

/*
	wire [0:399] fW0;
	reg [0:399] field0;
	wire [0:19] lineCancel;
	always @(fW0) field0 <= fW0;
	always @(lineCancel) begin
		if (lineCancel[0] == 1'b1) field0[0:19] = field0[0:19] >> 'd20;
		if (lineCancel[1] == 1'b1) field0[0:39] = field0[0:39] >> 'd20;	
	end
	*/