onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /generic_counter_tb/uut1/clk_50mhz
add wave -noupdate /generic_counter_tb/uut1/reset
add wave -noupdate /generic_counter_tb/uut1/seven_seg_out
add wave -noupdate /generic_counter_tb/uut1/enable
add wave -noupdate /generic_counter_tb/uut1/sum_sig
add wave -noupdate /generic_counter_tb/uut1/reg_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {72 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {525 ns}
