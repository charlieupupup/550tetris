module field_merge(field_display, field_background, block_expand
    
);

input [399:0] block_expand;
input [399:0] field_background;



output reg [399:0] field_display;

integer i;
always @(*) begin
    for(i = 0; i < 400; i = i + 1) begin
    field_display[i] = block_expand[i] | field_background[i];
    end
end

endmodule // field_merge    