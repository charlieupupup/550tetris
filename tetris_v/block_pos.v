module block_pos(
    clk, err,
    drop,
    left,
    right, ro,
    block_pos_y_out,
    block_pos_x_out
    
);

input clk, drop, left, right, ro;


output reg [9:0] block_pos_x_out, block_pos_y_out, rotate;


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
    else begin
        if (drop == 1) begin
        block_pos_y_out <= block_pos_y_out + 1;
        end

        else if (left == 1) begin
        block_pos_x_out <= block_pos_x_out - 1;   
        end

        else if (right == 1) begin
        block_pos_x_out <= block_pos_x_out + 1;   
        end

        else if (ro == 1) begin
        rotate = rotate + 9'd1;
        end

    end
    
end

endmodule // block_pos