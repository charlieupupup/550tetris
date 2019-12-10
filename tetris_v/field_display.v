module field_display(clk, err, score_plus, field_display_out, field_display_in);

input clk, err;

input [399:0] field_display_in;

output reg [9:0] score_plus;


output reg [399:0] field_display;



initial begin
field_display <= 399'd0; 
end



endmodule // field_displat