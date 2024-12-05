----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2024 09:00:13
-- Design Name: 
-- Module Name: UniteArithm - UniteArithm_arch
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

entity UniteArithm is
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
           
           Kernel_1: in STD_LOGIC_VECTOR (2 downto 0);
           Kernel_2: in STD_LOGIC_VECTOR (2 downto 0);
           Kernel_3: in STD_LOGIC_VECTOR (2 downto 0);
           Kernel_4: in STD_LOGIC_VECTOR (2 downto 0);

           Kernel_5: in STD_LOGIC_VECTOR (2 downto 0);
           Kernel_6: in STD_LOGIC_VECTOR (2 downto 0);
           Kernel_7: in STD_LOGIC_VECTOR (2 downto 0);
           Kernel_8: in STD_LOGIC_VECTOR (2 downto 0);
           Kernel_9: in STD_LOGIC_VECTOR (2 downto 0);
           
           P_out: out STD_LOGIC_VECTOR (7 downto 0) 
    
    );
end UniteArithm;

architecture UniteArithm_arch of UniteArithm is

signal P1_s : STD_LOGIC_VECTOR (10 downto 0);
signal P2_s : STD_LOGIC_VECTOR (10 downto 0);
signal P3_s : STD_LOGIC_VECTOR (10 downto 0);
signal P4_s : STD_LOGIC_VECTOR (10 downto 0);
signal P5_s : STD_LOGIC_VECTOR (10 downto 0);
signal P6_s : STD_LOGIC_VECTOR (10 downto 0);
signal P7_s : STD_LOGIC_VECTOR (10 downto 0);
signal P8_s : STD_LOGIC_VECTOR (10 downto 0);
signal P9_s : STD_LOGIC_VECTOR (10 downto 0);
--Pipeline 1
signal res_9_8 :  STD_LOGIC_VECTOR (11 downto 0);
signal res_7_6 :  STD_LOGIC_VECTOR (11 downto 0);
signal res_5_4 :  STD_LOGIC_VECTOR (11 downto 0);
signal res_3_2 :  STD_LOGIC_VECTOR (11 downto 0);
signal res_1_0 :  STD_LOGIC_VECTOR (10 downto 0);
--

--Pipeline 2
signal res_98_76 :  STD_LOGIC_VECTOR (12 downto 0);
signal res_54_32 :  STD_LOGIC_VECTOR (12 downto 0);
signal res_1_1 :  STD_LOGIC_VECTOR (10 downto 0);
--

--Pipeline 3
signal Somme :  STD_LOGIC_VECTOR (13 downto 0);
signal res_1_2 :  STD_LOGIC_VECTOR (9 downto 0);
---

--Pipeline 4
signal s : STD_LOGIC_VECTOR (7 downto 0);
--
begin

Coef: process(clk,MemoryReady)
begin
    if(clk'event and clk = '1')
    then
        if(MemoryReady = '1')
        then
             P1_s <= P1 * Kernel_1 ;
             P2_s <= P2 * Kernel_2 ;
             P3_s <= P3 * Kernel_3;
             P4_s <= P4 * Kernel_4;
             P5_s <= P5 * Kernel_5;
             P6_s <= P6 * Kernel_6;
             P7_s <= P7 * Kernel_7;
             P8_s <= P8 * Kernel_8;
             P9_s <= P9 * Kernel_9;
        end if;
    end if;
end process;

Pipeline1: process(clk,MemoryReady)
begin
    if(clk'event and clk = '1')
    then
        if(MemoryReady = '1')
        then
            res_9_8 <= (P9_s(10)& P9_s) + (P8_s(10)&P8_s);
            res_7_6 <= (P7_s(10)& P7_s) + (P6_s(10)&P6_s); 
            res_5_4 <= (P5_s(10)& P5_s) + (P4_s(10)&P4_s);
            res_3_2 <= (P3_s(10)& P3_s) + (P2_s(10)&P2_s); 
            res_1_0 <= P1_s;
        end if;
    end if;
end process;

Pipeline2: process(clk,MemoryReady)
begin
    if(clk'event and clk = '1')
    then
        if(MemoryReady = '1')
        then
            res_98_76 <= res_9_8(11)&res_9_8+ res_7_6(11)&res_7_6;
            res_54_32 <= res_5_4(11)&res_5_4+ res_3_2(11)&res_3_2; 
            res_1_1 <= res_1_0;
        end if;
    end if;
end process;

Pipeline3: process(clk,MemoryReady)
begin
    if(clk'event and clk = '1')
    then
        if(MemoryReady = '1')
        then
            Somme <= '0'&res_98_76 + '0'&res_54_32;
            res_1_2 <= res_1_1;
        end if;
    end if;
end process;

Pipeline4: process(clk,MemoryReady)
begin
    if(clk'event and clk = '1')
    then
        if(MemoryReady = '1')
        then
            S <= Somme(9 downto 2) + res_1_2;
        end if;
    end if;
end process;
P_out <= S;
end UniteArithm_arch;
