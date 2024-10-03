SetActiveLib -work
comp -include "$dsn\src\ALU.vhd" 
comp -include "$dsn\src\TestBench\alu_TB.vhd" 
asim +access +r TESTBENCH_FOR_alu 
wave 
wave -noreg clk
wave -noreg A
wave -noreg B
wave -noreg OpCode
wave -noreg Result
wave -noreg Carry
wave -noreg Zero
wave -noreg Sign
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\alu_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_alu 
