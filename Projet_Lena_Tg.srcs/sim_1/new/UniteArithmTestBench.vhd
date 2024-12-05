----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2024 10:44:06
-- Design Name: 
-- Module Name: UniteArithmTestBench - UniteArithmTestBench_arch
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UniteArithmTestBench is
--  Port ( );
end UniteArithmTestBench;

architecture UniteArithmTestBench_arch of UniteArithmTestBench is
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
           
           Kernel_1: in STD_LOGIC;
           Kernel_2: in STD_LOGIC;
           Kernel_3: in STD_LOGIC;
           Kernel_4: in STD_LOGIC;

           Kernel_5: in STD_LOGIC;
           Kernel_6: in STD_LOGIC;
           Kernel_7: in STD_LOGIC;
           Kernel_8: in STD_LOGIC;
           Kernel_9: in STD_LOGIC;
           
           P_out: out STD_LOGIC_VECTOR (7 downto 0) 
    
    );
end component;
signal clk_s : STD_LOGIC;
constant clock_period: time := 10 ns;
signal MemoryReady_s : STD_LOGIC;
signal P1_s : STD_LOGIC_VECTOR (7 downto 0);
signal P2_s : STD_LOGIC_VECTOR (7 downto 0);
signal P3_s : STD_LOGIC_VECTOR (7 downto 0);
signal P4_s : STD_LOGIC_VECTOR (7 downto 0);
signal P5_s : STD_LOGIC_VECTOR (7 downto 0);
signal P6_s : STD_LOGIC_VECTOR (7 downto 0);
signal P7_s : STD_LOGIC_VECTOR (7 downto 0);
signal P8_s : STD_LOGIC_VECTOR (7 downto 0);
signal P9_s : STD_LOGIC_VECTOR (7 downto 0);
 
signal Kernel_1: STD_LOGIC;
signal Kernel_2: STD_LOGIC;
signal Kernel_3: STD_LOGIC;
signal Kernel_4: STD_LOGIC;
signal Kernel_5: STD_LOGIC;
signal Kernel_6: STD_LOGIC;
signal Kernel_7: STD_LOGIC;
signal Kernel_8: STD_LOGIC;
signal Kernel_9: STD_LOGIC;
signal P_out_s:  STD_LOGIC_VECTOR (7 downto 0);
begin
UUT1: UniteArithm port map(
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
           P_out =>P_out_s 
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
    MemoryReady_s <='0';
    P1_s <= x"00";
    P2_s <= x"01";
    P3_s <= x"02";
    P4_s <= x"03";
    P5_s <= x"04";
    P6_s <= x"05";
    P7_s <= x"06";
    P8_s <= x"07";
    P9_s <= x"08";
    Kernel_1 <= '1';
    Kernel_2 <= '1';
    Kernel_3 <= '1';
    Kernel_4 <= '1';
    Kernel_5 <= '1';
    Kernel_6 <= '1';
    Kernel_7 <= '1';
    Kernel_8 <= '1';
    Kernel_9 <= '1';
    wait for clock_period;
    MemoryReady_s <='1';
    wait ;
    
  
  end process;


end UniteArithmTestBench_arch;
