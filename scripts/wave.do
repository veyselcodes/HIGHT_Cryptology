onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hight_general_tb/UUT/i_HIGHT_FinalTransformation/i_HIGHT_FinalTransformation_clk
add wave -noupdate /hight_general_tb/UUT/i_HIGHT_RoundFunction/state
add wave -noupdate /hight_general_tb/UUT/o_HIGHT_Encryption_CipherKey
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4724284 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 242
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {8195187 ps}
