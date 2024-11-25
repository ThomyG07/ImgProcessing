----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2024 10:20:31
-- Design Name: 
-- Module Name: LR - LR_arch
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

entity LR is
Port (
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
    DataAvailable: OUT STD_LOGIC 

);
end LR;

architecture LR_arch of LR is
component fifo_generator_0 IS
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    prog_full_thresh : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    data_count : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    prog_full : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC   
  );
end component;
signal rd_en_s : STD_LOGIC; 
signal dout_s : STD_LOGIC_VECTOR(7 DOWNTO 0);

signal wr_rst_busy_s : STD_LOGIC; 
signal rd_rst_busy_s : STD_LOGIC;
signal prog_full_s : STD_LOGIC;
begin

UUT1: fifo_generator_0 port map(
    clk => clk,
    rst => rst,
    din => din,
    wr_en => wr_en,
    rd_en => rd_en_s,
    prog_full_thresh => prog_full_thresh,
    dout => dout_s,
    full => full,
    empty => empty,
    data_count => data_count,
    prog_full => prog_full_s,
    wr_rst_busy => wr_rst_busy_s,
    rd_rst_busy => rd_rst_busy_s
    ); 
      
DataAvailable <= rd_en_s;
rd_en_s <= prog_full_s;

P1: process(CLK)
    begin
    if (CLK'event and CLK ='1' )
    then
        dout <= dout_s;
     end if;
     
end process;
        
end LR_arch;
