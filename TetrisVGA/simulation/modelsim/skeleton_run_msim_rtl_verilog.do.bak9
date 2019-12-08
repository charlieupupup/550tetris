transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+H:/Altera_lite/Github/550tetris/TetrisVGA {H:/Altera_lite/Github/550tetris/TetrisVGA/dffe_ref.v}
vlog -vlog01compat -work work +incdir+H:/Altera_lite/Github/550tetris/TetrisVGA {H:/Altera_lite/Github/550tetris/TetrisVGA/lfsr.v}
vlog -vlog01compat -work work +incdir+H:/Altera_lite/Github/550tetris/TetrisVGA {H:/Altera_lite/Github/550tetris/TetrisVGA/mux2In.v}

vlog -vlog01compat -work work +incdir+H:/Altera_lite/Github/550tetris/TetrisVGA {H:/Altera_lite/Github/550tetris/TetrisVGA/lfsr_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  lfsr_tb

add wave *
view structure
view signals
run -all
