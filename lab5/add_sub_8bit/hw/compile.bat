quartus_sh -t compile.tcl
pause
quartus_pgm --mode=JTAG -o P;output_files\add_sub_8bit.sof@2
pause