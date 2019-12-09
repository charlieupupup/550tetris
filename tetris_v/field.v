module field(

    
);
input clk_field, rst;
input drop, left, right;


input [9:0] rotate;
input [2:0] random;

output score_flag, gameover;
output [399:0] field_display;

reg [399:0] field_background;
reg xpos, ypos;


block_pos();
block_expand;
field_merge(block_expand, field_background);

field_check(field_merge 0, field_background);

keyinput();
block_tmp;
field_display;
field_check;

field_check field_check_game()

endmodule // 