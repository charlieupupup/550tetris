module block_expand(block_out, block_matrix, block_pos_y, block_pos_x
    
);

output reg [399:0] block_out;



input [15:0] block_matrix;
input [8:0] block_pos_y, block_pos_x;

integer i;
always @(*) begin
    for(i = 0; i < 400; i = i + 1) begin
        if (i == block_pos_y * 9'd20 + 9'd0 * 9'd20 + block_pos_x + 9'd0) begin
        block_out[i] = block_matrix[0];
        end

        else if (i == block_pos_y * 9'd20 + 9'd0 * 9'd20 + block_pos_x + 9'd1) begin
        block_out[i] = block_matrix[1];
        end

        else if (i == block_pos_y * 9'd20 + 9'd0 * 9'd20 + block_pos_x + 9'd2) begin
        block_out[i] = block_matrix[2];
        end

        else if (i == block_pos_y * 9'd20 + 9'd0 * 9'd20 + block_pos_x + 9'd3) begin
        block_out[i] = block_matrix[3];
        end

        else if (i == block_pos_y * 9'd20 + 9'd1 * 9'd20 + block_pos_x + 9'd0) begin
        block_out[i] = block_matrix[4];
        end

        else if (i == block_pos_y * 9'd20 + 9'd1 * 9'd20 + block_pos_x + 9'd1) begin
        block_out[i] = block_matrix[5];
        end

        else if (i == block_pos_y * 9'd20 + 9'd1 * 9'd20 + block_pos_x + 9'd2) begin
        block_out[i] = block_matrix[6];
        end

        else if (i == block_pos_y * 9'd20 + 9'd1 * 9'd20 + block_pos_x + 9'd3) begin
        block_out[i] = block_matrix[7];
        end

        else if (i == block_pos_y * 9'd20 + 9'd2 * 9'd20 + block_pos_x + 9'd0) begin
        block_out[i] = block_matrix[8];
        end

        else if (i == block_pos_y * 9'd20 + 9'd2 * 9'd20 + block_pos_x + 9'd1) begin
        block_out[i] = block_matrix[9];
        end

        else if (i == block_pos_y * 9'd20 + 9'd2 * 9'd20 + block_pos_x + 9'd2) begin
        block_out[i] = block_matrix[10];
        end

        else if (i == block_pos_y * 9'd20 + 9'd2 * 9'd20 + block_pos_x + 9'd3) begin
        block_out[i] = block_matrix[11];
        end

        else if (i == block_pos_y * 9'd20 + 9'd3 * 9'd20 + block_pos_x + 9'd0) begin
        block_out[i] = block_matrix[12];
        end

        else if (i == block_pos_y * 9'd20 + 9'd3 * 9'd20 + block_pos_x + 9'd1) begin
        block_out[i] = block_matrix[13];
        end

        else if (i == block_pos_y * 9'd20 + 9'd3 * 9'd20 + block_pos_x + 9'd2) begin
        block_out[i] = block_matrix[14];
        end

        else if (i == block_pos_y * 9'd20 + 9'd3 * 9'd20 + block_pos_x + 9'd3) begin
        block_out[i] = block_matrix[15];
        end



        else begin
        block_out[i] = 1'd0;
        end



    end
end


endmodule // block_expand