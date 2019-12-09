module block_choice(rotate,block_num,block_matrix);

input [9:0] block_num, rotate;
output [15:0] block_matrix;

reg [9:0] rotate_tmp;
assign rotate_tmp = rotate % 4;


reg [15:0] block_0 = 16'b0010001000100010;
reg [15:0] block_1 = 16'b0000011001100000;
reg [15:0] block_2 = 16'b0000110001100000;
reg [15:0] block_3 = 16'b0100110001000000;
reg [15:0] block_4 = 16'b1000100010001100;
reg [15:0] block_matrix;

always @ (*)
case (block_num)
    0: block_matrix = block_0;
    1: block_matrix = block_1;
    2: block_matrix = block_2;
    3: block_matrix = block_3;
    4: block_matrix = block_4;
    default: block_matrix = block_0;
endcase
endmodule // block_choice