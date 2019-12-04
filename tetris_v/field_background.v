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
	 
	integer i;

    /*initial begin
    for(i=0; i<400; i=i+1) begin
        field_out = 0;
    end
        
    end*/

    always @ (*) 
    if (block_check_result==1'b0) begin
	 for(i=0; i<400; i=i+1) begin
        field_out[i] = field_in[i];
    end
        
    end
 
endmodule