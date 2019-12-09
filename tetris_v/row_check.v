module row_check(
   input      [399:0]  matrix_in,
   output reg [399:0]  matrix_out,
   output reg [3:0]    score_plus
);

wire line[19:0]; //indicating whether each line is full
wire is_any_line_full; //indicating whether any line is full

genvar gv_i;
generate for(gv_i = 0; gv_i < 20; gv_i = gv_i + 1)
    begin: line_check
        assign line[gv_i] = & matrix_in[(20 * gv_i) : (20 * gv_i + 19)];
    end
endgenerate

assign is_any_line_full = |line[19:0];

always@ (posedge clk or negedge rst_n) begin
    if( !rst_n ) begin
        field[19:0] <= 20'd0;
        field[39:20] <= 20'd0;
        field[59:40] <= 20'd0;
        field[79:60] <= 20'd0;
        field[99:80] <= 20'd0;
        field[119:100] <= 20'd0;
        field[139:120] <= 20'd0;
        field[159:140] <= 20'd0;
        field[179:160] <= 20'd0;
        field[199:180] <= 20'd0;
        field[219:200] <= 20'd0;
        field[239:220] <= 20'd0;
        field[259:240] <= 20'd0;
        field[279:260] <= 20'd0;
        field[299:280] <= 20'd0;
        field[319:300] <= 20'd0;
        field[339:320] <= 20'd0;
        field[359:340] <= 20'd0;
        field[379:360] <= 20'd0;
        field[399:380] <= 20'd0;

        total_line_num <= 0; //full line recorder
    end
    
    else if(is_any_line_full) begin
        if(line[0]) begin
            field[19:0]     <= 20'd0;
            field[39:20]    <= field[39:20]  ;
            field[59:40]    <= field[59:40]  ;
            field[79:60]    <= field[79:60]  ;
            field[99:80]    <= field[99:80]  ;
            field[119:100]  <= field[119:100];
            field[139:120]  <= field[139:120];
            field[159:140]  <= field[159:140];
            field[179:160]  <= field[179:160];
            field[199:180]  <= field[199:180];
            field[219:200]  <= field[219:200];
            field[239:220]  <= field[239:220];
            field[259:240]  <= field[259:240];
            field[279:260]  <= field[279:260];
            field[299:280]  <= field[299:280];
            field[319:300]  <= field[319:300];
            field[339:320]  <= field[339:320];
            field[359:340]  <= field[359:340];
            field[379:360]  <= field[379:360];
            field[399:380]  <= field[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[1]) begin
            field[19:0]     <= 20'd0;
            field[39:20]    <= field[19:0]   ;
            field[59:40]    <= field[59:40]  ;
            field[79:60]    <= field[79:60]  ;
            field[99:80]    <= field[99:80]  ;
            field[119:100]  <= field[119:100];
            field[139:120]  <= field[139:120];
            field[159:140]  <= field[159:140];
            field[179:160]  <= field[179:160];
            field[199:180]  <= field[199:180];
            field[219:200]  <= field[219:200];
            field[239:220]  <= field[239:220];
            field[259:240]  <= field[259:240];
            field[279:260]  <= field[279:260];
            field[299:280]  <= field[299:280];
            field[319:300]  <= field[319:300];
            field[339:320]  <= field[339:320];
            field[359:340]  <= field[359:340];
            field[379:360]  <= field[379:360];
            field[399:380]  <= field[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[2]) begin
            field[19:0]     <= 20'd0;
            field[39:20]    <= field[19:0]   ;
            field[59:40]    <= field[39:20]  ;
            field[79:60]    <= field[79:60]  ;
            field[99:80]    <= field[99:80]  ;
            field[119:100]  <= field[119:100];
            field[139:120]  <= field[139:120];
            field[159:140]  <= field[159:140];
            field[179:160]  <= field[179:160];
            field[199:180]  <= field[199:180];
            field[219:200]  <= field[219:200];
            field[239:220]  <= field[239:220];
            field[259:240]  <= field[259:240];
            field[279:260]  <= field[279:260];
            field[299:280]  <= field[299:280];
            field[319:300]  <= field[319:300];
            field[339:320]  <= field[339:320];
            field[359:340]  <= field[359:340];
            field[379:360]  <= field[379:360];
            field[399:380]  <= field[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[2]) begin
            field[19:0]     <= 20'd0;
            field[39:20]    <= field[19:0]   ;
            field[59:40]    <= field[39:20]  ;
            field[79:60]    <= field[79:60]  ;
            field[99:80]    <= field[99:80]  ;
            field[119:100]  <= field[119:100];
            field[139:120]  <= field[139:120];
            field[159:140]  <= field[159:140];
            field[179:160]  <= field[179:160];
            field[199:180]  <= field[199:180];
            field[219:200]  <= field[219:200];
            field[239:220]  <= field[239:220];
            field[259:240]  <= field[259:240];
            field[279:260]  <= field[279:260];
            field[299:280]  <= field[299:280];
            field[319:300]  <= field[319:300];
            field[339:320]  <= field[339:320];
            field[359:340]  <= field[359:340];
            field[379:360]  <= field[379:360];
            field[399:380]  <= field[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end
        
    
end






/*
reg full; // a flag indicating whether a row is full

always @() begin
    score_plus = 0;
    matrix_process = matrix_in;
end



integer y;
*/

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
