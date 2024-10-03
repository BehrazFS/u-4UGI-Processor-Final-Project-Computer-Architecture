library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.numeric_std.all; 

entity CPU is
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
		IMR : in std_logic;
		IMW : in Std_logic;
		INST : in Std_logic_vector(15 downto 0)
    );
end CPU;

architecture Behavioral of CPU is
    signal PC     				  : integer range 0 to 511 := 0;
    signal IR      				  : STD_LOGIC_VECTOR(15 downto 0);
    signal OpCode   			  : STD_LOGIC_VECTOR(3 downto 0);
    signal R1, R2, R3 ,Reg_2_Read : STD_LOGIC_VECTOR(2 downto 0);
    signal xyz ,RD1,RD2,RD_2,Write_Data      : STD_LOGIC_VECTOR(7 downto 0);
    signal ALUResult, MemDataOut  : STD_LOGIC_VECTOR(7 downto 0);
    signal Carry, Zero, Sign      : STD_LOGIC;
	signal RegWrite    			  : STD_LOGIC;
    signal MemRead     			  : STD_LOGIC;
    signal MemWrite    			  : STD_LOGIC;
    signal ALUSrc      			  : STD_LOGIC;
    signal Branch,UnB      			  : STD_LOGIC;
    signal ALUOp       			  : STD_LOGIC_VECTOR(3 downto 0);
	signal Reg2Loc	   			  : STD_LOGIC; 
	signal MemToReg	   			  : STD_LOGIC;
begin
	process (IR)
    begin	   
		R1 <= IR(2 downto 0);
		R2 <= IR(5 downto 3);
		R3 <= IR(8 downto 6);
		OpCode <= IR(15 downto 12);
		xyz <= IR(11 downto 4);
    end process;   
	process (R1,R3,Reg2Loc)
    begin
		if Reg2Loc = '1' then
			Reg_2_Read <= R1;
		else
			Reg_2_Read <= R3;
		end if;
    end process; 
	process (MemToReg,MemDataOut,ALUResult)
    begin
		if MemToReg = '1' then
			Write_Data <= MemDataOut;
		else
			Write_Data <= ALUResult;
		end if;
    end process; 
	process (ALUSrc,xyz,RD2)
    begin
		if ALUSrc = '1' then
			RD_2 <= xyz;
		else
			RD_2 <= RD2;
		end if;
    end process;
    -- Control Unit
    Control_Unit_Unit: entity work.Control_Unit
        Port map (
            OpCode => OpCode,
            Z => Zero,
			S => Sign,
			RegWrite => RegWrite,
            MemRead => MemRead,
            MemWrite => MemWrite,
            ALUSrc => ALUSrc,
            Branch => Branch,
            ALUOp => ALUOp,
			MemToReg => MemToReg,
			Reg2Loc => Reg2Loc
        );

    -- Register Bank
    Register_Bank_Unit: entity work.Register_Bank
        Port map (
            clk => clk,
            RegWrite => RegWrite,
            ReadReg1 => R2,
            ReadReg2 => Reg_2_Read,
            WriteReg => R1,
            WriteData => Write_Data,
            ReadData1 => RD1,
            ReadData2 => RD2
        );

    -- ALU
    ALU_Unit: entity work.ALU
        Port map ( 
			clk => clk,
            B => RD_2,
            A => RD1,
            OpCode => ALUOp,          
            Result => ALUResult,
            Carry => Carry,
            Zero => Zero,
            Sign => Sign,
			UnB => UnB
        );

    -- Memory Unit
    Memory_Unit_Unit: entity work.Memory_Unit
        Port map (
            clk => clk,
            MemRead => MemRead,
            MemWrite => MemWrite,
            Address => ALUResult,
            DataIn => RD2,
            DataOut => MemDataOut
        );
	-- Instruction_Memory_Unit
    Instruction_Memory_Unit_Unit: entity work.Instruction_Memory_Unit
        Port map (
            clk => clk,
            MemRead => IMR,
            MemWrite => IMW,
            Address => PC,
            DataIn => INST,
            DataOut => IR
        );

    -- Program Counter Unit
    PC_Unit_Unit: entity work.PC_Unit
        Port map (
            clk => clk,
            reset => reset,
			Ubranch => UnB,
            branch => Branch,
            offset => xyz,
            PC => PC
        );

end Behavioral;