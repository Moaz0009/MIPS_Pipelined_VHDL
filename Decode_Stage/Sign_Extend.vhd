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

entity signextcode is
    Port ( imt : in  STD_LOGIC_VECTOR (9 downto 0);
           imtext : out  STD_LOGIC_VECTOR (23 downto 0));
end signextcode;

architecture Behavioral of signextcode is

begin
imtext(9 downto 0)<=imt(9 downto 0); --keep the 16 LSb of the o/p same as i/p
with imt(9) select		      --the remaining 16 MSb o/p is the i/p's MSb extended/repeated
imtext(23 downto 10) <= "11111111111111" when '1',
			 "00000000000000" when others;	

end Behavioral;


