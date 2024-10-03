library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    
use IEEE.numeric_std.all; 	  
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity ALU is
    Port (	 
		clk       : in Std_logic;
        A         : in  STD_LOGIC_VECTOR(7 downto 0);
        B         : in  STD_LOGIC_VECTOR(7 downto 0);
        OpCode    : in  STD_LOGIC_VECTOR(3 downto 0);
        Result    : out  STD_LOGIC_VECTOR(7 downto 0);
        Carry	  : out  STD_LOGIC;		   
        Zero      : out  STD_LOGIC;   	  
		Sign      : out  Std_logic;
		UnB       : out  Std_logic
    );
end ALU;

architecture Behavioral of ALU is 
Signal next_z : std_logic:='0';
signal next_s : std_logic:='0';
signal next_c : std_logic:='0';
signal res : STD_LOGIC_VECTOR(8 downto 0);
begin 
	process(clk)
		begin
			if clk'event and clk = '1' then	 
				if (to_integer(unsigned(Opcode)) < 10) then  
					next_C <= res(8);
					next_S <= res(7);
					if res(7 downto 0) = "00000000" then
						next_Z <= '1';	   
					else
						next_z <= '0';
					end if;
				else 
					next_C <= next_C;
					next_S <= next_S;
					next_Z <= next_Z;
				end if;	 
				Carry <= next_c;
				Zero <= next_z;
				Sign <= next_s;
			end if;
	end process;	
    process (A, B, OpCode) 
	variable Temp_Result : STD_LOGIC_VECTOR(8 downto 0);  
    begin		   
		Temp_Result := (others => '0');
		UnB <= '0';
        case OpCode is
            when "0000" => -- ADD
                Temp_Result := ('0' & A) + ('0' & B);
            when "0001" => -- SUB
                Temp_Result := ('0' & A) - ('0' & B);
            when "0010" => -- ADDI	  
                Temp_Result := ('0' & A) + ("00000" & B(7 downto 4));
            when "0011" => -- SUBI
                Temp_Result := ('0' & A) - ("00000" & B(7 downto 4));
            when "0100" => -- ADC 
                Temp_Result := ('0' & A) + ('0' & B) + ("00000000" & next_c);
            when "0101" => -- CMP
				Temp_Result := ('0' & A) - ('0' & B);
            when "0110" => -- XOR
                Temp_Result := '0' & (A xor B);
            when "0111" => -- AND
                Temp_Result := '0' & (A and B);
            when "1000" => -- SHL
                Temp_Result := '0' & (B(6 downto 0) & '0');
            when "1001" => -- SHR
				Temp_Result := '0' & ('0' & B(7 downto 1));
			when "1010" => -- LD  
				Temp_Result := ('0' & A) + ("000" & B(7 downto 2));
			when "1011" => -- ST	  
				Temp_Result := ('0' & A) + ("000" & B(7 downto 2));
			when "1100" => -- BZ  	
				if B(7 downto 0) = "00000000" then
					UnB <= '1';
				else
					UnB <= '0';   
				end if;
			when "1101" => -- BS	  
				if B(7) = '1' then
					UnB <= '1';
				else
					UnB <= '0';   
				end if;
			when "1110" => -- BNZ  
				if B(7 downto 0) = "00000000" then
					UnB <= '0';
				else
					UnB <= '1';   
				end if;
            when others =>
                Temp_Result := (others => '0');
		end case;
		Result <= Temp_Result(7 downto 0);
		res <= temp_result;
    end process;
end Behavioral;