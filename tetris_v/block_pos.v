module block_pos(
    clk,
    drop,
    left,
    right,
    block_pos_x_in,
    block_pos_y_in,
    block_pos_x_out,
    block_pos_y_out
    
);

input clk, drop, left, right;
input [4:0] block_pos_x_in, block_pos_y_in;

output [4:0] block_pos_x_out, block_pos_y_out;
reg [4:0] block_pos_x_out, block_pos_y_out;

initial begin
    block_pos_x_out = 5;
    block_pos_y_out = 0;
end

always @ (posedge clk)  
    if (drop == 1) begin
    block_pos_y_out = block_pos_y_in + 1;
        
    end

    else if (left == 1) begin
    block_pos_x_out = block_pos_x_in - 1;   
    end

    else if (right == 1) begin
    block_pos_x_out = block_pos_x_in + 1;   
    end


endmodule // block_pos