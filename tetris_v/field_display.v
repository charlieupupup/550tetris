module field_display(clk, en, field_display, 
block_pos_x, block_pos_y, block_matrix, rotate
  
);

input clk, en;


output reg [399:0] field_display;
input [4:0] block_pos_x, block_pos_y;
input [15:0] block_matrix;
input [9:0] rotate;

wire [9:0] rotate_mod = rotate % 4;



initial begin
field_display <= 0; 
end



endmodule // field_displat