module speedUp(clock_b, speedTrue, downTrue);

	input clock_b, speedTrue; 
	output reg downTrue;
	//output reg [0:99] field;
	
	reg [3:0] speedCount;
	wire [3:0] speedLimit;
	
	assign speedLimit = (speedTrue == 1'b1)? 4'd1 : 4'd10;
	
	initial begin
		//field <= 100'b00001;
		downTrue <= 1'b0;
		speedCount <= 4'b0;
	end
	
	always @(posedge clock_b) begin
		if (speedCount < speedLimit) begin 
			speedCount <= speedCount + 4'b1;
			downTrue <= 1'b0;
		end
		else begin
			speedCount <= 4'b0;
			downTrue <= 1'b1;
			//if (field == 100'b0) field <= 100'b00001;
			//else field <= field << 'd10;
		end
	end

endmodule
