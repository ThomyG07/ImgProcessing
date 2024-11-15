----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2024 11:36:28
-- Design Name: 
-- Module Name: MemoireCache - MemoireCache_arch
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

entity MemoireCache is
    Port ( Data_in : in STD_LOGIC_VECTOR (7 downto 0);
           Enable : in STD_LOGIC;
           Reset : in STD_LOGIC;
           P1 : out STD_LOGIC_VECTOR (7 downto 0);
           P2 : out STD_LOGIC_VECTOR (7 downto 0);
           P3 : out STD_LOGIC_VECTOR (7 downto 0);
           P4 : out STD_LOGIC_VECTOR (7 downto 0);
           P5 : out STD_LOGIC_VECTOR (7 downto 0);
           P6 : out STD_LOGIC_VECTOR (7 downto 0);
           P7 : out STD_LOGIC_VECTOR (7 downto 0);
           P8 : out STD_LOGIC_VECTOR (7 downto 0)
           );
end MemoireCache;

architecture MemoireCache_arch of MemoireCache is

begin


end MemoireCache_arch;
