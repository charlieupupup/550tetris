module field_background(clk,
    reset,
    block_check_result,
    field_in,
    field_out
);

    input clk;

    input reset, block_check_result;
    input [399:0] field_in;
    output [399:0] field_out;

    reg [399:0] field_out;


    initial begin
    field_out = 0;
        
    end

always @ (posedge clk) begin
    
    if (reset) begin
        field_out <= 0;
    end

	else if (block_check_result) begin
	 	field_out <= field_in;
    end
	 
end
		
	
        
endmodule
