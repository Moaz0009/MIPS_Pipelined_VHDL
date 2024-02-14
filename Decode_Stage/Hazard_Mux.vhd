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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hazard_mux is
port ( selection: in std_logic;
       MemtoReg_s: in STD_LOGIC;
       MemWrite_s: in STD_LOGIC;
		 MemRead_s : in STD_LOGIC;
       ALUControl_s: in STD_LOGIC_VECTOR(2 DOWNTO 0);
       ALUSrc_s: in STD_LOGIC;
       RegDst_s: in STD_LOGIC;
       RegWrite_s: in STD_LOGIC;
		 MemtoReg_s_o: out STD_LOGIC;
       MemWrite_s_o: out STD_LOGIC;
		 MemRead_s_o : out STD_LOGIC;
       ALUControl_s_o: out STD_LOGIC_VECTOR(2 DOWNTO 0);
       ALUSrc_s_o: out STD_LOGIC;
       RegDst_s_o: out STD_LOGIC;
       RegWrite_S_o: out STD_LOGIC);
end hazard_mux;

architecture Behavioral of hazard_mux is

begin
with selection select
  MemtoReg_s_o <= MemtoReg_s when '1',
                '0' when others;
with selection select
  MemWrite_s_o <= MemWrite_s when '1',
                '0' when others;
with selection select
  MemRead_s_o <= MemRead_s when '1',
                '0' when others;

with selection select
  ALUControl_s_o <= ALUControl_s when '1',
                "000" when others;
					
with selection select
  ALUSrc_s_o <= ALUSrc_s when '1',
                '0' when others;	
with selection select
  RegDst_s_o <= RegDst_s when '1',
                '0' when others;	
					
with selection select
  RegWrite_S_o <= RegWrite_S when '1',
                '0' when others;	
					

end Behavioral;


