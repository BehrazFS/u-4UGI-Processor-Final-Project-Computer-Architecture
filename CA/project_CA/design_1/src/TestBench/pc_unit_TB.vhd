library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity pc_unit_tb is
end pc_unit_tb;

architecture TB_ARCHITECTURE of pc_unit_tb is
	-- Component declaration of the tested unit
	component pc_unit
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		branch : in STD_LOGIC;
		Ubranch : in Std_logic;
		offset : in STD_LOGIC_VECTOR(7 downto 0);
		PC : inout INTEGER range 0 to 511 );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC:='0';
	signal reset : STD_LOGIC;
	signal branch,Ubranch : STD_LOGIC:='0';
	signal offset : STD_LOGIC_VECTOR(7 downto 0);
	signal PC : INTEGER range 0 to 511;
	-- Observed signals - signals mapped to the output ports of tested entity

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : pc_unit
		port map (
			clk => clk,
			reset => reset,
			branch => branch,
			Ubranch =>Ubranch,
			offset => offset,
			PC => PC
		);
	 clk <= not clk after 2 ns;	
	 process
	 begin
		 reset <= '1';
		 wait for 2ns;
		 reset <= '0';
		 wait for 2ns;
		 Ubranch <= '1';
		 offset<= x"05";
		 wait;
	 end process;
	 
	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_pc_unit of pc_unit_tb is
	for TB_ARCHITECTURE
		for UUT : pc_unit
			use entity work.pc_unit(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_pc_unit;

