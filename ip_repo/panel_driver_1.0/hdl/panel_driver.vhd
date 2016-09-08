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
        
        buf_data  : in  STD_LOGIC_VECTOR (31 downto 0);
        buf_addr  : out STD_LOGIC_VECTOR (11 downto 0);
        
        LED_CLK   : out STD_LOGIC;
        LED_OE    : out STD_LOGIC;
        LED_LATCH : out std_logic;
        LED_R     : out STD_LOGIC_VECTOR (1 downto 0);
        LED_G     : out STD_LOGIC_VECTOR (1 downto 0);
        LED_B     : out STD_LOGIC_VECTOR (1 downto 0));
end panel_driver;

architecture Behavioral of panel_driver is
  signal clk_counter   : integer;
  signal state_counter : integer;
  signal pwm_counter   : integer;

  -------- signals for panel driver --------
  -- Address for the output latch
  signal curr_addr : integer range 0 to 7;  -- 8 scanlines
  signal curr_bit  : integer range 0 to 31; -- 32 bits

  type PANEL_STATE is (INIT, SHIFTING_LOW, SHIFTING_HIGH, LINE_DONE, PANEL_DONE);
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
    clk_counter   <= 0;
    state_counter <= 0;
    pwm_counter   <= 0;
    
    clk_out_int <= '0';
    buf_addr_int <= (others => '0');

    curr_addr <= 0;
    curr_bit <= 0;
    
    curr_state <= SHIFTING_LOW;
  elsif rising_edge(clk) then
    
    case curr_state is
      -- State we start in
      when INIT =>
        LED_OE <= '1';
        
        -- We need to load the data for both scanlines from blockram
        case state_counter is
          -- Start off with the low address scanline at 0
          when 0 =>
            buf_addr <= (others => '0');            
          when 1=> null;
          when 2 =>
            -- Next is the middle of the buffer at 0x200 (for 32*32 panel)
            color_low <= buf_data;
            buf_addr <= X"200";
          when 3 => null;
          when 4 =>
            color_high <= buf_data;
        end case;

        if state_counter > 4 then
          state_counter <= 0;
          curr_state <= SHIFTING_LOW;
        else
          state_counter <= state_counter + 1;
        end if;

      -- Put out color data onto the wire and toggle the clock
      when SHIFTING_LOW =>
        -- Setup the output signals for the individual pixels
        LED_CLK <= '0';
        case state_counter is
          when 0 =>
            -- First time here we have to load up the pwm values
            red0   <= color_low(31 downto 24);
            green0 <= color_low(23 downto 16);
            blue0  <= color_low(15 downto 8);
            
            red1   <= color_high(31 downto 24);
            green1 <= color_high(23 downto 16);
            blue1  <= color_high(15 downto 8);
          when 1 =>
            -- Then we set the output values based on out pwm values
            --  TODO: Currently just setting them if the value is not 0
            LED_R(0) <= '0' when red0 = X"00" else
                        '1';
            LED_G(0) <= '0' when green0 = X"00" else
                        '1';
            LED_B(0) <= '0' when blue0 = X"00" else
                        '1';
            LED_R(1) <= '0' when red1 = X"00" else
                        '1';
            LED_G(1) <= '0' when green1 = X"00" else
                        '1';
            LED_B(1) <= '0' when blue1 = X"00" else
                        '1';
        end case;

        -- Need to hold these values for a while before going to the
        --  next state
        -- TODO: Make this lower, 4 maybe?
        if state_counter > 5 then
          state_counter <= 0;
          curr_state <= SHIFTING_HIGH;
        else
          state_counter <= state_counter + 1;
        end if;
      
      when SHIFTING_HIGH =>
        -- Get the color values for the next pixels
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
  end if;
end process;

end Behavioral;
