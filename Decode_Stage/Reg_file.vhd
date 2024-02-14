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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity regfilecode is
    Port ( src1 : in  STD_LOGIC_VECTOR (3 downto 0);
           src2 : in  STD_LOGIC_VECTOR (3 downto 0);
           dst : in  STD_LOGIC_VECTOR (3 downto 0);
           wr_data : in  STD_LOGIC_VECTOR (23 downto 0);
           regwrite : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           out1 : out  STD_LOGIC_VECTOR (23 downto 0);
           out2 : out  STD_LOGIC_VECTOR (23 downto 0));
end regfilecode;

architecture Behavioral of regfilecode is
TYPE ram IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL regfile:                                               
ram:=ram'(x"000001", x"000001", x"000003", x"000004",
x"000005", x"000006", x"000007", x"000008",
x"000009", x"00000a", x"00000b", x"00000c",
x"00000d", x"00000e", x"00000f", x"000010");

begin
out1<=regfile(CONV_INTEGER(src1));--read data from reg specified by addr A1
out2<=regfile(CONV_INTEGER(src2));--read data from reg specified by addr A2
process(clk)
begin
if (clk'EVENT AND clk='1') then
if(regwrite='1')then                 --write enable
regfile(CONV_INTEGER(dst))<=wr_data; --write data in WD3 into reg specified by addr A3
end if;
end if;
end process;

end Behavioral;

