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
   use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

   entity mem_wb is
      Port ( reset : in std_logic;
             clk : in  STD_LOGIC;
            read_data : in  STD_LOGIC_VECTOR(23 downto 0);
            alu_result : in  STD_LOGIC_VECTOR(23 downto 0);
            write_reg : in  STD_LOGIC_VECTOR(3 downto 0); --destination reg and wb-destination
			  in_reg_write_control : in STD_LOGIC;
			  in_mem_to_reg_control : in STD_LOGIC;
			  -----out put----
           out_read_data : out  STD_LOGIC_VECTOR(23 downto 0);
           out_alu_result : out  STD_LOGIC_VECTOR(23 downto 0);
           out_write_reg : out  STD_LOGIC_VECTOR(3 downto 0);  --destination reg and wb-destination
			  out_reg_write_control : out STD_LOGIC;
			  out_mem_to_reg_control : out STD_LOGIC
			  );
    end mem_wb;

   architecture Behavioral of mem_wb is

     begin
	process(clk, reset)
	begin
		if reset = '1' then
			out_read_data <= (others => '0');
			out_alu_result <= (others => '0');
			out_write_reg <= (others => '0');
			out_reg_write_control <= '0';
			out_mem_to_reg_control <= '0';
		elsif rising_edge(clk) then
          out_reg_write_control <=in_reg_write_control ;
          out_mem_to_reg_control<= in_mem_to_reg_control;
          out_read_data <= read_data;
          out_alu_result <= alu_result;
          out_write_reg <= write_reg;
             end if ;
	end process;

    end Behavioral;

