module bound_check(err, one_field_display, one_field_backgrond, one_block_expand
    
);

input [9:0] one_field_display, one_field_backgrond, one_block_expand
output reg err;
always @(*) begin   
    if(one_field_display != one_field_backgrond + one_block_expand) begin
        err = 1'd1;
    end 
    else begin
        err = 1'd0;
    end
    
end
endmodule // bound_check