module field_display(clk, err, row_down, score_plus, field_display_out, field_display_in);

input clk, err;

input [399:0] field_display_in;

output reg row_down;
output reg [9:0] score_plus;


output reg [399:0] field_display_out;

reg [9:0] total_line_num;

genvar gv_i;
generate for(gv_i = 0; gv_i < 20; gv_i = gv_i + 1)
    begin: line_check
        assign line[gv_i] = & matrix_in[(20 * gv_i) : (20 * gv_i + 19)];
    end
endgenerate

assign is_any_line_full = |line[19:0]; //is_any_line_full is 1'd1 when at lease one line is full

initial begin
field_display_out <= field_display_in;
end

always @(posedge clk) begin
    if(err == 0) begin
     if(is_any_line_full) begin
        if(line[0]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[39:20]  ;
            field_display_out[59:40]    <= field_display_out[59:40]  ;
            field_display_out[79:60]    <= field_display_out[79:60]  ;
            field_display_out[99:80]    <= field_display_out[99:80]  ;
            field_display_out[119:100]  <= field_display_out[119:100];
            field_display_out[139:120]  <= field_display_out[139:120];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[1]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[59:40]  ;
            field_display_out[79:60]    <= field_display_out[79:60]  ;
            field_display_out[99:80]    <= field_display_out[99:80]  ;
            field_display_out[119:100]  <= field_display_out[119:100];
            field_display_out[139:120]  <= field_display_out[139:120];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[2]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[79:60]  ;
            field_display_out[99:80]    <= field_display_out[99:80]  ;
            field_display_out[119:100]  <= field_display_out[119:100];
            field_display_out[139:120]  <= field_display_out[139:120];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[3]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[99:80]  ;
            field_display_out[119:100]  <= field_display_out[119:100];
            field_display_out[139:120]  <= field_display_out[139:120];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[4]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[119:100];
            field_display_out[139:120]  <= field_display_out[139:120];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[5]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[139:120];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[6]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[159:140];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[7]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[179:160];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[8]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[199:180];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[9]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[219:200];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[10]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[239:220];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[11]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[259:240];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[12]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[279:260];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[13]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[299:280];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[14]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[279:260];
            field_display_out[319:300]  <= field_display_out[319:300];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[15]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[279:260];
            field_display_out[319:300]  <= field_display_out[299:280];
            field_display_out[339:320]  <= field_display_out[339:320];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[16]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[279:260];
            field_display_out[319:300]  <= field_display_out[299:280];
            field_display_out[339:320]  <= field_display_out[319:300];
            field_display_out[359:340]  <= field_display_out[359:340];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[17]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[279:260];
            field_display_out[319:300]  <= field_display_out[299:280];
            field_display_out[339:320]  <= field_display_out[319:300];
            field_display_out[359:340]  <= field_display_out[339:320];
            field_display_out[379:360]  <= field_display_out[379:360];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[18]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[279:260];
            field_display_out[319:300]  <= field_display_out[299:280];
            field_display_out[339:320]  <= field_display_out[319:300];
            field_display_out[359:340]  <= field_display_out[339:320];
            field_display_out[379:360]  <= field_display_out[359:340];
            field_display_out[399:380]  <= field_display_out[399:380];

            total_line_num <= total_line_num + 1; //full line recorder
        end

        if(line[19]) begin
            field_display_out[19:0]     <= 20'd0;
            field_display_out[39:20]    <= field_display_out[19:0]   ;
            field_display_out[59:40]    <= field_display_out[39:20]  ;
            field_display_out[79:60]    <= field_display_out[59:40]  ;
            field_display_out[99:80]    <= field_display_out[79:60]  ;
            field_display_out[119:100]  <= field_display_out[99:80]  ;
            field_display_out[139:120]  <= field_display_out[119:100];
            field_display_out[159:140]  <= field_display_out[139:120];
            field_display_out[179:160]  <= field_display_out[159:140];
            field_display_out[199:180]  <= field_display_out[179:160];
            field_display_out[219:200]  <= field_display_out[199:180];
            field_display_out[239:220]  <= field_display_out[219:200];
            field_display_out[259:240]  <= field_display_out[239:220];
            field_display_out[279:260]  <= field_display_out[259:240];
            field_display_out[299:280]  <= field_display_out[279:260];
            field_display_out[319:300]  <= field_display_out[299:280];
            field_display_out[339:320]  <= field_display_out[319:300];
            field_display_out[359:340]  <= field_display_out[339:320];
            field_display_out[379:360]  <= field_display_out[359:340];
            field_display_out[399:380]  <= field_display_out[379:360];

            total_line_num <= total_line_num + 1; //full line recorder
        end
        else begin
          field_display_out <= field_display_in;
        end
    end
end

assign score_plus = total_line_num;
assign row_down = is_any_line_full; //If at least one line is full, then row_down = 1.

endmodule // field_displat
