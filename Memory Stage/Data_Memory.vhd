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

entity datamemorycode is
    Port ( address : in  STD_LOGIC_VECTOR (23 downto 0);
           memwrite : in  STD_LOGIC; --memory write--
           memread : in  STD_LOGIC; --memory read--
           clk : in  STD_LOGIC;
           wrdata : in  STD_LOGIC_VECTOR (23 downto 0); -- data to be written to memory--
           rddata : out  STD_LOGIC_VECTOR (23 downto 0)); -- data to be read from memory--
end datamemorycode;

architecture Behavioral of datamemorycode is
TYPE ram IS ARRAY (0 TO 15 ) OF STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL dmem: 
ram:=ram'(
x"ABCDEF",
x"ACEFBB",
x"ABBEFC",
x"DEFACB",
x"BECEAF",
x"FFBBCC",
x"BBCEEF",
x"AAAAEC",
x"CBEDFA",
x"ABABCE",
x"ACFECA",
x"BCECFA",
x"FECDAE",
x"BCBCBA",
x"000006",
x"000005");
begin
process(clk)
begin
if (falling_edge(clk) AND memread='1') then
	rddata<=dmem(CONV_INTEGER(unsigned(address(23 downto 0)))); -- read data from specific address--
elsif(falling_edge(clk) AND memwrite='1')then
	dmem(CONV_INTEGER(unsigned(address(23 downto 0))))<=wrdata; -- write data to specific address--
end if;
end process;

end Behavioral;
