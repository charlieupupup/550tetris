module block_check(b_x, b_y, block_pos_x, block_pos_y,
    block_matrix,
    block_index,
    field_matrix,
    field_index,
    block_check_result
);

input [4:0] b_x, b_y, block_pos_x, block_pos_y;

input [15:0] block_matrix;
input [3:0] block_index;

input [399:0] field_matrix;
input [8:0] field_index;

output reg block_check_result;


always @(*) begin
    
    if ((block_pos_x + b_x < 5'd20) && (block_pos_y + b_y < 5'd20)) begin
        if ((block_matrix[block_index] == 1'd1) && (field_matrix[field_index] == 1'd1)) begin
            block_check_result = 1'd1; 
        end
		else begin
            block_check_result = 1'd0;
		end
    end


    else begin
        if (block_matrix[block_index] == 1'd1) begin
            block_check_result = 1'd1;
        end

        else begin
            block_check_result = 1'd0;
        end      
    end
        
    
end
endmodule // block_check    