module field_background(clk, err, row_down, field_in, field_out);

    input clk;

    input err, row_down;
    input [399:0] field_in;
    output reg [399:0] field_out;

    


    initial begin
    field_out = 399'd0;
        
    end

always @ (posedge clk) begin
    
    if(row_down == 1) begin
        field_out <= field_out & field_in;
    end
	 else if (row_down == 0 && err == 1'd1) begin
		field_out <= field_in;
	 end
	 
end
		
	
        
endmodule
