library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    
use IEEE.numeric_std.all; 

entity Register_Bank is
    Port (
        clk         : in  STD_LOGIC;
        RegWrite    : in  STD_LOGIC;
        ReadReg1    : in  STD_LOGIC_VECTOR(2 downto 0);
        ReadReg2    : in  STD_LOGIC_VECTOR(2 downto 0);
        WriteReg    : in  STD_LOGIC_VECTOR(2 downto 0);
        WriteData   : in  STD_LOGIC_VECTOR(7 downto 0);
        ReadData1   : out  STD_LOGIC_VECTOR(7 downto 0);
        ReadData2   : out  STD_LOGIC_VECTOR(7 downto 0)
    );
end Register_Bank;

architecture Behavioral of Register_Bank is
    type reg_array is array (0 to 7) of STD_LOGIC_VECTOR(7 downto 0);
    signal Registers : reg_array := (others => (others => '0'));
begin
    process (clk)
    begin
        if clk'event and clk = '1' then
            if RegWrite = '1' then
                Registers(to_integer(unsigned(WriteReg))) <= WriteData;
            end if;
        end if;
    end process;

    ReadData1 <= Registers(to_integer(unsigned(ReadReg1)));
    ReadData2 <= Registers(to_integer(unsigned(ReadReg2)));
end Behavioral;