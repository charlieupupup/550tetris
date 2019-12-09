module field_check(err, field_display, field_background, block_expand
    
);

output err;

input [399:0] field_display, field_background, block_expand;

wire [9:0] one_field_display, one_field_background, one_block_expand;
one_count one_count_0(one_field_display, field_display);
one_count one_count_1(one_field_background, field_background);
one_count one_count_2(one_block_expand, block_expand);

bound_check bound_check_0(err, one_field_display, one_field_background, one_block_expand);
endmodule // field_check