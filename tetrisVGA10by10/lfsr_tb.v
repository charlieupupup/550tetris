// ---------- SAMPLE TEST BENCH ----------
`timescale 1 ns / 100 ps
module lfsr_tb();
    // inputs 
    reg clock;
	 reg [7:0] seed;
    // outputs 
    wire [2:0] q;
	 
	 integer i;

    // instantiate LFSR
    lfsr my_lfsr(clock, seed, q);

    // setting the initial values of all the reg
    initial
    begin
        $display($time, " << Starting the Simulation >>");
        clock = 1'b0;    // at time 0
		  seed = 8'b10101100;
		  i = 0;
    end
	 
	 always @(posedge clock) begin
		i = i + 1;
		$display("q = %d", q);
		if (i > 40) $stop;
	 end


    // Clock generator
    always
         #10     clock = ~clock;    // toggle

endmodule
