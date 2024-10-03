SetActiveLib -work
comp -include "$dsn\src\PC_Unit.vhd" 
comp -include "$dsn\src\TestBench\pc_unit_TB.vhd" 
asim +access +r TESTBENCH_FOR_pc_unit 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg branch
wave -noreg offset
wave -noreg PC
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\pc_unit_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_pc_unit 
