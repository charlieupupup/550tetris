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

init(rst, field_background, field_init);

rowdown(field_background, field_background2);

rowfull(field_background, field_background3, score_flag);
blockcheck(block, screen, xpos, ypos, rotate)

block_rotate(x, y, r);

field_merge(field_background, blockb, xpos, ypos, rotate);

field_refresh(field_background, field_display);

block_rotate(x, y, rotate);


block_choice(random, block);




endmodule // 