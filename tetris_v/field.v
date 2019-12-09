module field(

    
);
input clk_field;
input drop, left, right, ro;


input [9:0] rotate;
input [2:0] random;

output score_flag, gameover;
output [399:0] field_display;

reg [399:0] field_background;
reg xpos, ypos;


block_pos block_pos_background(clk, err,drop,left,right, ro,block_pos_y,block_pos_x, rotate);
block_choice block_choice_background(rotate,block_num,block_matrix);
block_expand block_expand_background(block_expand, block_matrix, block_pos_y, block_pos_x);
field_merge field_merge_background(field_merge0, field_background, block_expand);
field_check field_check_background(gameover, field_merge0, field_background, block_expand);

field_merge(block_expand, field_background);

field_check(field_merge 0, field_background);

keyinput();
block_tmp;
field_display;
field_check;

field_check field_check_game()

endmodule // 