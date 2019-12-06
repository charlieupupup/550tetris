module row_check(
    clk,
    matrix_in,
    matrix_out,
    score_plus
);

input clk;

input [399:0] matrix_in;
output [399:0] matrix_out;
output [3:0] score_plus;

reg [399:0] matrix_process;
reg score_plus;
reg full;

always @(posedge clk) begin
    score_plus = 0;
    matrix_process = matrix_in;
end



integer y;

/*for (y = 19; y > -1 ; y = y - 1) begin
    full =  1;
    for (x = 19; x > -1; x = x - 1) begin
        full = matrix_process[y * 20 + x] * full;
        
    end
    if (full == 1) begin
        score_plus = score_plus + 1;
        for (i = y; i > 0; i = i - 1) begin
            for (j = 0; j < 20; j = j + 1) begin
                matrix_process[j * 20 + i] = matrix_process[(y - 1) * 20 + x];
            end
            
        end
    end
    
end*/

assign matrix_out = matrix_process;

endmodule
