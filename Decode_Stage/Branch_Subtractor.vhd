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

entity branch_subtractor is
    Port ( rs : in  STD_LOGIC_VECTOR (23 downto 0);
           rt : in  STD_LOGIC_VECTOR (23 downto 0);
           zero_flag : out  STD_LOGIC);
end branch_subtractor;

architecture Behavioral of branch_subtractor is
signal zero: std_logic_vector (23 downto 0);
begin
zero <= rs - rt ;
process(zero)
begin
if ( zero = x"000000") then
zero_flag <='1';
else
zero_flag <='0';
end if;
end process;
end Behavioral;

