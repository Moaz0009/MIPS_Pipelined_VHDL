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




entity wb_stage is
      Port ( reset : in std_logic;
              clk : in  STD_LOGIC;
            read_data : in  STD_LOGIC_VECTOR(23 downto 0); -- data mem out put
            alu_result : in  STD_LOGIC_VECTOR(23 downto 0); -- alu out put
            write_reg : in  STD_LOGIC_VECTOR(3 downto 0);  --destination reg and wb-destination (add)
			  in_reg_write_control : in STD_LOGIC; -- reg write control signal
			  in_mem_to_reg_control : in STD_LOGIC; -- mem to reg mux control
			  -- output--
       write_back : out   STD_LOGIC_VECTOR(23 downto 0); -- data written in reg file (mux out put)
       out_write_reg : out  STD_LOGIC_VECTOR(3 downto 0);  --destination reg and wb-destination (add)
       out_reg_write_control : out STD_LOGIC);

   end wb_stage;
 architecture Behavioral of wb_stage is
 begin
  -- .........wb-mux...................
 with in_mem_to_reg_control select -- mux selection
 write_back <= alu_result when '1',
               read_data when others;
					
 out_write_reg <= write_reg;
out_reg_write_control<= in_reg_write_control;



         
      end Behavioral;
