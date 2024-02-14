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

entity mem_stage_code is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           memtoreg : in  STD_LOGIC;
           memread : in  STD_LOGIC;
           memwrite : in  STD_LOGIC;
			  regwrite : in STD_LOGIC;
			  dst : in STD_LOGIC_VECTOR (3 downto 0); --reg file dst--
           aluresult : in  STD_LOGIC_VECTOR (23 downto 0);
			  st_value : in  STD_LOGIC_VECTOR (23 downto 0); -- value to be stored in data memory--
			  --output--
          -- memdataout : out  STD_LOGIC_VECTOR (23 downto 0);
           memtoregout : out  STD_LOGIC;
			  regwriteout : out STD_LOGIC;
			  regwriteout_forward_unit :  out STD_LOGIC;  --signal to forward unit
			  dstout : out STD_LOGIC_VECTOR (3 downto 0); -- reg file dst--
			  dstout_forward_unit : out STD_LOGIC_VECTOR (3 downto 0); -- add to forwarding unit --
           aluresultout : out  STD_LOGIC_VECTOR (23 downto 0);
			  data_alu_forward: out STD_LOGIC_VECTOR (23 downto 0); -- data for forwarding
			  mem_out: out std_logic_vector(23 downto 0)); -- data to be written to reg file--
			  
end mem_stage_code;

architecture Behavioral of mem_stage_code is

component datamemorycode is
    Port ( address : in  STD_LOGIC_VECTOR (23 downto 0);
           memwrite : in  STD_LOGIC;
           memread : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           wrdata : in  STD_LOGIC_VECTOR (23 downto 0);
           rddata : out  STD_LOGIC_VECTOR (23 downto 0));
end component;
begin

mem: datamemorycode port map (aluresult,memwrite,memread,clk,st_value,mem_out);

memtoregout <= memtoreg; -- mux selection
dstout <= dst; -- reg where the data to be written--
dstout_forward_unit <= dst;
aluresultout <= aluresult;
data_alu_forward <= aluresult;
regwriteout <= regwrite;
regwriteout_forward_unit <= regwrite;
end Behavioral;
