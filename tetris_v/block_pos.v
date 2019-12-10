module block_pos(clk, err, block_pos_y_out,block_pos_x_out, rotate_out, block_pos_x_in, block_pos_y_in, rotate_in);


output reg [9:0] block_pos_y_out, block_pos_x_out, rotate_out;
input clk, err;
input [9:0] block_pos_y_in, block_pos_x_in, rotate_in;



initial begin
    block_pos_y_out <= 9'd0;
    block_pos_x_out <= 9'd9;
    rotate_out <= 9'd0;
end

always @ (posedge clk) begin
    if(err) begin
        block_pos_y_out <= 9'd0;
        block_pos_x_out <= 9'd9;
        rotate_out <= 9'd0;
    end
    else  begin     
        block_pos_y_out <= block_pos_y_in;
        block_pos_x_out <= block_pos_x_in;
        rotate_out <= rotate_in;
    end
    
end

endmodule // block_pos