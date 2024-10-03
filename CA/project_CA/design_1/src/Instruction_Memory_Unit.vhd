library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    
use IEEE.numeric_std.all; 
use STD.textio.all;
use ieee.std_logic_textio.all;
entity Instruction_Memory_Unit is  
	generic(AddrWidth : integer:=9;
	DataWidth : integer := 16);
    Port (
        clk        : in  STD_LOGIC;
        MemRead    : in  STD_LOGIC;
        MemWrite   : in  STD_LOGIC;
        Address    : in  integer range 2**AddrWidth-1 downto 0;
        DataIn     : in  STD_LOGIC_VECTOR(DataWidth-1 downto 0);
        DataOut    : out  STD_LOGIC_VECTOR(DataWidth-1 downto 0)
    );
end Instruction_Memory_Unit;

architecture Behavioral of Instruction_Memory_Unit is
Type MyMem is array(2**AddrWidth -1 downto 0) of std_logic_vector(8 -1 downto 0);		 

impure function InitRamFromFile (RamFileName : in string) return MyMem is
	FILE RamFile : text is in RamFileName;
	variable RamFileLine : line;
	variable RAM : MyMem;
	begin
		for I in MyMem'range loop
			readline (RamFile, RamFileLine);
			read (RamFileLine, RAM(I));
		end loop;
	return RAM;
end function;
signal mem : MyMem := InitRamFromFile("rams.data");
begin 
    process (clk)
    begin
        if clk'event and clk = '1' then
            if MemWrite = '1' then
                Mem(Address) <= DataIn(7 downto 0);
				Mem(Address + 1) <= DataIn(15 downto 8);

            end if;
        end if;
    end process;   
	DataOut(7 downto 0) <= Mem(Address) when MemRead = '1' else (others => 'Z');
	DataOut(15 downto 8) <= Mem(Address + 1)when MemRead = '1' else (others => 'Z');
end Behavioral;