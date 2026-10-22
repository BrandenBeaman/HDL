vlib work
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/synchronizer_8bit.vhd
vcom -93 -work work ../../src/add_sub_8bit.vhd
vcom -93 -work work ../../src/state_machine.vhd
vcom -93 -work work ../../src/double_dabble.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/top.vhd
vcom -93 -work work ../src/add_sub_8bit_tb.vhd
vsim -voptargs=+acc add_sub_8bit_tb
do wave.do
run 5000 ns
