module field(clk, block_num, left, right, down, ro, score_plus, next_block, gameover, field_display_out

    
);

input clk, down, left, right;

input [9:0] block_num, ro;

output next_block, gameover;

output [9:0] score_plus;

output [399:0] field_display_out;




//old scene
wire  block_refresh;
wire [9:0] block_pos_y_out_o, block_pos_x_out_o, rotate_out_o;
wire [15:0] block_matrix_o;
wire [399:0] block_expand_o, field_background_out, field_merge_o;

block_pos block_pos_old(clk, next_block, block_pos_y_out_o,block_pos_x_out_o, rotate_out_o, block_pos_x_n, block_pos_y_n, rotate_out_n);
block_choice block_choice_old(rotate_out_o,block_num,block_matrix_o);
block_expand block_expand_old(block_expand_o, block_matrix_o, block_pos_y_out_o, block_pos_x_out_o);



field_background field_background_old(clk, next_block, row_down, field_display_out , field_background_out);

field_merge field_merge_old(field_merge_o, field_background_out, block_expand_o);
field_check field_check_old(gameover, field_merge_o, field_background_out, block_expand_o);


//new scene

wire  row_down;
wire [9:0] block_pos_y_n, block_pos_x_n, rotate_out_n;
wire [15:0] block_matrix_n; 
wire [399:0] block_expand_n, field_merge_n;

keyboard_input keyboard_input_new(block_pos_y_out_o, block_pos_x_out_o, rotate_out_o, left, right, down, ro ,block_pos_x_n, block_pos_y_n, rotate_out_n);

block_choice block_choice_new(rotate_out_n,block_num,block_matrix_n);
block_expand block_expand_new(block_expand_n, block_matrix_n, block_pos_y_n, block_pos_x_n);

field_merge field_merge_new(field_merge_n, field_background_out, block_expand_n);
field_check field_check_new(next_block, field_merge_n, field_background_out, block_expand_n);


field_display field_display_new(clk, next_block, row_down, score_plus, field_display_out ,field_merge_n);
  



endmodule // 