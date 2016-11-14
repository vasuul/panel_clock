----------------------------------------------------------------------------------
-- Company: Xulne.net
-- Engineer: Vasuul
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

entity panel_driver is
  Port (clk   : in STD_LOGIC;
        resetN: in std_logic;
        panel_test : in std_logic_vector(2 downto 0);
        
        buf_data  : in  STD_LOGIC_VECTOR (31 downto 0);
        buf_addr  : out STD_LOGIC_VECTOR (11 downto 0);
        
        LED_CLK   : out STD_LOGIC;
        LED_OE    : out STD_LOGIC;
        LED_LATCH : out std_logic;
        LED_ADDR  : out std_logic_vector(3 downto 0);
        LED_R     : out STD_LOGIC_VECTOR (1 downto 0);
        LED_G     : out STD_LOGIC_VECTOR (1 downto 0);
        LED_B     : out STD_LOGIC_VECTOR (1 downto 0));
end panel_driver;

architecture Behavioral of panel_driver is
  signal line_counter : integer range 0 to 16;   -- Which line are we drawing
  signal pwm_iter      : integer range 0 to 256;
  signal pwm_block     : integer range 0 to 1;
  signal pwm_value     : integer range 0 to 256;

  -------- signals for panel driver --------
  -- Address for the output latch
  signal curr_line : integer range 0 to 15;   -- 16 scanlines
  signal curr_scan : integer range 0 to 31;   -- 32 bits in a line
  signal load_led  : integer range 0 to 1024; -- 1024 LEDs in the panel

  type PANEL_STATE is (INIT, INIT2, INIT3,
                       LOAD0, LOAD1, LOAD2, LOAD3, LOAD4,
                       CLOCK_LOW, CLOCK_LOW_DATA, CLOCK_LOW_3, 
                       CLOCK_HIGH_DATA, CLOCK_HIGH, CLOCK_HIGH_3,  
                       LINE_DONE);
  signal curr_state : PANEL_STATE;

  signal red0   : std_logic_vector(7 downto 0);
  signal blue0  : std_logic_vector(7 downto 0);
  signal green0 : std_logic_vector(7 downto 0);

  signal red1   : std_logic_vector(7 downto 0);
  signal blue1  : std_logic_vector(7 downto 0);
  signal green1 : std_logic_vector(7 downto 0);
  
  signal color_high : std_logic_vector(31 downto 0);
  signal color_low  : std_logic_vector(31 downto 0);
  
begin

process(clk)
begin
  if(resetN = '0') then
    line_counter <= 0;
    pwm_block <= 0;
    pwm_iter <= 0;
  
    LED_CLK   <= '0';
    buf_addr  <= (others => '0');

    curr_line <= 0;
    curr_scan <= 0;
    load_led  <= 0; -- Always start loading at led 0

    led_oe    <= '1';
    led_latch <= '0';
    
    red0   <= X"20";
    green0 <= X"40";
    blue0  <= X"60";
    red1   <= X"80";
    green1 <= X"A0";
    blue1  <= X"C0";
  
    curr_state <= INIT;
    
  elsif rising_edge(clk) then
    case curr_state is
      -- State we start in - need to load the first colors from the buffer
      when INIT =>
        -- Update which led we need to look up next
        load_led   <= curr_line * 32 + curr_scan;
        pwm_value  <= pwm_block * 256 + pwm_iter;
        LED_OE     <= '0';
        curr_state <= LOAD0;
        
      when LOAD0 => 
        buf_addr <= std_logic_vector(to_unsigned(load_led, 12));
        curr_state <= LOAD1;
        
      when LOAD1 =>
        curr_state <= LOAD2;
        
      when LOAD2 =>
        red0       <= buf_data(23 downto 16);
        green0     <= buf_data(15 downto  8);
        blue0      <= buf_data( 7 downto  0);
        buf_addr   <= std_logic_vector(to_unsigned(load_led + 512, 12));
        curr_state <= LOAD3;
        
      when LOAD3 =>
        curr_state <= LOAD4;
        
      when LOAD4 =>
        red1       <= buf_data(23 downto 16);
        green1     <= buf_data(15 downto  8);
        blue1      <= buf_data( 7 downto  0);
        curr_state <= CLOCK_LOW;
        
      -- Start clocking the data
      when CLOCK_LOW =>
        LED_CLK <= '0';
        
        -- Set the values we need for this iteration
        load_led   <= curr_line * 32 + curr_scan;
        pwm_value  <= pwm_block * 256 + pwm_iter;

        if panel_test /= "000" then

          if panel_test(0) = '1' then
            red0 <= std_logic_vector(to_unsigned(curr_scan, 5)) & "000";
            red1 <= std_logic_vector(to_unsigned(curr_scan, 5)) & "000";
          else
            red0 <= "00000000";
            red1 <= "00000000";
          end if;
        
          if panel_test(1) = '1' then
            green0 <= "0" & std_logic_vector(to_unsigned(curr_line, 4) & "000");
            green1 <= "1" & std_logic_vector(to_unsigned(curr_line, 4) & "000");
          else
              green0 <= "00000000";
              green1 <= "00000000";
          end if;
        
          if panel_test(2) = '1' then
            blue0 <= std_logic_vector(to_unsigned(curr_scan + curr_line, 6)) & "00";
            blue1 <= std_logic_vector(to_unsigned(curr_scan + curr_line + 8, 6)) & "00";
          else
            blue0 <= "00000000";
            blue1 <= "00000000";
          end if;
        end if;
        
        curr_state <= CLOCK_LOW_DATA;

      when CLOCK_LOW_DATA =>
        LED_CLK <= '0';
        
        buf_addr <= std_logic_vector(to_unsigned(load_led, 12));

        if(pwm_value < to_integer(unsigned(red0))) then
          LED_R(0) <= '1';
        else 
          LED_R(0) <= '0';
        end if;
            
        if(pwm_value < to_integer(unsigned(green0))) then
          LED_G(0) <= '1';
        else 
          LED_G(0) <= '0';
        end if;

        if(pwm_value < to_integer(unsigned(blue0))) then
          LED_B(0) <= '1';
        else 
          LED_B(0) <= '0';
        end if;

        if(pwm_value < to_integer(unsigned(red1))) then
          LED_R(1) <= '1';
        else 
          LED_R(1) <= '0';
        end if;

        if(pwm_value < to_integer(unsigned(green1))) then
          LED_G(1) <= '1';
        else 
          LED_G(1) <= '0';
        end if;

        if(pwm_value < to_integer(unsigned(blue1))) then
          LED_B(1) <= '1';
        else 
          LED_B(1) <= '0';
        end if;
        
        curr_state <= CLOCK_LOW_3;
      
      when CLOCK_LOW_3 =>
        -- Latch the color and set the address for the lower half of the panel
        curr_state <= CLOCK_HIGH_DATA;

      -- ----------------------------------------------------------------------
      -- Put out color data onto the wire and toggle the clock
      when CLOCK_HIGH_DATA =>
        LED_CLK    <= '1';

        red0       <= buf_data(23 downto 16);
        green0     <= buf_data(15 downto  8);
        blue0      <= buf_data( 7 downto  0);
        buf_addr   <= std_logic_vector(to_unsigned(load_led + 512, 12));
                
        curr_state <= CLOCK_HIGH;
        
      when CLOCK_HIGH =>
        LED_CLK <= '1';
        
        LED_R <= (others => '0');
        LED_G <= (others => '0');
        LED_B <= (others => '0');
        
        curr_state <= CLOCK_HIGH_3;
        
      when CLOCK_HIGH_3 =>
        -- check to see if we have made it to the end of the scan line
        red1       <= buf_data(23 downto 16);
        green1     <= buf_data(15 downto  8);
        blue1      <= buf_data( 7 downto  0);
        
        if (curr_scan = 31) then
          curr_scan   <= 0;
          line_counter <= 0;
          curr_state <= LINE_DONE;
        else
          curr_scan   <= curr_scan + 1;
          curr_state <= INIT;
        end if;

      -- ----------------------------------------------------------------------
      -- Move onto the next scanline
      when LINE_DONE =>
        LED_CLK <= '0';
        case line_counter is
          when 0 =>
            LED_OE    <= '1';
            LED_LATCH <= '1';
          when 2 =>  
            LED_LATCH <= '0';
            LED_OE    <= '0';
            
          when others => null;
        end case;

        -- Stay in this state for 7 cycles, then move on to the next state
        if line_counter >= 2 then
          if pwm_iter = 255 then
            pwm_iter <= 0;
            
            -- Got to the end of the current block, so go to the next line
            if curr_line = 15 then
              -- Reached the end of the panel, so reset our line counter
              curr_line <= 0;
              
              --  We also have to move onto the next block
              --if pwm_block = 1 then
              --  pwm_block <= 0;
              --else
              --  pwm_block <= pwm_block + 1;
              --end if;
            else
              curr_line <= curr_line + 1;
            end if;
          else
            -- Keep going on this block
            pwm_iter <= pwm_iter + 1;
          end if;
          
          -- Then go back and start clocking more data
          curr_state <= CLOCK_LOW;
        else
          line_counter <= line_counter + 1;
        end if;
        
      when others =>
        curr_state <= INIT;
    end case;
  end if;
end process;

LED_ADDR <= std_logic_vector(to_unsigned(curr_line, 4));

end Behavioral;
