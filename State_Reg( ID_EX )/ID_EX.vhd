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

entity ID_EX is
    Port ( clr: in STD_LOGIC;
	        clk : in STD_LOGIC;
           rs_data : in  STD_LOGIC_VECTOR (23 downto 0);
           rt_data : in  STD_LOGIC_VECTOR (23 downto 0);
           Sign_extend : in  STD_LOGIC_VECTOR (23 downto 0);
			  rs_add: in std_logic_vector (3 downto 0);
           rt_add: in std_logic_vector (3 downto 0);
			  rt_write_add: in std_logic_vector (3 downto 0);
			  rd_write_add: in std_logic_vector (3 downto 0);
           Reg_write : in  STD_LOGIC;
           Mem_write : in  STD_LOGIC;
           Mem_read : in  STD_LOGIC;
           Alu_Src : in  STD_LOGIC;
           Mem_to_Reg : in  STD_LOGIC;
           Reg_Dst : in  STD_LOGIC;
           Alu_control : in  STD_LOGIC_VECTOR (2 downto 0);
			 -------------------------------------------------------
           rs_data_o : out  STD_LOGIC_VECTOR (23 downto 0);
           rt_data_o : out  STD_LOGIC_VECTOR (23 downto 0);
           Sign_extend_o : out  STD_LOGIC_VECTOR (23 downto 0);
			  rs_add_o: out std_logic_vector (3 downto 0);
           rt_add_o: out std_logic_vector (3 downto 0);
			  rt_write_add_o: out std_logic_vector (3 downto 0);
			  rd_write_add_o: out std_logic_vector (3 downto 0);
           Reg_write_o : out  STD_LOGIC;
           Mem_write_o : out  STD_LOGIC;
           Mem_read_o : out  STD_LOGIC;
           Alu_Src_o : out  STD_LOGIC;
           Mem_to_Reg_o : out  STD_LOGIC;
           Reg_Dst_o : out  STD_LOGIC;
           Alu_control_o : out  STD_LOGIC_VECTOR (2 downto 0));

end ID_EX;

architecture Behavioral of ID_EX is


begin
process (clk,clr)
begin
if (clr = '1') then
rs_data_o <= x"000000";
rt_data_o <= x"000000";
Sign_extend_o <= x"000000";
rs_add_o <= "0000";
rt_add_o <= "0000";
rt_write_add_o <= "0000";
rd_write_add_o <= "0000";
Reg_Write_o <= '0';
Mem_Write_o <= '0';
Mem_read_o <= '0';
Alu_Src_o <= '0';
Mem_to_Reg_o <= '0';
Reg_Dst_o <= '0';
Alu_control_o <= "000";
else
if (rising_edge(clk)) then
--Pc_value_o <= Pc_value;
rs_data_o <= rs_data;
rt_data_o <= rt_data;
Sign_extend_o <= Sign_extend;
rs_add_o <= rs_add;
rt_add_o <= rt_add;
rt_write_add_o <= rt_write_add;
rd_write_add_o <= rd_write_add;
Reg_Write_o <= Reg_Write;
Mem_Write_o <= Mem_Write;
Mem_read_o <= Mem_read;
Alu_Src_o <= Alu_Src;
Mem_to_Reg_o <= Mem_to_Reg;
Reg_Dst_o <= Reg_Dst;
Alu_control_o <= Alu_control;
end if;
end if;
-------------------------------------
end process;
end Behavioral;

