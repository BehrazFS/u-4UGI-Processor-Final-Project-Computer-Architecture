SetActiveLib -work
comp -include "$dsn\src\Instruction_Memory_Unit.vhd" 
comp -include "$dsn\src\TestBench\instruction_memory_unit_TB.vhd" 
asim +access +r TESTBENCH_FOR_instruction_memory_unit 
wave 
wave -noreg clk
wave -noreg MemRead
wave -noreg MemWrite
wave -noreg Address
wave -noreg DataIn
wave -noreg DataOut
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\instruction_memory_unit_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_instruction_memory_unit 
