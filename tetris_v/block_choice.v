module block_choice(rotate_tmp,block_num,block_matrix);

input [9:0] block_num, rotate_tmp;
output [15:0] block_matrix;





reg [15:0] block_matrix;

reg[15:0] block_0_0 = 16'b0100010001000100;
reg[15:0] block_0_1 = 16'b0000111100000000;
reg[15:0] block_0_2 = 16'b0010001000100010;
reg[15:0] block_0_3 = 16'b0000000011110000;
reg[15:0] block_1_0 = 16'b0000011001100000;
reg[15:0] block_1_1 = 16'b0000011001100000;
reg[15:0] block_1_2 = 16'b0000011001100000;
reg[15:0] block_1_3 = 16'b0000011001100000;
reg[15:0] block_2_0 = 16'b0000110001100000;
reg[15:0] block_2_1 = 16'b0000110001100000;
reg[15:0] block_2_2 = 16'b0000110001100000;
reg[15:0] block_2_3 = 16'b0000110001100000;
reg[15:0] block_3_0 = 16'b0100110001000000;
reg[15:0] block_3_1 = 16'b0010011100000000;
reg[15:0] block_3_2 = 16'b0000001000110010;
reg[15:0] block_3_3 = 16'b0000000011100100;
reg[15:0] block_4_0 = 16'b1000100010001100;
reg[15:0] block_4_1 = 16'b1111100000000000;
reg[15:0] block_4_2 = 16'b0011000100010001;
reg[15:0] block_4_3 = 16'b0000000000011111;



always @ (*) begin

    if (block_num == 0&&rotate_tmp == 0) begin
    block_matrix = block_0_0;
    end

    else if (block_num == 0&&rotate_tmp == 1) begin
    block_matrix = block_0_1;
    end

    else if (block_num == 0&&rotate_tmp == 2) begin
    block_matrix = block_0_2;
    end

    else if (block_num == 0&&rotate_tmp == 3) begin
    block_matrix = block_0_3;
    end

    else if (block_num == 1&&rotate_tmp == 0) begin
    block_matrix = block_1_0;
    end

    else if (block_num == 1&&rotate_tmp == 1) begin
    block_matrix = block_1_1;
    end

    else if (block_num == 1&&rotate_tmp == 2) begin
    block_matrix = block_1_2;
    end

    else if (block_num == 1&&rotate_tmp == 3) begin
    block_matrix = block_1_3;
    end

    else if (block_num == 2&&rotate_tmp == 0) begin
    block_matrix = block_2_0;
    end

    else if (block_num == 2&&rotate_tmp == 1) begin
    block_matrix = block_2_1;
    end

    else if (block_num == 2&&rotate_tmp == 2) begin
    block_matrix = block_2_2;
    end

    else if (block_num == 2&&rotate_tmp == 3) begin
    block_matrix = block_2_3;
    end

    else if (block_num == 3&&rotate_tmp == 0) begin
    block_matrix = block_3_0;
    end

    else if (block_num == 3&&rotate_tmp == 1) begin
    block_matrix = block_3_1;
    end

    else if (block_num == 3&&rotate_tmp == 2) begin
    block_matrix = block_3_2;
    end

    else if (block_num == 3&&rotate_tmp == 3) begin
    block_matrix = block_3_3;
    end

    else if (block_num == 4&&rotate_tmp == 0) begin
    block_matrix = block_4_0;
    end

    else if (block_num == 4&&rotate_tmp == 1) begin
    block_matrix = block_4_1;
    end

    else if (block_num == 4&&rotate_tmp == 2) begin
    block_matrix = block_4_2;
    end

    else if (block_num == 4&&rotate_tmp == 3) begin
    block_matrix = block_4_3;
    end


    else begin
    block_matrix = block_0_0;
    end

end

endmodule // block_choice