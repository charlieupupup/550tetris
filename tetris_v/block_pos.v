module block_pos(clk, err, block_pos_refresh, block_pos_y_out,block_pos_x_out, rotate_out, block_pos_x_in, block_pos_y_in, rotate_in);


output reg [9:0] block_pos_y_out, block_pos_x_out, rotate_out;
input clk, err, refresh;
input [9:0] block_pos_y_in, block_pos_x_in, rotate_in;



initial begin
    block_pos_y_out = 9'd0;
    block_pos_x_out = 9'd9;
    rotate = 9'd0;
end

always @ (posedge clk) begin
    if(err) begin
        block_pos_y_out = 9'd0;
        block_pos_x_out = 9'd9;
        rotate = 9'd0;
    end
    else if (refresh) begin     
        block_pos_y_out = block_pos_y_in;
        block_pos_x_out = block_pos_x_in;
        rotate_out = rotate_in;s
    end
    
end

endmodule // block_pos