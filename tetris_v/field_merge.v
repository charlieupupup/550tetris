module field_merge(
    rotate,
    block_pos_x,
    block_pos_y,
    block_matrix,
    field_background,
    field_display
);
input [9:0] rotate;

input [4:0] block_pos_x, block_pos_y;
input [15:0] block_matrix;

input [399:0] field_background;
output [399:0] field_display;

always @() begin
for (b_x = 0; b_x < 4; b_x = b_x + 1) begin
    for (b_y = 0; b_y < 4; b_y = b_y + 1) begin
    reg [9:0] rotate_tmp;
    rotate_tmp = rotate % 4;
    reg [5:0] block_index_tmp;
    if (rotate_tmp == 0) begin
        block_index_tmp = b_y * 4 + b_x;
    end 
    if (rotate_tmp == 1) begin
        block_index_tmp = 12 + b_y - (b_x * 4); 
    end
    if (rotate_tmp == 2) begin
        block_index_tmp = 15 - (b_y * 4) - b_x;
    end
    if (rotate_tmp == 3) begin
        block_index_tmp = 3 - b_y + (b_x * 4);
    end

    reg [9:0] field_index_tmp;
    field_index_tmp = (block_pos_y + b_y) * 20 + block_pos_x + b_x;

    if (block_pos_x + b_x < 22 && block_pos_y + b_y < 20 && field_backgound[field_index_tmp == 0]) begin
    field_display[field_index_tmp] = block_matrix[block_index_tmp];  
    end
    
    end
end     
    
end

endmodule // field_merge