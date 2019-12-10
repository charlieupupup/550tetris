module field_background(clk, err, row_down, field_in, field_out);

    input clk;

    input err, row_down;
    input [399:0] field_in;
    output reg [399:0] field_out;

    


    initial begin
    field_out = 399'd0;
        
    end

always @ (posedge clk) begin
    
    if(err == 0 || row_down == 1) begin
        field_out <= field_in;
    end
	 
end
		
	
        
endmodule
