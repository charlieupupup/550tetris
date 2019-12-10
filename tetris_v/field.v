module field(

    
);
input clk_field;
input drop, left, right, ro;


input [9:0] rotate;
input [2:0] random;

output score_flag, gameover;
output [399:0] field_display;

reg [399:0] field_old;
reg xpos, ypos;

//old scene

block_pos block_pos_old(clk, err, block_pos_refresh, block_pos_y_out_o,block_pos_x_out_o, rotate_out_o, block_pos_x_in, block_pos_y_in, rotate_in);
block_choice block_choice_old(rotate_out_o,block_num,block_matrix);
block_expand block_expand_old(block_expand_o, block_ matrix, block_pos_y_out_o, block_pos_x_out_o);

field_background field_background_old(clk, field_background_refresh, field_background_in, field_background_out);

field_merge field_merge_old(field_merge_o, field_old, block_expand_o);
field_check field_check_old(gameover, field_merge_o, field_old, block_expand_o);


//new scene

keyboard_input keyboard_input_new(clk, block_pos_y_out_o, block_pos_x_out_o, rotate_out_o, left, right, down, ro ,block_pos_x_n, block_pos_y_n);
block_expand block_expand_new(block_expand_new, block_matrix, block_pos_y_n, block_pos_x_n);

field_merge field_merge_new(field_merge_n, field_background_out, block_expand_n);
field_check field_check_new(next_block, field_merge_n, field_background_out, block_expand_n);

field_display field_display_new(clk, next_block, score_plus, field_display_out, field_display_in);
  



endmodule // 