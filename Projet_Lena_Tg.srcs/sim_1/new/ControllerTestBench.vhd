----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2024 11:43:31
-- Design Name: 
-- Module Name: ControllerTestBench - ControllerTestBench_arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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


entity ControllerTestBench is
--  Port ( );
end ControllerTestBench;

architecture ControllerTestBench_arch of ControllerTestBench is
component ControllerMemoireCache is
    Port (
           clk : in STD_LOGIC;
           
           reset : in STD_LOGIC; 
           
           resetCache : out STD_LOGIC;
            
           empty_1 : in STD_LOGIC;
           full_1 : in STD_LOGIC;
           prog_full_1 : in STD_LOGIC;
           
           empty_2 : in STD_LOGIC;
           full_2 : in STD_LOGIC;
           prog_full_2 : in STD_LOGIC;
           
           
           EnableFF : out STD_LOGIC;
           wr_enlr1 : out STD_LOGIC;
           wr_enlr2 : out STD_LOGIC;
           MemoryReady :out STD_LOGIC                   
           );
end component;
signal clk_s: STD_LOGIC;
constant clock_period: time := 10 ns;
signal reset_s: STD_LOGIC;
signal resetCache_s: STD_LOGIC;
signal empty_1_s: STD_LOGIC;
signal full_1_s: STD_LOGIC;
signal prog_full_1_s: STD_LOGIC;
signal empty_2_s: STD_LOGIC;
signal full_2_s: STD_LOGIC;
signal prog_full_2_s: STD_LOGIC;
signal EnableFF_s: STD_LOGIC;
signal wr_enlr1_s: STD_LOGIC;
signal wr_enlr2_s: STD_LOGIC;

begin
UUT1: ControllerMemoireCache port map(
           clk => clk_s,
           Reset => Reset_s,
           resetCache => resetCache_s,
       
           empty_1 => empty_1_s, 
           full_1 => full_1_s,
           prog_full_1 => prog_full_1_s,
           
           empty_2 => empty_2_s, 
           full_2 => full_2_s,
           prog_full_2 => prog_full_2_s,
           
           EnableFF => EnableFF_s,
           wr_enlr1 => wr_enlr1_s,
           wr_enlr2 => wr_enlr2_s
    ); 
    
clocking: process
  begin
     clk_s <= '0'; 
     wait for clock_period/2;
     clk_s <= '1';
     wait for clock_period/2;
  end process;
  
  stimulus : process
  begin
    Reset_s<= '1';
    
    empty_1_s <= '0';
    full_1_s <= '0';
    prog_full_1_s <= '0';
    
    empty_2_s <= '0';
    full_2_s <= '0';
    prog_full_2_s <= '0';
    
    wait for 2*clock_period;
    Reset_s<= '0';
    empty_1_s <= '1';
    full_1_s <= '1';
    prog_full_1_s <= '0';
    
    empty_2_s <= '1';
    full_2_s <= '1';
    prog_full_2_s <= '0';
    
    wait for 10 *clock_period;
    
    empty_1_s <= '1';
    full_1_s <= '0';
    prog_full_1_s <= '0';
    
    empty_2_s <= '1';
    full_2_s <= '0';
    prog_full_2_s <= '0';
    
    wait for clock_period;
    empty_1_s <= '0';
    full_1_s <= '0';
    prog_full_1_s <= '0';
    
    empty_2_s <= '0';
    full_2_s <= '0';
    prog_full_2_s <= '0';
   
    wait;
    
    
  
  end process;



end ControllerTestBench_arch;
