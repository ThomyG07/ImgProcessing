----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2024 08:54:09
-- Design Name: 
-- Module Name: ControllerMemoireCache - ControllerMemoireCache_arch
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

entity ControllerMemoireCache is
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
end ControllerMemoireCache;

architecture ControllerMemoireCache_arch of ControllerMemoireCache is
type LISTE_ETAT is(ResetEtat,Init,WaitFF1,WriteLR1,WaitFF2,WriteLR2,WaitFF3,DataAvalaible);
signal EtatCourant : LISTE_ETAT:= ResetEtat ; 
signal countFF : integer:=0;
constant MAXPixels : integer:=16384;
signal countPixel : integer:=0;
begin
P_connection: process(CLK,RESET)
begin
    if(reset = '1') then
        EtatCourant <= Init;     
    elsif(CLK'event and CLK = '1') then 
        case EtatCourant is
        
            when ResetEtat =>
                EtatCourant <= Init;
        
            when Init =>
                if(empty_1 = '1' and full_1 = '1') and (empty_2 = '1' and full_2 = '1')  then 
                    EtatCourant <= Init ;
                 elsif (empty_1 = '1' and full_1 = '0') and (empty_2 = '1' and full_2 = '0')
                 then
                    EtatCourant <= WaitFF1;
                 end if;
                 
            when WaitFF1 =>
                if(countFF = 3) then           
                    EtatCourant <=  WriteLR1;
                    countFF <= 0;
                 else 
                    EtatCourant <=  WaitFF1;
                    countFF <= countFF + 1;
                 end if;
                 
             when WriteLR1 =>
                 if (prog_full_1 = '0') then 
                    EtatCourant <= WriteLR1 ;
                 elsif (prog_full_1 = '1')
                 then
                    EtatCourant <= WaitFF2;
                 end if;
                 
              when WaitFF2 =>
                if(countFF = 3) then           
                    EtatCourant <=  WriteLR2;
                    countFF <= 0;
                 else 
                    EtatCourant <=  WaitFF2;
                    countFF <= countFF + 1;
                 end if;
                 
               when WriteLR2 =>
                 if (prog_full_2 = '0') then 
                    EtatCourant <= WriteLR1 ;
                 elsif (prog_full_2 = '1')
                 then
                    EtatCourant <= WaitFF2;
                 end if;
                 
                 when WaitFF3 =>
                if(countFF = 3) then           
                    EtatCourant <=  DataAvalaible;
                    countFF <= 0;
                 else 
                    EtatCourant <=  WaitFF3;
                    countFF <= countFF + 1;
                 end if;
                 
                 when DataAvalaible =>
                      if(countPixel = MAXPixels) then           
                    EtatCourant <=  ResetEtat;
                    countPixel <= 0;
                 else 
                    EtatCourant <=  DataAvalaible;
                    countPixel <= countPixel + 1;
                 end if;
                    
               when others =>
                    EtatCourant <=  init;
                   
        end case;
    end if;              
end process;

p_generation_sorties: process(EtatCourant)
begin
    case EtatCourant is
        when ResetEtat =>
            wr_enlr1<= '0';
            wr_enlr2<= '0';
            resetCache <= '1';
            EnableFF <= '0';
        when init => 
            wr_enlr1<= '0';
            wr_enlr2<= '0';
            resetCache <= '0';
            EnableFF <= '0';
        when WaitFF1 => 
            wr_enlr1<= '0';
            wr_enlr2<= '0';
            resetCache <= '0';
            EnableFF <= '1';
            
        when WriteLR1 => 
            wr_enlr1<= '1';
            wr_enlr2<= '0';
            resetCache <= '0';
            EnableFF <= '1';
              
        when WaitFF2 => 
            wr_enlr1<= '1';
            wr_enlr2<= '0';
            resetCache <= '0';
            EnableFF <= '1';
       
        when WriteLR2 => 
            wr_enlr1<= '1';
            wr_enlr2<= '1';
            resetCache <= '0';
            EnableFF <= '1';
            
         when WaitFF3 => 
            wr_enlr1<= '1';
            wr_enlr2<= '1';
            resetCache <= '0';
            EnableFF <= '1';    
        
        when others => 
            wr_enlr1<= '0';
            wr_enlr2<= '0';
            resetCache <= '0';
            EnableFF <= '0'; 
                  
    end case;
end process;

end ControllerMemoireCache_arch;
