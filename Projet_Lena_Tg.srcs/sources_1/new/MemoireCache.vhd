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
           EnableLR1 : in STD_LOGIC;
           EnableLR2 : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Empty : out STD_LOGIC;
           Full : out STD_LOGIC;
           DataAvailable: OUT STD_LOGIC; 
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
    DataAvailable: OUT STD_LOGIC 
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
signal full_lr1 : STD_LOGIC; 
signal wr_en1r1 : STD_LOGIC;
signal empty_1r1 : STD_LOGIC;
signal prog_full_lr1 : STD_LOGIC;
signal TempFifo1: STD_LOGIC_VECTOR(7 downto 0);
signal Datacount_lr1: STD_LOGIC_VECTOR(7 downto 0);
signal DataAvailable_lr1: STD_LOGIC;
signal TempFifo2: STD_LOGIC_VECTOR(7 downto 0);
begin
 UUT1 : FF_gen_tg 
        port map(
                    D => Data_in,
                    CLK => CLK, 
                    EN => EnableLR1 ,
                    RESET => Reset,
                    Q => P_s(0)
        );

    LR1: LR 
        port map (
        clk => clk,
        rst => reset,
        din => P_s(2),
        wr_en => wr_en1r1,
        prog_full_thresh =>"",
        dout => TempFifo1,
        full =>full_lr1,
        empty =>empty_1r1,
        data_count =>Datacount_lr1,
        prog_full =>prog_full_lr1,
        DataAvailable=>DataAvailable_lr1
      );
      
   
          
loop_ff:for i in 1 to 8 generate
 FF_3: if i = 3  generate
 UUT3 : FF_gen_tg 
        port map(
                    D => TempFifo1,
                    CLK => CLK, 
                    EN => DataAvailable_lr1,
                    RESET => Reset,
                    Q => P_s(i)
        );
    end generate FF_3 ;
     FF_6: if i = 6  generate
     UUT3 : FF_gen_tg 
            port map(
                        D => TempFifo2,
                        CLK => CLK, 
                        EN => DataAvailable_lr2,
                        RESET => Reset,
                        Q => P_s(i)
            );
    end generate FF_6 ;             
       
    FF_0: if not(i = 3  or i = 6) and i<4 generate
     UUTi : FF_gen_tg 
        port map(
                    D => P_s(i-1),
                    CLK => CLK, 
                    EN => DataAvailable_lr1,
                    RESET => Reset,
                    Q => P_s(i)
        );
    end generate FF_0 ;
    
end generate Loop_FF;

Pipeline: process(clk)
begin
if(reset = '0')
then 
    
elsif (CLK'event and CLK ='1' )
    then
        if(Enable = '1')
        then
           P1 <= P_s(0);
           P2 <= P_s(1);
           P3 <= P_s(2);
           P4 <= P_s(3); 
           
           P5 <= P_s(4);
           P6 <= P_s(5);
           P7 <= P_s(6);
           P8 <= P_s(7);   
         end if;
     end if;
end process;




end MemoireCache_arch;
