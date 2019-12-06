module index_block_field(
    block_pos_x, block_pos_y,
    b_x, b_y,
    rotate,
    block_index, field_index
       
);



output reg [4:0] block_index;
output reg [8:0] field_index;

input [4:0] b_x, b_y;
input [9:0] rotate;


input [4:0] block_pos_x, block_pos_y;

wire [9:0] rotate_tmp;
assign rotate_tmp = rotate % 10'd4;
//output [3:0] rotate_tmp;



always @ (rotate_tmp or block_pos_y or block_pos_x or b_y or b_x) begin
    if (rotate_tmp== 0) begin
        field_index = (block_pos_y + b_y) * 5'd20 + block_pos_x + b_x;
        block_index = b_y * 5'd4 + b_x;
    end

    else if (rotate_tmp== 1) begin
		  field_index = (block_pos_y + b_y) * 5'd20 + block_pos_x + b_x;
        block_index = 5'd12 + b_y - (b_x * 5'd4); 
    end
    
    else if (rotate_tmp == 2) begin
        field_index = (block_pos_y + b_y) * 5'd20 + block_pos_x + b_x;
        block_index = 5'd15 - (b_y * 5'd4) - b_x;
    end

    else begin
        field_index = (block_pos_y + b_y) * 5'd20 + block_pos_x + b_x;
        block_index = 5'd3 - b_y + (b_x * 5'd4);
    end

end

endmodule // index_block_field