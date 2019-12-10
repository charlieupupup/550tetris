module block_choice(rotate,block_num,block_matrix);

input [9:0] block_num, rotate;
output [15:0] block_matrix;

reg [9:0] rotate_tmp;
assign rotate_tmp = rotate % 4;



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



always @ (*)
case (block_num)
    0: case (rotate_tmp)
        0:    block_matrix = block_0_0
        1:    block_matrix = block_0_1
        2:    block_matrix = block_0_2
        3:    block_matrix = block_0_3
    endcase

    1: case (rotate_tmp)
        0:    block_matrix = block_1_0
        1:    block_matrix = block_1_1
        2:    block_matrix = block_1_2
        3:    block_matrix = block_1_3
    endcase

    2: case (rotate_tmp)
        0:    block_matrix = block_2_0
        1:    block_matrix = block_2_1
        2:    block_matrix = block_2_2
        3:    block_matrix = block_2_3
    endcase

    3: case (rotate_tmp)
        0:    block_matrix = block_3_0
        1:    block_matrix = block_3_1
        2:    block_matrix = block_3_2
        3:    block_matrix = block_3_3
    endcase

    4: case (rotate_tmp)
        0:    block_matrix = block_4_0
        1:    block_matrix = block_4_1
        2:    block_matrix = block_4_2
        3:    block_matrix = block_4_3
    endcase

    default: block_matrix = block_0_0;
endcase
endmodule // block_choice