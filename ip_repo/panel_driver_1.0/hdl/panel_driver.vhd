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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity panel_driver is
    Port ( clk : in STD_LOGIC;
           clk_out : out STD_LOGIC;
           reset : in std_logic;
           buf_in : in STD_LOGIC_VECTOR (31 downto 0);
           buf_addr : out STD_LOGIC_VECTOR (11 downto 0);
           R : out STD_LOGIC_VECTOR (1 downto 0);
           G : out STD_LOGIC_VECTOR (1 downto 0);
           B : out STD_LOGIC_VECTOR (1 downto 0));
end panel_driver;

architecture Behavioral of panel_driver is
  signal clk_counter : integer;
  signal clk_out_int : std_logic;
  signal buf_addr_int : std_logic_vector(11 downto 0);
begin

process (clk)
begin
  if(reset = '1') then
    clk_counter <= 0;
    clk_out_int <= '0';
    buf_addr_int <= (others => '0');
  elsif rising_edge(clk) then 
    clk_counter <= clk_counter + 1;
    
    if(clk_counter = 3) then
      clk_out_int <=  not clk_out_int;
      clk_counter <= 0;
    end if;
  end if;
end process;

clk_out <= clk_out_int;
buf_addr <= buf_addr_int;

end Behavioral;
