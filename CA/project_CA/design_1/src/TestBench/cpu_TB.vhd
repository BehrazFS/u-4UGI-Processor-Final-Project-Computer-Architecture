library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity cpu_tb is
end cpu_tb;

architecture TB_ARCHITECTURE of cpu_tb is
	-- Component declaration of the tested unit
	component cpu
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		IMR : in STD_LOGIC;
		IMW : in STD_LOGIC;
		INST : in STD_LOGIC_VECTOR(15 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC:='0';
	signal reset : STD_LOGIC;
	signal IMR : STD_LOGIC;
	signal IMW : STD_LOGIC;
	signal INST : STD_LOGIC_VECTOR(15 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : cpu
		port map (
			clk => clk,
			reset => reset,
			IMR => IMR,
			IMW => IMW,
			INST => INST
		);

	-- Add your stimulus here ...
	clk <= not clk after 4ns;
	process
	begin  
		reset <= '1';
		IMR <= '1';
		IMW <= '0';
		INST <= "0000000000000000";
		wait for 2ns;
		reset <= '0';
		IMR <= '1';
		IMW <= '0';
		INST <= "0000000000000000";
		wait;
	end process;
	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_cpu of cpu_tb is
	for TB_ARCHITECTURE
		for UUT : cpu
			use entity work.cpu(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_cpu;

