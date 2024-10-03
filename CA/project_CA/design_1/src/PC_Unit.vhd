library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    
use IEEE.numeric_std.all; 

entity PC_Unit is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        branch   : in  STD_LOGIC; 
		Ubranch  : in  STD_LOGIC;
        offset   : in  STD_LOGIC_VECTOR(7 downto 0);
        PC       : out  integer range 0 to 511
    );
end PC_Unit;

architecture Behavioral of PC_Unit is 
signal PC_next : integer range 0 to 511;
begin
    process (clk, reset)
    begin	   
        if reset = '1' then
            PC_next <= 0;
        elsif clk'event and clk = '1' then
            if (branch = '1' or UBranch = '1') then
                PC_next <= PC_next + (to_integer(unsigned(offset)) * 2);
            else
                PC_next <= PC_next + 2;
            end if;
			
        end if;
    end process;  
	PC <= PC_next;
end Behavioral;