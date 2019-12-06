module field_merge_func(
    rotate,
    block_pos_x,
    block_pos_y,
    b_x,
    b_y,
    block_matrix,
    block_index,
    field_background,
    field_index, field_index_tmp,
    field_display
);

input [1:0] rotate;

input [4:0] block_pos_x, block_pos_y;
input [15:0] block_matrix ;

input [1:0] b_x, b_y;

input [399:0] field_background ;
output[399:0] field_display ;

input [3:0] block_index;
input [8:0] field_index;




reg  [399:0] field_display ;

output [8:0] field_index_tmp;
assign field_index_tmp = field_index;


initial begin
field_display = 0;
end

/*
integer i;
always @(*)begin
	
	for(i=0; i <=399; i = i + 1 )begin	

		if(i==field_index)begin
			field_display[i] = 1;
		end
	end
end
*/

always @(posedge clk) 
if (block_pos_x + b_x < 20 && block_pos_y + b_y < 20) begin

field_display[field_index] <= block_matrix[block_index];  
end

    
   
endmodule // field_merge