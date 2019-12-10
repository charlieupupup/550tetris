module field_background(clk, refresh, row_down, field_in, field_out);

    input clk;

    input refresh;
    input [399:0] field_in;
    output reg [399:0] field_out;

    


    initial begin
    field_out = 399'd0;
        
    end

always @ (posedge clk) begin
    
    if (refresh == 0 || row_down == 1) begin
        field_out <= field_in;
    end
	 
end
		
	
        
endmodule
