----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/13/2016 05:02:40 PM
-- Design Name: 
-- Module Name: panel_driver - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- assume the input clock is 50MHz
entity led_clock is
  Port ( clk   : in std_logic;
         reset : in std_logic;
         
         LED_OE : out std_logic;
         
         R0, R1 : out std_logic;
         G0, G1 : out std_logic;
         B0, B1 : out std_logic;
         
         LED_CLK   : out std_logic;
         LED_LATCH : out std_logic
         );
end led_clock;

architecture Behavioral of led_clock is
  -------- signals for heartbeat --------
  signal counter : integer range 0 to 50000000;
  signal hb : std_logic;

  -------- signals for panel driver --------
  -- Address for the output latch
  signal curr_addr : integer range 0 to 7;  -- 8 scanlines
  signal curr_bit  : integer range 0 to 31; -- 32 bits

  type PANEL_STATE is (INIT, SHIFTING_LOW, SHIFTING_HIGH, LINE_DONE, PANEL_DONE);
  signal curr_state : PANEL_STATE;

  signal red0   : std_logic_vector(31 downto 0);
  signal blue0  : std_logic_vector(31 downto 0);
  signal green0 : std_logic_vector(31 downto 0);

  signal red1   : std_logic_vector(31 downto 0);
  signal blue1  : std_logic_vector(31 downto 0);
  signal green1 : std_logic_vector(31 downto 0);
begin

process(clk)
begin
  if(clk'event and clk = '1') then
    if(reset = '1') then
      LED_OE <= '0';
      LED_CLK <= '0';
      LED_LATCH <= '0';
      
      curr_addr <= 0;
      curr_bit <= 0;

      red0   <= X"ABCD0123";
      green0 <= X"8901CDEF";
      blue0  <= X"6789EFAB";
      
      red1   <= X"4567EFAB";
      green1 <= X"2345ABCD";
      blue1  <= X"0123CDEF";
      
      curr_state <= SHIFTING_LOW;
    else
      case curr_state is
        when INIT =>
          LED_OE <= '1';
          -- TODO: Load new values for colors
          -- New plan, On each new bit, make sure I read in
          --  the pixel value for that element.  Then we can set
          --  the bit based on that number.  We should not try to
          --  front calculate anything.  That will be too slow
          red0   <= X"ABCD0123";
          green0 <= X"8901CDEF";
          blue0  <= X"6789EFAB";
          
          red1   <= X"4567EFAB";
          green1 <= X"2345ABCD";
          blue1  <= X"0123CDEF";
          
          curr_state <= SHIFTING_LOW;
          
        when SHIFTING_LOW =>
          LED_CLK <= '0';
          
          R0 <= red0(0);   -- Upper scanline first
          G0 <= green0(0);
          B0 <= blue0(0);

          R1 <= red1(0);   -- Then the lower scanline
          G1 <= green1(0);
          B1 <= blue1(0);

          curr_state <= SHIFTING_HIGH;
          
        when SHIFTING_HIGH =>
          LED_CLK <= '1';
          
          red0   <= red0(0)   & red0(31 downto 1);
          green0 <= green0(0) & green0(31 downto 1);
          blue0  <= blue0(0)  & blue0(31 downto 1);

          red1   <= red1(0)   & red1(31 downto 1);
          green1 <= green1(0) & green1(31 downto 1);
          blue1  <= blue1(0)  & blue1(31 downto 1);

          if(curr_bit = 31) then
            curr_state <= LINE_DONE;
            LED_LATCH <= '1';
          else
            curr_state <= SHIFTING_LOW;
          end if;

          curr_bit <= curr_bit + 1;

        when LINE_DONE =>
          LED_LATCH <= '0';
          LED_CLK <= '0';

          if(curr_addr = 7) then
            curr_state <= PANEL_DONE;
          else
            curr_state <= INIT;
          end if;

          curr_bit <= 0;
          curr_addr <= curr_addr + 1;
          
        when PANEL_DONE =>
          curr_addr <= 0;
          curr_state <= INIT;
          
      end case;
    end if; -- end reset else
  end if; -- end clk'event
end process;
                   
end Behavioral;
