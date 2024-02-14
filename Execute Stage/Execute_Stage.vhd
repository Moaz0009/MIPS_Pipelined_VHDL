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

entity EXECUTESTAGE is
port(      clkk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
			  MemtoReg: in STD_LOGIC; -- WB Mux selection
           MemWrite: in STD_LOGIC; -- MEM signal
			  RegWrite: in STD_LOGIC; -- REG signal
			  Mem_read : in  STD_LOGIC; --MEM signal
			  Alu_control : in  STD_LOGIC_VECTOR (2 downto 0); -- Decides ALU operation 
			  REGWRITE_EX_MEM : in  STD_LOGIC; --FeedBack to ForwardUnit signal
           REGWRITE_MEM_WB : in  STD_LOGIC; --FeedBack ForwardUnit signal
			  sel_mux_3:in  STD_LOGIC; -- RT or RD MUX
			  sel_mux_4:in  STD_LOGIC; -- ALU inp MUX selection
			  reg_1: in STD_LOGIC_VECTOR (23 downto 0); ---rs decoded
			  reg_2: in STD_LOGIC_VECTOR (23 downto 0); ----rt decoded
				 rs_alu:in STD_LOGIC_VECTOR (23 downto 0); --FeedBack to ForwardUnit data
				 rs_mem:in STD_LOGIC_VECTOR (23 downto 0); --FeedBack to ForwardUnit data
             rt_alu:in STD_LOGIC_VECTOR (23 downto 0); --FeedBack to ForwardUnit data
             rt_mem:in STD_LOGIC_VECTOR (23 downto 0); --FeedBack to ForwardUnit data
				 sign_extend:in STD_LOGIC_VECTOR (23 downto 0); -- 
				 rt_add: in STD_LOGIC_VECTOR (3 downto 0); -- Destination add (LW - Sw)
				 des_add: in STD_LOGIC_VECTOR (3 downto 0); -- Destination add (R type)
				 rs_add: in STD_LOGIC_VECTOR (3 downto 0); --FeedBack to ForwardUnit address
				  rt_alu_add:in STD_LOGIC_VECTOR (3 downto 0); --FeedBack to ForwardUnit address
				   rt_mem_add:in STD_LOGIC_VECTOR (3 downto 0); --FeedBack to ForwardUnit address
					
				 ---------------out----------------------
				 alu_out:out STD_LOGIC_VECTOR (23 downto 0);
				 mux_2_out:out STD_LOGIC_VECTOR (23 downto 0);
				  des_add_out: out STD_LOGIC_VECTOR (3 downto 0);
				  RegWrite_out: out STD_LOGIC;
				   Mem_read_out : out STD_LOGIC;
					  MemWrite_out: out STD_LOGIC;
					 MemtoReg_out: out STD_LOGIC);
				
					 
end EXECUTESTAGE;

architecture Behavioral of EXECUTESTAGE is

component alucode is 
  Port ( inp1 : in  STD_LOGIC_VECTOR (23 downto 0);
           inp2 : in  STD_LOGIC_VECTOR (23 downto 0);
           ctr : in  STD_LOGIC_VECTOR (2 downto 0);
           result : out  STD_LOGIC_VECTOR (23 downto 0));
end component;
---------------------------
component FORW_UNIT is
    Port ( CLK: in STD_LOGIC;
	        REG_WRITE_EX_MEM : in  STD_LOGIC;
           REG_WRITE_MEM_WB : in  STD_LOGIC;
           RS_ID_EX : in  STD_LOGIC_VECTOR (3 downto 0);
           RT_ID_EX : in  STD_LOGIC_VECTOR (3 downto 0);
           RD_MEM_WB : in  STD_LOGIC_VECTOR (3 downto 0);
           RD_EX_MEM : in  STD_LOGIC_VECTOR (3 downto 0);
           MUX_1 : out  STD_LOGIC_VECTOR (1 downto 0);
           MUX_2 : out  STD_LOGIC_VECTOR (1 downto 0));

end component;
--------------------------
signal MUX_1_signal: STD_LOGIC_VECTOR (1 downto 0);
signal MUX_2_signal: STD_LOGIC_VECTOR (1 downto 0);
signal inp_mux:STD_LOGIC_VECTOR (23 downto 0);
signal mux_3_out:STD_LOGIC_VECTOR (3 downto 0);
signal inp1_signal :STD_LOGIC_VECTOR (23 downto 0);
signal inp2_signal :STD_LOGIC_VECTOR (23 downto 0);


begin
---------mux1-----------
with MUX_1_signal select 
 inp1_signal<=reg_1 when "00",
              rs_alu when "01",
              rs_mem when others;--10--
  ----------mux2---------
  with MUX_2_signal select 
 inp_mux<=reg_2 when "00",
          rt_alu when "01",
          rt_mem when others;---10---
  --------mux3-----------
  with sel_mux_3 select 
 mux_3_out<=des_add when '0',
            rt_add when others;
				
  ---------mux4-------------
  with sel_mux_4 select 
 inp2_signal<=inp_mux when '0',
              sign_extend when others;
				  
 
 -------alu-----------
 alu:alucode port map(inp1_signal,inp2_signal,alu_control,alu_out);

 RegWrite_out<=RegWrite;
 Mem_read_out<= Mem_read;
 MemWrite_out<=MemWrite;
 MemtoReg_out<= MemtoReg;
 des_add_out<=mux_3_out;
 mux_2_out<=inp_mux;
 
 ---------forwarding_unit----------
 forw_unitt:FORW_UNIT port map(clkk, REGWRITE_EX_MEM,REGWRITE_MEM_WB,rs_add,rt_add,rt_mem_add, rt_alu_add,MUX_1_signal,MUX_2_signal);
 
end Behavioral;

