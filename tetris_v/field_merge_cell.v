module field_merge_cell(
    block_pos_x, block_pos_y,
    b_x, b_y,
    rotate,
    block_matrix,
    field_background,
    field_display  
);

input [1:0] rotate;
input [4:0] block_pos_x, block_pos_y;
input [1:0] b_x, b_y;
input [15:0] block_matrix;
input [399:0] field_background;

output [399:0] field_display;

wire [3:0] block_index;
wire [8:0] field_index;



index_block_field(block_pos_x, block_pos_y, b_x, b_y, rotate, block_index, field_index);
field_merge_func(rotate,block_pos_x,block_pos_y,b_x, b_y, block_matrix, block_index ,field_background, field_index, field_display);

endmodule // field_merge_cell