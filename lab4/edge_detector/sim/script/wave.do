onerror {resume}
radix define States {
    "11'b0001" "WAIT" -color "orange",
    "11'b0010" "ATTACK" -color "red",
    "11'b0100" "HEAL" -color "blue",
    "11'b1000" "FLEA" -color "yellow",
    -default hexadecimal
    -defaultcolor white
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /edge_detector_tb/uut/clk
add wave -noupdate /edge_detector_tb/uut/reset
add wave -noupdate /edge_detector_tb/uut/input
add wave -noupdate /edge_detector_tb/uut/prev_input
add wave -noupdate /edge_detector_tb/uut/edge
add wave -noupdate -expand -group uut /edge_detector_tb/uut/clk
add wave -noupdate -expand -group uut /edge_detector_tb/uut/reset
add wave -noupdate -expand -group uut /edge_detector_tb/uut/input
add wave -noupdate -expand -group uut /edge_detector_tb/uut/edge
add wave -noupdate -expand -group uut /edge_detector_tb/uut/prev_input
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {43 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 163
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {210 ns}
