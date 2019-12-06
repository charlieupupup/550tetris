module index_block_field(clk, rotate_tmp,
    block_pos_x, block_pos_y,
    b_x, b_y,
    rotate,
    block_index, field_index
       
);

input clk;

output [3:0] block_index;
output [8:0] field_index;

input [1:0] b_x, b_y;
input [9:0] rotate;


input [4:0] block_pos_x, block_pos_y;

reg [3:0] block_index;
reg [8:0] field_index;

wire [3:0] rotate_tmp;
assign rotate_tmp = rotate % 4;
output [3:0] rotate_tmp;

initial begin
block_index = 0;
field_index = 0;
end


always @ (posedge clk) begin
    if (rotate_tmp== 0) begin
        field_index = (block_pos_y + b_y) * 20 + block_pos_x + b_x;
        block_index = b_y * 4 + b_x;
    end

    else if (rotate_tmp== 1) begin
    field_index = (block_pos_y + b_y) * 20 + block_pos_x + b_x;
        block_index = 12 + b_y - (b_x * 4); 
    end
    
    else if (rotate_tmp == 2) begin
    field_index = (block_pos_y + b_y) * 20 + block_pos_x + b_x;
        block_index = 15 - (b_y * 4) - b_x;
    end

    else if (rotate_tmp== 3) begin
    field_index = (block_pos_y + b_y) * 20 + block_pos_x + b_x;
        block_index = 3 - b_y + (b_x * 4);
    end

end

endmodule // index_block_field