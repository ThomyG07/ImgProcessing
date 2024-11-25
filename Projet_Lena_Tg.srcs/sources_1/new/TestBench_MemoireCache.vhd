----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2024 08:16:45
-- Design Name: 
-- Module Name: TestBench_MemoireCache - TestBench_MemoireCache_arch
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;

entity TestBench_MemoireCache is
--  Port ( );
end TestBench_MemoireCache;

architecture TestBench_MemoireCache_arch of TestBench_MemoireCache is
component MemoireCache is
    Port (  clk : in STD_LOGIC;
           Data_in : in STD_LOGIC_VECTOR (7 downto 0);
           Enable : in STD_LOGIC;
           Reset : in STD_LOGIC;
           
           full_lr1 : out STD_LOGIC; 
           wr_en1r1 : in STD_LOGIC;
           empty_1r1 : out STD_LOGIC;
           prog_full_lr1 : out STD_LOGIC;
           
           full_lr2 : out STD_LOGIC; 
           wr_en1r2 : in STD_LOGIC;
           empty_1r2 : out STD_LOGIC;
           prog_full_lr2 : out STD_LOGIC;

           P1 : out STD_LOGIC_VECTOR (7 downto 0);
           P2 : out STD_LOGIC_VECTOR (7 downto 0);
           P3 : out STD_LOGIC_VECTOR (7 downto 0);
           P4 : out STD_LOGIC_VECTOR (7 downto 0);
           P5 : out STD_LOGIC_VECTOR (7 downto 0);
           P6 : out STD_LOGIC_VECTOR (7 downto 0);
           P7 : out STD_LOGIC_VECTOR (7 downto 0);
           P8 : out STD_LOGIC_VECTOR (7 downto 0);
           P9 : out STD_LOGIC_VECTOR (7 downto 0)
           );
end component;
signal clk_s :  STD_LOGIC;
signal Data_in_s :  STD_LOGIC_VECTOR (7 downto 0):= "00000000";
signal Enable_s :  STD_LOGIC;
signal full_lr1_s :  STD_LOGIC; 
signal wr_en1r1_s :  STD_LOGIC;
signal empty_1r1_s : STD_LOGIC;
signal prog_full_lr1_s : STD_LOGIC;
signal full_lr2_s :  STD_LOGIC; 
signal wr_en1r2_s :  STD_LOGIC;
signal empty_1r2_s : STD_LOGIC;
signal prog_full_lr2_s : STD_LOGIC;           
       
signal Reset_s :  STD_LOGIC;
signal P1_s:  STD_LOGIC_VECTOR (7 downto 0);
signal P2_s:  STD_LOGIC_VECTOR (7 downto 0); 
signal P3_s:  STD_LOGIC_VECTOR (7 downto 0);
signal P4_s:  STD_LOGIC_VECTOR (7 downto 0);  
signal P5_s:  STD_LOGIC_VECTOR (7 downto 0);
signal P6_s:  STD_LOGIC_VECTOR (7 downto 0); 
signal P7_s:  STD_LOGIC_VECTOR (7 downto 0);
signal P8_s:  STD_LOGIC_VECTOR (7 downto 0);
signal P9_s:  STD_LOGIC_VECTOR (7 downto 0);
constant clock_period: time := 10 ns;
signal DATA_AVAILABLE : std_logic;
    
begin
UUT1: MemoireCache port map(
           clk => clk_s,
           Data_in => Data_in_s,
           Enable => Enable_s,
           Reset => Reset_s,
           
           full_lr1 => full_lr1_s,
           wr_en1r1 => wr_en1r1_s,
           empty_1r1 => empty_1r1_s,
           prog_full_lr1 => prog_full_lr1_s, 
           
           full_lr2 => full_lr2_s,
           wr_en1r2 => wr_en1r2_s,
           empty_1r2 => empty_1r2_s,
           prog_full_lr2 => prog_full_lr2_s,

           P1 => P1_s,
           P2 => P2_s,
           P3 => P3_s,
           P4 => P4_s,
           P5 => P5_s,
           P6 => P6_s,
           P7 => P7_s,
           P8 => P8_s,
           P9 => P9_s 
    ); 
    
clocking: process
  begin
     clk_s <= '0'; 
     wait for clock_period/2;
     clk_s <= '1';
     wait for clock_period/2;
  end process;
  
value :process
FILE vectors : text;
variable Iline : line;
variable I1_var :std_logic_vector (7 downto 0);      
    begin
     wait for 11*clock_period;
    file_open (vectors,"C:\Users\tg151597\Downloads\Lena128x128g_8bits.dat", read_mode);
        while not endfile(vectors) loop
          readline (vectors,Iline);
          read (Iline,I1_var);                    
          Data_in_s <= I1_var;
          DATA_AVAILABLE <= '1';
          wait for 10 ns;
        end loop;
        DATA_AVAILABLE <= '0';
    wait for 10 ns;
    file_close (vectors);      
    end process;
  
  stimulus: process
  begin
  --init fifo
    wr_en1r1_s <= '0';
    wr_en1r2_s <= '0';
    Enable_s <= '0';
    Reset_s <='1';   
    wait for 1*clock_period;
    
    Reset_s <='0';
    wait for 10*clock_period;
    Enable_s <= '1';
    --FF 0 1 2
    wait for 3*clock_period;
    --Write 9 value in Fifo
      
    wr_en1r1_s <= '1';
    wr_en1r2_s <= '0';
    wait for 125 * clock_period;   
    --FF 3 4 5
    wait for 3*clock_period;
    wr_en1r2_s <= '1';
    wait for 125 * clock_period;  
    --FF 6 7 8
    wait for 3*clock_period;
    wait;
  
  end process;
  

end TestBench_MemoireCache_arch;
