module one_count(one_output, field_in
    
);


input  [399:0] field_in;
output reg [9:0] one_output;



integer i;
always @(*) begin
    one_output = 10'd0;
    for(i = 0; i < 400; i = i + 1) begin
    
    one_output = one_output + field_in[i];
    
    end
    
end
endmodule // bound_check    