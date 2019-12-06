module field_background(
    reset,
    block_check_result,
    field_in,
    field_out
);

    input reset, block_check_result;
    input [399:0] field_in;
    output [399:0] field_out;

    reg [399:0] field_out;


    initial begin
    field_out = 0;
        
    end

always @ (*) begin
    
    if (reset == 1) begin
            field_out = 0;
    end
	else if (block_check_result==1'b1) begin
	 
	field_out = field_in;
    end
	 
	else begin
	field_out = field_out;
    end
end
		
	
        
    
 
endmodule
