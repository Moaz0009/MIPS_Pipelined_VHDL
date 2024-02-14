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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity programcounter is
---------//ports//---------
PORT (
din: in STD_LOGIC_VECTOR(23 DOWNTO 0); --instruction number input--
clk: in STD_LOGIC; -- clk source is (clk and stall_branch signal)
clr: in STD_LOGIC:='0';
dout: out STD_LOGIC_VECTOR(23 DOWNTO 0)); --instruction number output--
--------------------------
end programcounter;

architecture Behavioral of programcounter is
begin
PROCESS (clk,clr)  BEGIN
  IF (clr='1') THEN dout <= x"000000"; --start PC 
  elsIF rising_edge(clk) and clr = '0' THEN 
  dout<=din;
END IF;                   
END PROCESS; 

--------------------------

end Behavioral;
