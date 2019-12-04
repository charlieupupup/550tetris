module field_background(
    reset,
    block_check_result,
    field_in,
    field_out
);

    input reset, block_check_result;
    input [399:0] field_in;
    output [399:0] field_out;

    reg [399:0] field_out;

    always @(posedge reset) begin
        field_out = 399'd0;
    end

    always @ () begin
    if (block_check_result == 0) begin
        
        field_out[399:0] = field_in[399:0];
    end
    end

endmodule