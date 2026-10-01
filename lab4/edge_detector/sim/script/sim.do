vlib work
vcom -93 -work work ../../src/edge_detector.vhd
vcom -93 -work work ../src/edge_detector_tb.vhd
vsim -voptargs=+acc edge_detector_tb
do wave.do
run 400 ns
