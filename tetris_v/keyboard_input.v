module keyboard_input(clk, block_pos_x_in, block_pos_y_in, rotate_in, left, right, down, ro,
block_pos_x_out, block_pos_y_out, rotate_out
    
);

input clk;

input [4:0] block_pos_x_in, block_pos_y_in;
input [9:0] rotate_in;

input left, right, down, ro;


output reg [4:0] block_pos_x_out, block_pos_y_out;
output reg [9:0] rotate_out;

initial begin
block_pos_x_out = block_pos_x_in;
block_pos_y_out = block_pos_y_in;
rotate_out = rotate_in;
end

always @ (posedge clk)

if (left == 1) begin
    block_pos_x_out <= block_pos_x_in - 1;
end

else if (right == 1) begin
block_pos_x_out <= block_pos_x_in + 1;
end

else if(down == 1) begin
block_pos_y_out <= block_pos_y_in + 1;
end

else if (ro == 1) begin
rotate_out <= rotate_in + 1;
end



endmodule // input  