vlib work
vcom -2008 -work work "../rtl/common_verif_pack.vhd"
vcom -2008 -work work "../rtl/data_injector.vhd"
vcom -2008 -work work "../rtl/data_dumper.vhd"
vcom -2008 -work work "../rtl/HIGHT_KeySchedule.vhd"
vcom -2008 -work work "../rtl/HIGHT_InitialTransformation.vhd"
vcom -2008 -work work "../rtl/HIGHT_RoundFunction.vhd"
vcom -2008 -work work "../rtl/HIGHT_FinalTransformation.vhd"
vcom -2008 -work work "../rtl/HIGHT_comps.vhd"
vcom -2008 -work work "../rtl/HIGHT_Encryption.vhd"
vcom -2008 -work work "../rtl/HIGHT_General_tb.vhd"
vsim -t 1ps -L work -voptargs="+acc" HIGHT_General_tb
do wave.do
run 2us