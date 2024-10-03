library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    
use IEEE.numeric_std.all; 

entity Control_Unit is
    Port (
        OpCode      : in  STD_LOGIC_VECTOR(3 downto 0);
        Z           : in std_logic;
		S 			: in Std_logic;
		RegWrite    : out STD_LOGIC;
        MemRead     : out STD_LOGIC;
        MemWrite    : out STD_LOGIC;
        ALUSrc      : out STD_LOGIC;
        Branch      : out STD_LOGIC;
        ALUOp       : out STD_LOGIC_VECTOR(3 downto 0);
		Reg2Loc		: out STD_LOGIC; 
		MemToReg	: out STD_LOGIC
    );
end Control_Unit;

architecture Behavioral of Control_Unit is
begin
    process (OpCode)
    begin
        -- Default values for control signals
        RegWrite <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        ALUSrc <= '0';
        Branch <= '0'; 
		Reg2Loc <= '0';
		MemToreg <= '0';
        ALUOp <= "0000";
			 --fix
        case OpCode is
            when "0000" => -- ADD
                RegWrite <= '1';
                ALUOp <= "0000";
            when "0001" => -- SUB
                RegWrite <= '1';
                ALUOp <= "0001";
            when "0010" => -- ADDI
                RegWrite <= '1';
                ALUSrc <= '1';
                ALUOp <= "0010";
            when "0011" => -- SUBI
                RegWrite <= '1';
                ALUSrc <= '1';
                ALUOp <= "0011";
            when "0100" => -- ADC
                RegWrite <= '1';
                ALUOp <= "0100";
            when "0101" => -- CMP
				ALUOp <= "0101";  
				Reg2Loc <= '1';
            when "0110" => -- XOR
                RegWrite <= '1';
                ALUOp <= "0110";
            when "0111" => -- AND
                RegWrite <= '1';
                ALUOp <= "0111";
            when "1000" => -- SHL
				Reg2Loc <= '1';
                RegWrite <= '1';
                ALUOp <= "1000";
            when "1001" => -- SHR
				RegWrite <= '1';
				Reg2Loc <= '1';
                ALUOp <= "1001";
            when "1010" => -- LD
                RegWrite <= '1';
                MemRead <= '1';
                ALUSrc <= '1'; 	 
				MemToreg <= '1';
				ALUOp <= "1010";
            when "1011" => -- ST
                MemWrite <= '1';
                ALUSrc <= '1';	
				Reg2Loc <= '1';
				ALUOp <= "1011";
            when "1100" => -- BR
                Branch <= '1';
            when "1101" => -- BZ 
				Reg2Loc <= '1';
				ALUOp <= "1100";
                --Branch <= '1'; 
				
            when "1110" => -- BS 
				Reg2Loc <= '1';	
				ALUOp <= "1101";
				--Branch <= '1';
            when "1111" => -- BNZ 
				Reg2Loc <= '1';	
				ALUOp <= "1110";
                --Branch <= '1'; 
            when others =>
                null;
        end case;
    end process;
end Behavioral;