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

entity HAZARD_UNIT is
    Port ( clk: in STD_LOGIC;
	        RT_IF_ID: in  STD_LOGIC_VECTOR (3 downto 0);
	        RS_IF_ID: in  STD_LOGIC_VECTOR (3 downto 0);
           RT_ID_EX : in  STD_LOGIC_VECTOR (3 downto 0);
           branch_stall_signal: in STD_LOGIC;
  			  MEM_READ_ID_EX : in  STD_LOGIC;
           SIGNAL_FLUSH_MUX : out  STD_LOGIC;
           PC_FLUSH : out  STD_LOGIC;
           IF_ID_FLUSH : out  STD_LOGIC);
end HAZARD_UNIT;

architecture Behavioral of HAZARD_UNIT is

begin
process(clk)
begin
if ( (MEM_READ_ID_EX = '1' ) and (branch_stall_signal = '0')  ) then
   if RT_ID_EX = RS_IF_ID then -- lw
   SIGNAL_FLUSH_MUX <= '0';
   PC_FLUSH <= '0';
   IF_ID_FLUSH <='0';
   elsif RT_ID_EX = RT_IF_ID THEN
   SIGNAL_FLUSH_MUX <= '0';
   PC_FLUSH <= '0';
	IF_ID_FLUSH <='0';
	else
	SIGNAL_FLUSH_MUX <= '1';
   PC_FLUSH <= '1';
	IF_ID_FLUSH <='1';
   end if;
elsif (( MEM_READ_ID_EX = '0' ) and ( branch_stall_signal = '1') ) then
   SIGNAL_FLUSH_MUX <= '0';
   IF_ID_FLUSH <='0'; 
elsif (( MEM_READ_ID_EX = '1' ) and (branch_stall_signal = '1') ) then
   
   if RT_ID_EX = RS_IF_ID then -- lw
   SIGNAL_FLUSH_MUX <= '0';
   PC_FLUSH <= '0';
   IF_ID_FLUSH <='0';
   elsif RT_ID_EX = RT_IF_ID THEN
   SIGNAL_FLUSH_MUX <= '0';
   PC_FLUSH <= '0';
	IF_ID_FLUSH <='0';
	else
   SIGNAL_FLUSH_MUX <= '0';
   IF_ID_FLUSH <='0';
   end if;
 else
   SIGNAL_FLUSH_MUX <= '1';
   PC_FLUSH <= '1';
   IF_ID_FLUSH <='1';
 end if;

end process;
end Behavioral;


