----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2024 10:59:49
-- Design Name: 
-- Module Name: TestBench_LR - TestBench_LR_arch
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

entity TestBench_LR is
--  Port ( );
end TestBench_LR;

architecture TestBench_LR_arch of TestBench_LR is
component LR IS
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    prog_full_thresh : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    data_count : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    prog_full : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC ;
    DataAvailable: OUT STD_LOGIC 
  );
END component;

signal clk_s:STD_LOGIC;
signal rst_s: STD_LOGIC;
signal din_s: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal wr_en_s : STD_LOGIC;
signal prog_full_thresh_s : STD_LOGIC_VECTOR(9 DOWNTO 0);
signal dout_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal full_s :  STD_LOGIC;
Signal empty_s : STD_LOGIC;
Signal data_count_s : STD_LOGIC_VECTOR(9 DOWNTO 0);
Signal prog_full_s : STD_LOGIC;
Signal wr_rst_busy_s : STD_LOGIC;
Signal rd_rst_busy_s : STD_LOGIC;
Signal DataAvailable_s : STD_LOGIC;
constant clock_period: time := 10 ns;
begin

UUT1: LR port map(
    clk => clk_s,
    rst => rst_s,
    din => din_s,
    wr_en => wr_en_s,
    prog_full_thresh => prog_full_thresh_s,
    dout => dout_s,
    full => full_s,
    empty => empty_s,
    data_count => data_count_s,
    prog_full => prog_full_s,
    wr_rst_busy => wr_rst_busy_s,
    rd_rst_busy => rd_rst_busy_s,
    DataAvailable => DataAvailable_s
    ); 
    clocking: process
  begin
     clk_s <= '0'; 
     wait for clock_period/2;
     clk_s <= '1';
     wait for clock_period/2;
  end process;
  
  stimulus: process
  begin
  --init fifo
    prog_full_s <= '0';
    rst_s <= '1';
    din_s <= (others=>'0');
    wr_en_s <= '0';
    prog_full_thresh_s <= "0000000000";
    wait for 3*clock_period;
    rst_s <= '0';
    prog_full_thresh_s <= "0000000011";
    wait for 10*clock_period;
 --
 --Write 3 value in Fifo 
    
    wr_en_s <= '1';
    din_s <= x"01";
    wait for clock_period;
    din_s <= x"02";
    wait for clock_period;
    din_s <= x"03";
    wait for clock_period;
    din_s <= x"04";
    wait for clock_period;
  
    wr_en_s <= '0';
    wait for 3*clock_period;
    wr_en_s <= '1';
    din_s <= x"05";
    wait for clock_period;
    din_s <= x"06";
    wait for clock_period;
    din_s <= x"07";
    wait for clock_period;
    
    wr_en_s <= '0';
    
    wait ;
    

end process;


end TestBench_LR_arch;
