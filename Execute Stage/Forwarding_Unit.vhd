----------------------------------------------------------------------------------
-- Company: Benha Faculty OF Engineering
-- Engineers: Moaz Abdeljalil Salah 
--            Nour Eldin Fares
--            Hadeer Ibrahim
--            Yasmeen Emad
--            Eman Mahmoud
-- Create Date:    17:00:29 12/22/2023 
-- Design Name: 
-- Module Name:    MIPS_PROCESSOR - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FORW_UNIT is
    Port ( CLK: in STD_LOGIC;
	        REG_WRITE_EX_MEM : in  STD_LOGIC;
           REG_WRITE_MEM_WB : in  STD_LOGIC;
           RS_ID_EX : in  STD_LOGIC_VECTOR (3 downto 0);
           RT_ID_EX : in  STD_LOGIC_VECTOR (3 downto 0);
           RD_MEM_WB : in  STD_LOGIC_VECTOR (3 downto 0);
           RD_EX_MEM : in  STD_LOGIC_VECTOR (3 downto 0);
           MUX_1 : out  STD_LOGIC_VECTOR (1 downto 0);
           MUX_2 : out  STD_LOGIC_VECTOR (1 downto 0));
end FORW_UNIT;

architecture Behavioral of FORW_UNIT is

begin
process (clk)
begin 
if (rising_edge(clk)) then
--ALU FORWARDING
if (REG_WRITE_EX_MEM ='1') and ( RD_EX_MEM = RS_ID_EX ) then
MUX_1 <= "01"; -- RD FROM EX/MEM INSTEAD OF DECODED RS
MUX_2 <= "00"; -- DECODED RT
elsif (REG_WRITE_EX_MEM ='1') and ( RD_EX_MEM = RT_ID_EX ) then
MUX_2 <= "01"; -- RD FROM EX/MEM INSTEAD OF DECODED RT
MUX_1 <= "00"; -- DECODED RS
--MEM FORWARDING
elsif ((REG_WRITE_MEM_WB ='1') and ( RD_MEM_WB = RS_ID_EX ) ) and not( (REG_WRITE_EX_MEM ='1') and ( RD_EX_MEM = RS_ID_EX ) ) then
MUX_1 <= "10"; -- RD FROM MEM_WB INSTEAD OF DECODED RS
MUX_2 <= "00"; -- DECODED RT
elsif ((REG_WRITE_MEM_WB ='1') and ( RD_MEM_WB = RT_ID_EX ) ) and not( (REG_WRITE_EX_MEM ='1') and ( RD_EX_MEM = RT_ID_EX ) ) then
MUX_2 <= "10"; -- RD FROM MEM/WB INSTEAD OF DECODED RT
MUX_1 <= "00"; -- DECODED RS
else
MUX_2 <= "00"; -- DECODED RT
MUX_1 <= "00"; -- DECODED RS
end if;
end if;
end process;
end Behavioral;

