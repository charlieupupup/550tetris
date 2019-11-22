module displayImage(myTrue, myADDR, startX, startY, ADDR);

	input wire [9:0] startX, startY;
	input wire [18:0] ADDR;
	output wire [18:0] myADDR;
	output wire myTrue;
	
	wire [18:0] ADDRcolumn, ADDRrow;
	assign ADDRcolumn = ADDR % 'd640;
	assign ADDRrow = ADDR / 'd640 + 'd1;
	
	wire flag1, flag2, flag3, flag4, flag5, flag6;
	assign flag1 = (ADDRcolumn >= startX) ? 1'b1 : 1'b0;
	assign flag2 = (ADDRcolumn < startX + 'd64) ? 1'b1 : 1'b0;
	assign flag3 = (ADDRrow >= startY) ? 1'b1 : 1'b0;
	assign flag4 = (ADDRrow < startY + 'd48) ? 1'b1 : 1'b0;
	and and1(flag5, flag1, flag2);
	and and2(flag6, flag3, flag4);
	and and3(myTrue, flag5, flag6);	
	
	//assign myADDR = (ADDRrow - startY) * 'd640 + ADDRcolumn - startX + 'd1;
	wire [18:0] p0, p1, p2;
	assign p0 = ADDRrow - startY;
	assign p1 = p0 * 19'd640;
	assign p2 = ADDRcolumn - startX;
	assign myADDR = p1 + p2 + 19'd1;
	
	/*
	always @(*) begin
		if (ADDRcolumn >= startX) flag1 <= 1'b1;
		else flag1 <= 1'b0;
		if (ADDRcolumn < startX + 'd64) flag2 <= 1'b1;
		else flag2 <= 1'b0;
		if (ADDRrow >= startY) flag3 <= 1'b1;
		else flag3 <= 1'b0;
		if (ADDRrow < startY + 'd48) flag4 <= 1'b1;
		else flag4 <= 1'b0;
		
		//if (ADDRcolumn >= startX && ADDRcolumn < startX + 'd64 && ADDRrow >= startY && ADDRrow < startY + 'd48) begin
		if (flag1 && flag2 && flag3 && flag4) begin
			myTrue <= 1'b1;
			myADDR <= (ADDRrow - startY) * 'd640 + ADDRcolumn - startX + 'd1;
			//myADDR <= ADDR; // For test.
		end else begin
			myTrue <= 1'b0;
		end
	end
	*/

endmodule
