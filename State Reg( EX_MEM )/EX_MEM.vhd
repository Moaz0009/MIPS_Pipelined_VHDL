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

entity EXEEE is
port ( R_D : in  STD_LOGIC_VECTOR (23 downto 0);
       Alu_outt : in  STD_LOGIC_VECTOR (23 downto 0);
		 R_outt : in  STD_LOGIC_VECTOR (3 downto 0);
		 clk : in  STD_LOGIC;
		 clr: in  STD_LOGIC;
		 mem_read: in STD_LOGIC;
		 mem_write: in  STD_LOGIC;
		 write_back: in STD_LOGIC;
		 Mem: in STD_LOGIC;
		 mem_read_o: out STD_LOGIC;
		 mem_write_o: out  STD_LOGIC;
       RDD : out  STD_LOGIC_VECTOR (23 downto 0);
        Aluu : out  STD_LOGIC_VECTOR (23 downto 0);
		  adddd : out  STD_LOGIC_VECTOR (3 downto 0);
		  Mem_out: out STD_LOGIC;
		  write_backk: out STD_LOGIC );
end EXEEE;

architecture Behavioral of EXEEE is
begin
process(clk,clr)
begin
if(clr='1')then
RDD <= x"000000";
Aluu <= x"000000";
adddd <= x"0";
Mem_out<= '0';
write_backk<= '0';
mem_read_o<='0';
mem_write_o<='0';
else
if (rising_edge(clk)) then
RDD<=R_D;
Aluu<=Alu_outt;
adddd<= R_outt;
write_backk<=write_back;
Mem_out<=Mem;
mem_read_o <= mem_read;
mem_write_o <= mem_write;
end if;
end if;
end process;
end Behavioral;
