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


	
	
	entity fetch_stage is
		 Port (
				  im_out : out  STD_LOGIC_VECTOR (23 downto 0); -- INSTRUCTION FETCHED FROM INSTRUCTION MEM
				   pc_4_out : out  STD_LOGIC_VECTOR (23 downto 0); --pc+4
               PC_branch : in STD_LOGIC_VECTOR(23 downto 0); --pc signal for branch
               stall_branch : in  STD_LOGIC; -- NO OPERATION AND CURRENT PC VALUE DOESN'T CHANGE
               Pcmux : in STD_LOGIC;
				   clk : in  STD_LOGIC; 
               clr : in  STD_LOGIC);
	end fetch_stage;
	
	architecture Behavioral of fetch_stage is
	
COMPONENT instructionmemory is
PORT (address: in STD_LOGIC_VECTOR(23 DOWNTO 0); 
 	   data: out STD_LOGIC_VECTOR(23 DOWNTO 0));--output that will carry the inst
end COMPONENT;

COMPONENT programcounter  is
port(
din: in STD_LOGIC_VECTOR(23 DOWNTO 0); --instruction number input--
clk: in STD_LOGIC;
clr: in STD_LOGIC:='0';
dout: out STD_LOGIC_VECTOR(23 DOWNTO 0)); --instruction number output--

end COMPONENT;
-----------------------------------------------------------------------------------------------------------------------
signal pc : STD_LOGIC_VECTOR (23 downto 0) := x"000000"; --initial value of pc 
signal pc_plus : STD_LOGIC_VECTOR (23 downto 0):= x"000000"; --initial value of pc+4 
signal pc_next_s : STD_LOGIC_VECTOR (23 downto 0):=x"000000";
signal clk_hazard : std_logic;
signal PCmux_out : STD_LOGIC_VECTOR (23 downto 0);
-----------------------------------------------------------------------------------------------------------------------

begin
clk_hazard<= clk and stall_branch;
inst_mem: instructionmemory port map(pc,im_out);
program_count: programcounter port map(Pcmux_out,clk_hazard,clr,pc);
clk_hazard<= clk and stall_branch;
pc_plus <= pc + 1 ; --signal used inside has the value of pc+4
pc_4_out <= pc_plus ; 

--PCmuxout--

with Pcmux select --pc mux selection
PCmux_out <= pc_plus  when '0',
             PC_branch when others ;

end Behavioral;
