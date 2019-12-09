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


always @ (posedge clk) begin
    if(en) begin
        if ((block_pos_x + 0 < 20) && (block_pos_y + 0 < 20)) begin
        field_display[block_pos_y * 20 + 0 + block_pos_x + 0] <= block_matrix[0];
        end

        if ((block_pos_x + 1 < 20) && (block_pos_y + 0 < 20)) begin
        field_display[block_pos_y * 20 + 0 + block_pos_x + 1] <= block_matrix[1];
        end

        if ((block_pos_x + 2 < 20) && (block_pos_y + 0 < 20)) begin
        field_display[block_pos_y * 20 + 0 + block_pos_x + 2] <= block_matrix[2];
        end

        if ((block_pos_x + 3 < 20) && (block_pos_y + 0 < 20)) begin
        field_display[block_pos_y * 20 + 0 + block_pos_x + 3] <= block_matrix[3];
        end

        if ((block_pos_x + 0 < 20) && (block_pos_y + 1 < 20)) begin
        field_display[block_pos_y * 20 + 20 + block_pos_x + 0] <= block_matrix[4];
        end

        if ((block_pos_x + 1 < 20) && (block_pos_y + 1 < 20)) begin
        field_display[block_pos_y * 20 + 20 + block_pos_x + 1] <= block_matrix[5];
        end

        if ((block_pos_x + 2 < 20) && (block_pos_y + 1 < 20)) begin
        field_display[block_pos_y * 20 + 20 + block_pos_x + 2] <= block_matrix[6];
        end

        if ((block_pos_x + 3 < 20) && (block_pos_y + 1 < 20)) begin
        field_display[block_pos_y * 20 + 20 + block_pos_x + 3] <= block_matrix[7];
        end

        if ((block_pos_x + 0 < 20) && (block_pos_y + 2 < 20)) begin
        field_display[block_pos_y * 20 + 40 + block_pos_x + 0] <= block_matrix[8];
        end

        if ((block_pos_x + 1 < 20) && (block_pos_y + 2 < 20)) begin
        field_display[block_pos_y * 20 + 40 + block_pos_x + 1] <= block_matrix[9];
        end

        if ((block_pos_x + 2 < 20) && (block_pos_y + 2 < 20)) begin
        field_display[block_pos_y * 20 + 40 + block_pos_x + 2] <= block_matrix[10];
        end

        if ((block_pos_x + 3 < 20) && (block_pos_y + 2 < 20)) begin
        field_display[block_pos_y * 20 + 40 + block_pos_x + 3] <= block_matrix[11];
        end

        if ((block_pos_x + 0 < 20) && (block_pos_y + 3 < 20)) begin
        field_display[block_pos_y * 20 + 60 + block_pos_x + 0] <= block_matrix[12];
        end

        if ((block_pos_x + 1 < 20) && (block_pos_y + 3 < 20)) begin
        field_display[block_pos_y * 20 + 60 + block_pos_x + 1] <= block_matrix[13];
        end

        if ((block_pos_x + 2 < 20) && (block_pos_y + 3 < 20)) begin
        field_display[block_pos_y * 20 + 60 + block_pos_x + 2] <= block_matrix[14];
        end

        if ((block_pos_x + 3 < 20) && (block_pos_y + 3 < 20)) begin
        field_display[block_pos_y * 20 + 60 + block_pos_x + 3] <= block_matrix[15];
        end




    end
end
endmodule // field_displat