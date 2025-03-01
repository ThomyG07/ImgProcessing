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
end MemoireCache;

architecture MemoireCache_arch of MemoireCache is

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
    prog_full : OUT STD_LOGIC
  );
END component;

component FF_gen_tg is
generic (Bus_width: integer := 8);
    Port ( D : in STD_LOGIC_VECTOR(Bus_width-1 DOWNTO 0);
           CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           RESET : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(Bus_width-1 DOWNTO 0)
           );
end component;

type Pixel_s is array(0 to 8) of STD_LOGIC_VECTOR(7 downto 0);
signal P_s: Pixel_s; 

signal TempFifo1: STD_LOGIC_VECTOR(7 downto 0);
signal Datacount_lr1: STD_LOGIC_VECTOR(9 downto 0);
signal DataAvailable_lr1: STD_LOGIC;

signal TempFifo2: STD_LOGIC_VECTOR(7 downto 0);
signal Datacount_lr2: STD_LOGIC_VECTOR(9 downto 0);
signal DataAvailable_lr2: STD_LOGIC;

begin
 FF_0 : FF_gen_tg 
        port map(
                    D => Data_in,
                    CLK => CLK, 
                    EN => Enable ,
                    RESET => Reset,
                    Q => P_s(0)
        );
  FF_1 : FF_gen_tg 
            port map(
                        D => P_s(0),
                        CLK => CLK, 
                        EN => Enable,
                        RESET => Reset,
                        Q => P_s(1)
            );
 FF_2 : FF_gen_tg 
            port map(
                        D => P_s(1),
                        CLK => CLK, 
                        EN => Enable,
                        RESET => Reset,
                        Q => P_s(2)
            ); 
                        
FF_3 : FF_gen_tg 
        port map(
                    D => TempFifo1,
                    CLK => CLK, 
                    EN => Enable ,
                    RESET => Reset,
                    Q => P_s(3)
        );
FF_4 : FF_gen_tg 
            port map(
                        D => P_s(3),
                        CLK => CLK, 
                        EN => Enable,
                        RESET => Reset,
                        Q => P_s(4)
            );
 FF_5 : FF_gen_tg 
            port map(
                        D => P_s(4),
                        CLK => CLK, 
                        EN => Enable,
                        RESET => Reset,
                        Q => P_s(5)
            );             
FF_6 : FF_gen_tg 
        port map(
                    D => TempFifo2,
                    CLK => CLK, 
                    EN => Enable ,
                    RESET => Reset,
                    Q => P_s(6)
        );
FF_7 : FF_gen_tg 
            port map(
                        D => P_s(6),
                        CLK => CLK, 
                        EN => Enable,
                        RESET => Reset,
                        Q => P_s(7)
            );
 FF_8 : FF_gen_tg 
            port map(
                        D => P_s(7),
                        CLK => CLK, 
                        EN => Enable,
                        RESET => Reset,
                        Q => P_s(8)
            );
                    
    LR1: LR 
        port map (
        clk => clk,
        rst => reset,
        din => P_s(2),
        wr_en => wr_en1r1,
        prog_full_thresh =>"0001111011",
        dout => TempFifo1,
        full => full_lr1,
        empty => empty_1r1,
        data_count => Datacount_lr1,
        prog_full => prog_full_lr1
      );
      
       LR2: LR 
        port map (
        clk => clk,
        rst => reset,
        din => P_s(5),
        wr_en => wr_en1r2,
        prog_full_thresh =>"0001111011",
        dout => TempFifo2,
        full =>full_lr2,
        empty =>empty_1r2,
        data_count =>Datacount_lr2,
        prog_full =>prog_full_lr2
      );
      
           P1 <= P_s(0);
           P2 <= P_s(1);
           P3 <= P_s(2);
           P4 <= P_s(3); 
           
           P5 <= P_s(4);
           P6 <= P_s(5);
           P7 <= P_s(6);
           P8 <= P_s(7);
           P9 <= P_s(8);   

end MemoireCache_arch;
