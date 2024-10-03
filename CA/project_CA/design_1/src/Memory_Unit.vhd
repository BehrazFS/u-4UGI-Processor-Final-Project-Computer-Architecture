library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    
use IEEE.numeric_std.all; 
entity Memory_Unit is  
	generic(AddrWidth : integer:=8;
	DataWidth : integer := 8);
    Port (
        clk        : in  STD_LOGIC;
        MemRead    : in  STD_LOGIC;
        MemWrite   : in  STD_LOGIC;
        Address    : in  STD_LOGIC_VECTOR(AddrWidth-1 downto 0);
        DataIn     : in  STD_LOGIC_VECTOR(DataWidth-1 downto 0);
        DataOut    : out  STD_LOGIC_VECTOR(DataWidth-1 downto 0)
    );
end Memory_Unit;

architecture Behavioral of Memory_Unit is
Type MyMem is array(2**9 -1 downto 0) of std_logic_vector(DataWidth -1 downto 0);
signal mem : MyMem := (others => (others => '0'));
begin
    process (clk)
    begin
        if clk'event and clk = '1' then
            if MemWrite = '1' then
                Mem(to_integer(unsigned(Address))) <= DataIn;
            end if;
        end if;
    end process;
	DataOut <= Mem(to_integer(unsigned(Address))) when MemRead = '1' else (Others=> 'Z');
end Behavioral;