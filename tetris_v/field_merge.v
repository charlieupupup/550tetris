module field_merge(rotate, block_pos_x, block_pos_y, block_matrix, field_background, field_display
    
);

input [1:0] rotate;
input [4:0] block_pos_x, block_pos_y;
input [15:0] block_matrix;

input [399:0] field_background;



output [399:0] field_display;

field_merge_cell field_merge_cell_0(block_pos_x, block_pos_y, 0, 0, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_1(block_pos_x, block_pos_y, 0, 1, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_2(block_pos_x, block_pos_y, 0, 2, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_3(block_pos_x, block_pos_y, 0, 3, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_4(block_pos_x, block_pos_y, 1, 0, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_5(block_pos_x, block_pos_y, 1, 1, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_6(block_pos_x, block_pos_y, 1, 2, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_7(block_pos_x, block_pos_y, 1, 3, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_8(block_pos_x, block_pos_y, 2, 0, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_9(block_pos_x, block_pos_y, 2, 1, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_10(block_pos_x, block_pos_y, 2, 2, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_11(block_pos_x, block_pos_y, 2, 3, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_12(block_pos_x, block_pos_y, 3, 0, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_13(block_pos_x, block_pos_y, 3, 1, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_14(block_pos_x, block_pos_y, 3, 2, rotate,block_matrix,field_background,field_display);
field_merge_cell field_merge_cell_15(block_pos_x, block_pos_y, 3, 3, rotate,block_matrix,field_background,field_display);


endmodule // field_merge    