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
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IF_ID_Register is
  port (
    -- Control signals
    clk     : in std_logic;
    clr     : in std_logic;

    -- IF/ID pipeline stage inputs
    instruction_in : in std_logic_vector(23 downto 0);
    pc_in          : in std_logic_vector(23 downto 0);
    

    -- IF/ID pipeline stage outputs
    instruction_out : out std_logic_vector(23 downto 0);
    pc_out          : out std_logic_vector(23 downto 0)
  );
end entity IF_ID_Register;

architecture IF_ID of IF_ID_Register is
  
begin
  process (clk, clr)
  begin
    if clr = '1' then
      instruction_out <= (others => '0');
      pc_out <= (others => '0');
    elsif rising_edge(clk) then
        instruction_out <= instruction_in;
        pc_out <= pc_in;
      end if;

  end process;


end architecture IF_ID;
