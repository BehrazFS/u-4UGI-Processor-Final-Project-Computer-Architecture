library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity instruction_memory_unit_tb is
	-- Generic declarations of the tested unit
		generic(
		AddrWidth : INTEGER := 9;
		DataWidth : INTEGER := 16 );
end instruction_memory_unit_tb;

architecture TB_ARCHITECTURE of instruction_memory_unit_tb is
	-- Component declaration of the tested unit
	component instruction_memory_unit
		generic(
		AddrWidth : INTEGER := 9;
		DataWidth : INTEGER := 16 );
	port(
		clk : in STD_LOGIC;
		MemRead : in STD_LOGIC;
		MemWrite : in STD_LOGIC;
		Address : in INTEGER range 2**AddrWidth-1 downto 0;
		DataIn : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
		DataOut : out STD_LOGIC_VECTOR(DataWidth-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC:='0';
	signal MemRead : STD_LOGIC;
	signal MemWrite : STD_LOGIC;
	signal Address : INTEGER range 2**AddrWidth-1 downto 0;
	signal DataIn : STD_LOGIC_VECTOR(DataWidth-1 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal DataOut : STD_LOGIC_VECTOR(DataWidth-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : instruction_memory_unit
		generic map (
			AddrWidth => AddrWidth,
			DataWidth => DataWidth
		)

		port map (
			clk => clk,
			MemRead => MemRead,
			MemWrite => MemWrite,
			Address => Address,
			DataIn => DataIn,
			DataOut => DataOut
		);

	-- Add your stimulus here ...
	 clk <= not clk after 2 ns;	
	 process
	 begin
		 memread <= '1';
		 memwrite <= '0';
		 address <= 0;
		 datain <= "0000111100001100";
		 wait for 2ns;
		 memread <= '0';
		 memwrite <= '1';
		 address <= 2;
		 datain <= "0000111100001100";
		 wait;
	 end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_instruction_memory_unit of instruction_memory_unit_tb is
	for TB_ARCHITECTURE
		for UUT : instruction_memory_unit
			use entity work.instruction_memory_unit(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_instruction_memory_unit;

