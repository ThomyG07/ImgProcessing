----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2024 14:40:07
-- Design Name: 
-- Module Name: TestBenchProjetLena - TestBenchProjetLena_arch
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

entity TestBenchProjetLena is
--  Port ( );
end TestBenchProjetLena;

architecture TestBenchProjetLena_arch of TestBenchProjetLena is

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

signal resetCache_s: STD_LOGIC;

signal EnableFF_s: STD_LOGIC;


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

component UniteArithm is
    Port ( 
           clk : in STD_LOGIC;
           MemoryReady : in STD_LOGIC;
           P1 : in STD_LOGIC_VECTOR (7 downto 0);
           P2 : in STD_LOGIC_VECTOR (7 downto 0);
           P3 : in STD_LOGIC_VECTOR (7 downto 0);
           P4 : in STD_LOGIC_VECTOR (7 downto 0);
           P5 : in STD_LOGIC_VECTOR (7 downto 0);
           P6 : in STD_LOGIC_VECTOR (7 downto 0);
           P7 : in STD_LOGIC_VECTOR (7 downto 0);
           P8 : in STD_LOGIC_VECTOR (7 downto 0);
           P9 : in STD_LOGIC_VECTOR (7 downto 0);
           
           Kernel_1: in signed (2 downto 0);
           Kernel_2: in signed (2 downto 0);
           Kernel_3: in signed (2 downto 0);
           Kernel_4: in signed (2 downto 0);

           Kernel_5: in signed (2 downto 0);
           Kernel_6: in signed (2 downto 0);
           Kernel_7: in signed (2 downto 0);
           Kernel_8: in signed (2 downto 0);
           Kernel_9: in signed (2 downto 0);
           
           P_out: out STD_LOGIC_VECTOR (7 downto 0) 
    
    );
end component;

signal clk_s :  STD_LOGIC;
--Cache Memory
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
--
--unite arithm
signal Kernel_1: signed (2 downto 0);
signal Kernel_2: signed (2 downto 0);
signal Kernel_3: signed (2 downto 0);
signal Kernel_4: signed (2 downto 0);
signal Kernel_5: signed (2 downto 0);
signal Kernel_6: signed (2 downto 0);
signal Kernel_7: signed (2 downto 0);
signal Kernel_8: signed (2 downto 0);
signal Kernel_9: signed (2 downto 0);
signal P_out_s:  STD_LOGIC_VECTOR (7 downto 0);

constant clock_period: time := 10 ns;
signal DATA_AVAILABLE : std_logic;
signal MemoryReady_s : STD_LOGIC;  
begin
UUT1: MemoireCache port map(
           clk => clk_s,
           Data_in => Data_in_s,
           Enable => EnableFF_s,
           Reset => resetCache_s,
           
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
    
    UUT2: UniteArithm port map(
           clk => clk_s,
            MemoryReady => MemoryReady_s, 
            P1 => P1_s, 
            P2 => P2_s,
            P3 => P3_s, 
            P4 => P4_s,
            P5 => P5_s, 
            P6 => P6_s,
            P7 => P7_s, 
            P8 => P8_s,
            P9 => P9_s,   
           Kernel_1 => Kernel_1,
           Kernel_2 => Kernel_2,
           Kernel_3 => Kernel_3,
           Kernel_4 => Kernel_4,
           Kernel_5 => Kernel_5,
           Kernel_6 => Kernel_6,
           Kernel_7 => Kernel_7,
           Kernel_8 => Kernel_8,
           Kernel_9 => Kernel_9,
           P_out => P_out_s 
    ); 
    
    UUT3: ControllerMemoireCache port map(
           clk => clk_s,
           Reset => Reset_s,
           resetCache => resetCache_s,
       
           empty_1 => empty_1r1_s, 
           full_1 => full_lr1_s,
           prog_full_1 => prog_full_lr1_s,
           
           empty_2 => empty_1r2_s, 
           full_2 => full_lr2_s,
           prog_full_2 => prog_full_lr2_s,
           
           EnableFF => EnableFF_s,
           wr_enlr1 => wr_en1r1_s,
           wr_enlr2 => wr_en1r2_s,
           MemoryReady => MemoryReady_s
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
    file_open (vectors,"D:\4A\VHDL filtre\CodeSource\Lena128x128g_8bits.dat", read_mode);
        while not endfile(vectors) loop
          readline (vectors,Iline);
          read (Iline,I1_var);                    
          Data_in_s <= I1_var;
          DATA_AVAILABLE <= '1';
          wait for clock_period;
        end loop;
        DATA_AVAILABLE <= '0';
    wait for clock_period;
    file_close (vectors);      
    end process;
  
  stimulus: process
  begin
  --init fifo
    Reset_s<= '1';
    Kernel_1 <= "001";
    Kernel_2 <= "000";
    Kernel_3 <= "111";
    Kernel_4 <= "010";
    Kernel_5 <= "000";
    Kernel_6 <= "110";
    Kernel_7 <= "001";
    Kernel_8 <= "000";
    Kernel_9 <= "111";  
    wait for clock_period;
     Reset_s<= '0';
    wait;
  
  end process;
  
  p_write: process
  file results : text;
  variable OLine : line;
  variable O1_var :std_logic_vector (7 downto 0);
    
    begin
    file_open (results,"D:\4A\VHDL filtre\CodeSource\Lena128x128g_8bitsFiltre2.dat", write_mode);
    wait until MemoryReady_s = '1';
    write (Oline, O1_var, right, 2);
    while MemoryReady_s ='1' loop
      write (Oline, P_out_s, right, 2);
      writeline (results, Oline);
      wait for clock_period; 
    end loop;
    file_close (results);
    wait;
 end process;

  


end TestBenchProjetLena_arch;
