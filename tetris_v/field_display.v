module field_display(clk, err, row_down, score_plus, field_display_out, field_display_in);

input clk, err;

input [399:0] field_display_in;

output reg row_down;
output reg [9:0] score_plus;


output reg [399:0] field_display_out;



initial begin
field_display_out <= 399'd0; 
end

always @(posedge clk) begin
    if(err == 0) begin
       field_display_out <= field_display_in; 
    end
end     


endmodule // field_displat