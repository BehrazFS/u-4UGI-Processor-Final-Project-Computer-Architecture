library ieee;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity alu_tb is
end alu_tb;

architecture TB_ARCHITECTURE of alu_tb is
	-- Component declaration of the tested unit
	component alu
	port(
		clk : in STD_LOGIC;
		A : in STD_LOGIC_VECTOR(7 downto 0);
		B : in STD_LOGIC_VECTOR(7 downto 0);
		OpCode : in STD_LOGIC_VECTOR(3 downto 0);
		Result : out STD_LOGIC_VECTOR(7 downto 0);
		Carry : out STD_LOGIC;
		Zero : out STD_LOGIC;
		Sign : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC:='0';
	signal A : STD_LOGIC_VECTOR(7 downto 0);
	signal B : STD_LOGIC_VECTOR(7 downto 0);
	signal OpCode : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Result : STD_LOGIC_VECTOR(7 downto 0);
	signal Carry : STD_LOGIC;
	signal Zero : STD_LOGIC;
	signal Sign : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : alu
		port map (
			clk => clk,
			A => A,
			B => B,
			OpCode => OpCode,
			Result => Result,
			Carry => Carry,
			Zero => Zero,
			Sign => Sign
		);

	-- Add your stimulus here ...
	--clk <= not clk after 2 ns;
	clk <= '1' after 2ns , '0' after 4ns;
	 process
	 begin
		 A<= "11111111";
		 B<= x"01";
		 Opcode <= "0000";
		 
		 wait;
	 end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alu of alu_tb is
	for TB_ARCHITECTURE
		for UUT : alu
			use entity work.alu(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_alu;

