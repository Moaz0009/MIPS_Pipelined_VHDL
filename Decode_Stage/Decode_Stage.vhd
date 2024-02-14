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

entity DEC_stage is
    Port ( pc_4 : in  STD_LOGIC_VECTOR (23 downto 0);
	        pc_4_o : out STD_LOGIC_VECTOR (23 downto 0); --pc incase of a branch
			  pc_mux_selection: out STD_LOGIC;
           inst_in : in  STD_LOGIC_VECTOR (23 downto 0);
			  dstenation_data: in STD_LOGIC_VECTOR (23 downto 0);
           mem_read_ex_stage : in  STD_LOGIC;
           write_add : in  STD_LOGIC_VECTOR (3 downto 0);
			  reg_write_sig: in STD_LOGIC;
			  rt_ex_stage: in STD_LOGIC_VECTOR (3 downto 0);
           clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           rs_data_out : out  STD_LOGIC_VECTOR (23 downto 0);
           rt_data_out : out  STD_LOGIC_VECTOR (23 downto 0);
           sign_extend : out  STD_LOGIC_VECTOR (23 downto 0);
           rs_add_out : out  STD_LOGIC_VECTOR (3 downto 0);
           rt_add_out : out  STD_LOGIC_VECTOR (3 downto 0);
           rt_write_add_out : out  STD_LOGIC_VECTOR (3 downto 0);
           rd_write_add_out : out  STD_LOGIC_VECTOR (3 downto 0);
			  mem_to_reg_s : out  STD_LOGIC;
			  mem_write_s : out  STD_LOGIC;
			  mem_read_s : out STD_LOGIC;
           alu_control_s : out  STD_LOGIC_VECTOR (2 downto 0);
			  alu_src_s : out  STD_LOGIC;
			  reg_dst_s : out  STD_LOGIC;
           reg_write_s : out STD_LOGIC;
			  pc_flush_o: out STD_LOGIC;
			  IF_ID_STATEREG_FLUSH: out  STD_LOGIC);
           
           
end DEC_stage;

architecture Behavioral of DEC_stage is

component controlunitcode is
PORT (
     Op: in STD_LOGIC_VECTOR(5 DOWNTO 0);--The opcode from the current instruction
     Funct: in STD_LOGIC_VECTOR(5 DOWNTO 0);
     MemtoReg: out STD_LOGIC;
     MemWrite: out STD_LOGIC;
	  MemRead: out STD_LOGIC;
     Branch: out STD_LOGIC;
     ALUControl: out STD_LOGIC_VECTOR(2 DOWNTO 0);
     ALUSrc: out STD_LOGIC;
     RegDst: out STD_LOGIC;
     RegWrite: out STD_LOGIC);
     end component;

component regfilecode is
    Port ( src1 : in  STD_LOGIC_VECTOR (3 downto 0);
           src2 : in  STD_LOGIC_VECTOR (3 downto 0);
           dst : in  STD_LOGIC_VECTOR (3 downto 0);
           wr_data : in  STD_LOGIC_VECTOR (23 downto 0);
           regwrite : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           out1 : out  STD_LOGIC_VECTOR (23 downto 0);
           out2 : out  STD_LOGIC_VECTOR (23 downto 0));
end component;

component signextcode is
    Port ( imt : in  STD_LOGIC_VECTOR (9 downto 0);
           imtext : out  STD_LOGIC_VECTOR (23 downto 0));
end component;

component HAZARD_UNIT is
    Port ( clk: in STD_LOGIC;
	        RT_IF_ID: in  STD_LOGIC_VECTOR (3 downto 0);
	        RS_IF_ID: in  STD_LOGIC_VECTOR (3 downto 0);
           RT_ID_EX : in  STD_LOGIC_VECTOR (3 downto 0);
			  branch_stall_signal: in STD_LOGIC;
           MEM_READ_ID_EX : in  STD_LOGIC;
           SIGNAL_FLUSH_MUX : out  STD_LOGIC;
           PC_FLUSH : out  STD_LOGIC;
           IF_ID_FLUSH : out  STD_LOGIC);
end component;

component hazard_mux is
port ( selection: in std_logic;
      -- rd_rt_mux_s : in STD_LOGIC;
      -- signext_rt_mux_s: in STD_LOGIC;
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
end component;
component branch_subtractor is
    Port ( rs : in  STD_LOGIC_VECTOR (23 downto 0);
           rt : in  STD_LOGIC_VECTOR (23 downto 0);
           zero_flag : out  STD_LOGIC);
end component;
signal mem_to_reg_signal : std_logic;
signal mem_write_signal : std_logic;
signal mem_read_signal : std_logic;
SIGNAL branch_signal : std_logic;
signal alu_control_signal : std_logic_vector (2 downto 0);
signal alu_src_signal : std_logic;
signal reg_dst_signal : std_logic;
signal reg_write_signal : std_logic;
signal hazard_mux_selection : std_logic;
signal rs_data_signal : std_logic_vector (23 downto 0);
signal rt_data_signal : std_logic_vector (23 downto 0);
signal zero_flag_signal : std_logic;
signal prediction_signal: std_logic;
signal sign_extend_signal : std_logic_vector (23 downto 0);
signal sign_extend_shift2_signal : std_logic_vector (23 downto 0);
--signal rd_rt_mux_signal :  STD_LOGIC;
--signal signext_rt_mux_signal  : STD_LOGIC;
begin
reg_f: regfilecode port map (inst_in(17 downto 14),inst_in(13 downto 10),write_add,dstenation_data,reg_write_sig,clk,rs_data_signal,rt_data_signal);
sign_ext: signextcode port map (inst_in(9 downto 0),sign_extend_signal);
control_unit: controlunitcode port map (inst_in(23 downto 18),inst_in(5 downto 0),mem_to_reg_signal,mem_write_signal,mem_read_signal,branch_signal,alu_control_signal,alu_src_signal,reg_dst_signal,reg_write_signal);
hazrad_muxx: hazard_mux port map (hazard_mux_selection ,mem_to_reg_signal,mem_write_signal,mem_read_signal,alu_control_signal  ,alu_src_signal,reg_dst_signal,reg_write_signal,mem_to_reg_s, mem_write_s,mem_read_s,alu_control_s,alu_src_s,reg_dst_s,reg_write_s);
hazard_unitt: HAZARD_UNIT port map (clk,inst_in(13 downto 10),inst_in(17 downto 14),rt_ex_stage,prediction_signal,mem_read_ex_stage,hazard_mux_selection,pc_flush_o,IF_ID_STATEREG_FLUSH);
branch_sub: branch_subtractor port map (rs_data_signal,rt_data_signal,zero_flag_signal);


prediction_signal <= branch_signal and zero_flag_signal ; -- 0 no branch , 1 branch & flush
pc_mux_selection <= prediction_signal;
										  
sign_extend_shift2_signal (23 downto 0) <= sign_extend_signal(21 downto 0) & "00";	
pc_4_o <= sign_extend_shift2_signal + pc_4 ;				  
rs_data_out <= rs_data_signal;
rt_data_out <= rt_data_signal;
rs_add_out <= inst_in(17 downto 14);
rt_add_out <= inst_in(13 downto 10);
rt_write_add_out <= inst_in(13 downto 10);
rd_write_add_out <= inst_in(9 downto 6);
sign_extend <= sign_extend_signal;
end Behavioral;

