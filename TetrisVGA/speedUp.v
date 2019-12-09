module speedUp(clock_b, speedTrue, field);

	input clock_b, speedTrue; 
	output reg [399:0] field;
	
	reg [3:0] speedCount;
	wire [3:0] speedLimit;
	
	assign speedLimit = (speedTrue == 1'b1)? 4'd1 : 4'd10;
	
	initial begin
		field <= 400'b1000000000;
		speedCount <= 4'b0;
	end
	
	always @(posedge clock_b) begin
		if (speedCount < speedLimit) speedCount <= speedCount + 4'b1;
		else begin
			speedCount <= 4'b0;
			if (field == 400'b0) field <= 400'b1000000000;
			else field <= field << 'd20;
		end
	end

endmodule
