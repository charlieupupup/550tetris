module positionMove(startX, startY, key, keyCLK);

	input [3:0] key;
	input keyCLK; // 10 Mz
	output [9:0] startX, startY;
	
	wire [3:0] key;
	wire keyCLK;
	reg [9:0] startX, startY;
	reg moveFlag;
	
	initial begin
	startX <= 'd192;
	startY <= 'd144;
	moveFlag <= 1'b0;
	end
	
	integer count;
	initial count = 0;
	always @(posedge keyCLK) begin
		count = count + 1;
		if (count > 18'd250000) begin // moveFlag period = 50 ms
			moveFlag <= ~moveFlag;
			count <= 0;
		end
	end
	
	always @(posedge moveFlag) begin
		case (key[1:0])
			2'b10 : startY = startY + 10'd10;
			2'b01 : startY = startY - 10'd10;
		endcase
		case (key[3:2])
			2'b10 : startX = startX - 10'd10;
			2'b01 : startX = startX + 10'd10;
		endcase
	end

endmodule
