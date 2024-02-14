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

entity controlunitcode is
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
end controlunitcode;

architecture Behavioral of controlunitcode is

begin
process(Op,Funct)
begin
if(Op=0 AND Funct="010111") then ALUControl <= "000";
elsif(Op=0 AND Funct="001010") then ALUControl <= "001";
elsif(Op=0 AND Funct="001001") then ALUControl <= "010";
elsif(Op=0 AND Funct="001000") then ALUControl <= "011";
elsif(Op=0 AND Funct="001000") then ALUControl <= "100";
elsif(Op=0 AND Funct="001011") then ALUControl <= "101";
elsif(Op=0 AND Funct="000101") then ALUControl <= "110";
end if;
end process;


----------MemtoReg--Load-----------------------									
with Op select
MemtoReg <= 	'1' when "000101", --load --
					'0' when others;
----------MemRead--Load---------------------
with Op select
MemRead <=      '1' when "000101",
                '0' when others;			
----------MemWrite--Store---------------------
with Op select
MemWrite <= 	'1' when "001000", --store--
					'0' when others;
-----------Branch----------------------------------
with Op select
Branch  <=  	'1' when "001010",
					'0' when others;

-----------RegDst---(!iType)-------------------------------------
with Op select
RegDst <=   '0' when "000000", --R type--
				'1' when others;	-- I type-- 			
------------ALUSrc----------------------------------------------
with Op select
ALUSrc <= 	'0' when "000000", -- read from register R2--
				'1' when others;	-- read from signextent--
------------RegWrite---------------------------------------------
with Op select
RegWrite <= 	'1' when "000000", --R type--
					'1' when "000101", --load--
					'0' when others;
end Behavioral;


