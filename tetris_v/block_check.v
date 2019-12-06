module block_check(b_x, b_y, block_index_tmp, field_index_tmp,
    block,
    field,
    block_pos_x,
    block_pos_y,
    rotate,
    block_check_result
);
input [1:0] b_x, b_y;
input [15:0] block;
input [399:0] field;
input [4:0] block_pos_x, block_pos_y;
input [9:0] rotate;

output block_check_result;

reg block_check_result;

input [3:0] block_index_tmp;
input [8:0] field_index_tmp;

reg [1:0] rotate_tmp = rotate % 4;



always @(*) begin
    


    if (block_pos_x + b_x < 20 && block_pos_y + b_y) begin
        if (block[block_index_tmp] != 0 && field[field_index_tmp] != 0) begin
            block_check_result = 1; 
        end


         else if (block_pos_x + b_x >= 20 || block_pos_y + b_y >=20) begin
            block_check_result = 1;
        end
        
    end 
    else begin
    block_check_result = 0;
    end    
end
endmodule // block_check    