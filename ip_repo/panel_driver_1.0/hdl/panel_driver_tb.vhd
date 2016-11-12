----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2016 08:19:05 PM
-- Design Name: 
-- Module Name: panel_driver_tb - Behavioral
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

entity panel_driver_tb is
--  Port ( );
end panel_driver_tb;

architecture Behavioral of panel_driver_tb is
  component panel_driver_v1_0 is
    generic (
      -- Parameters of Axi Slave Bus Interface PANEL_AXI
      C_PANEL_AXI_ID_WIDTH     : integer    := 1;
      C_PANEL_AXI_DATA_WIDTH   : integer    := 32;
      C_PANEL_AXI_ADDR_WIDTH   : integer    := 14;
      C_PANEL_AXI_AWUSER_WIDTH : integer    := 0;
      C_PANEL_AXI_ARUSER_WIDTH : integer    := 0;
      C_PANEL_AXI_WUSER_WIDTH  : integer    := 0;
      C_PANEL_AXI_RUSER_WIDTH  : integer    := 0;
      C_PANEL_AXI_BUSER_WIDTH  : integer    := 0
      );
    port (
      -- Users to add ports here
      panel_out_clk : out std_logic;
      panel_in_clk  : in std_logic;
      
      panel_test    : in std_logic_vector(2 downto 0);
      panel_reset   : in std_logic;
      
      panel_oe  : out std_logic;
      panel_stb : out std_logic;
      panel_r0  : out std_logic;
      panel_r1  : out std_logic;
      panel_g0  : out std_logic;
      panel_g1  : out std_logic;
      panel_b0  : out std_logic;
      panel_b1  : out std_logic;
      panel_a   : out std_logic;
      panel_b   : out std_logic;
      panel_c   : out std_logic;
      panel_d   : out std_logic;
      -- User ports ends
      -- Do not modify the ports beyond this line

      -- Ports of Axi Slave Bus Interface PANEL_AXI
      panel_axi_aclk     : in std_logic;
      panel_axi_aresetn  : in std_logic;
      panel_axi_awid     : in std_logic_vector(C_PANEL_AXI_ID_WIDTH-1 downto 0);
      panel_axi_awaddr   : in std_logic_vector(C_PANEL_AXI_ADDR_WIDTH-1 downto 0);
      panel_axi_awlen    : in std_logic_vector(7 downto 0);
      panel_axi_awsize   : in std_logic_vector(2 downto 0);
      panel_axi_awburst  : in std_logic_vector(1 downto 0);
      panel_axi_awlock   : in std_logic;
      panel_axi_awcache  : in std_logic_vector(3 downto 0);
      panel_axi_awprot   : in std_logic_vector(2 downto 0);
      panel_axi_awqos    : in std_logic_vector(3 downto 0);
      panel_axi_awregion : in std_logic_vector(3 downto 0);
      panel_axi_awuser   : in std_logic_vector(C_PANEL_AXI_AWUSER_WIDTH-1 downto 0);
      panel_axi_awvalid  : in std_logic;
      panel_axi_awready  : out std_logic;
      panel_axi_wdata    : in std_logic_vector(C_PANEL_AXI_DATA_WIDTH-1 downto 0);
      panel_axi_wstrb    : in std_logic_vector((C_PANEL_AXI_DATA_WIDTH/8)-1 downto 0);
      panel_axi_wlast    : in std_logic;
      panel_axi_wuser    : in std_logic_vector(C_PANEL_AXI_WUSER_WIDTH-1 downto 0);
      panel_axi_wvalid   : in std_logic;
      panel_axi_wready   : out std_logic;
      panel_axi_bid      : out std_logic_vector(C_PANEL_AXI_ID_WIDTH-1 downto 0);
      panel_axi_bresp    : out std_logic_vector(1 downto 0);
      panel_axi_buser    : out std_logic_vector(C_PANEL_AXI_BUSER_WIDTH-1 downto 0);
      panel_axi_bvalid   : out std_logic;
      panel_axi_bready   : in std_logic;
      panel_axi_arid     : in std_logic_vector(C_PANEL_AXI_ID_WIDTH-1 downto 0);
      panel_axi_araddr   : in std_logic_vector(C_PANEL_AXI_ADDR_WIDTH-1 downto 0);
      panel_axi_arlen    : in std_logic_vector(7 downto 0);
      panel_axi_arsize   : in std_logic_vector(2 downto 0);
      panel_axi_arburst  : in std_logic_vector(1 downto 0);
      panel_axi_arlock   : in std_logic;
      panel_axi_arcache  : in std_logic_vector(3 downto 0);
      panel_axi_arprot   : in std_logic_vector(2 downto 0);
      panel_axi_arqos    : in std_logic_vector(3 downto 0);
      panel_axi_arregion : in std_logic_vector(3 downto 0);
      panel_axi_aruser   : in std_logic_vector(C_PANEL_AXI_ARUSER_WIDTH-1 downto 0);
      panel_axi_arvalid  : in std_logic;
      panel_axi_arready  : out std_logic;
      panel_axi_rid      : out std_logic_vector(C_PANEL_AXI_ID_WIDTH-1 downto 0);
      panel_axi_rdata    : out std_logic_vector(C_PANEL_AXI_DATA_WIDTH-1 downto 0);
      panel_axi_rresp    : out std_logic_vector(1 downto 0);
      panel_axi_rlast    : out std_logic;
      panel_axi_ruser    : out std_logic_vector(C_PANEL_AXI_RUSER_WIDTH-1 downto 0);
      panel_axi_rvalid   : out std_logic;
      panel_axi_rready   : in std_logic
      );
  end component;
  
  constant C_PANEL_AXI_ID_WIDTH     : integer    := 1;
  constant C_PANEL_AXI_DATA_WIDTH   : integer    := 32;
  constant C_PANEL_AXI_ADDR_WIDTH   : integer    := 14;
  constant C_PANEL_AXI_AWUSER_WIDTH : integer    := 0;
  constant C_PANEL_AXI_ARUSER_WIDTH : integer    := 0;
  constant C_PANEL_AXI_WUSER_WIDTH  : integer    := 0;
  constant C_PANEL_AXI_RUSER_WIDTH  : integer    := 0;
  constant C_PANEL_AXI_BUSER_WIDTH  : integer    := 0;
  
  -- Clock period definitions and clock signals
  constant clk100_period : time := 10 ns;
  constant clk200_period : time :=  5 ns;
  
  signal clk_100MHz : std_logic;
  signal clk_200MHz : std_logic;

  --panel signals
  signal panel_out_clk : std_logic;
  signal panel_in_clk  : std_logic;
  
  signal panel_test  : std_logic_vector(2 downto 0);
  signal panel_reset : std_logic;
  
  signal panel_oe  : std_logic;
  signal panel_stb : std_logic;
  signal panel_r0  : std_logic;
  signal panel_r1  : std_logic;
  signal panel_g0  : std_logic;
  signal panel_g1  : std_logic;
  signal panel_b0  : std_logic;
  signal panel_b1  : std_logic;
  signal panel_a   : std_logic;
  signal panel_b   : std_logic;
  signal panel_c   : std_logic;
  signal panel_d   : std_logic;

  -- axi bus signals
  signal panel_axi_aresetn  : std_logic;
  signal panel_axi_awid     : std_logic_vector(C_PANEL_AXI_ID_WIDTH-1 downto 0);
  signal panel_axi_awaddr   : std_logic_vector(C_PANEL_AXI_ADDR_WIDTH-1 downto 0);
  signal panel_axi_awlen    : std_logic_vector(7 downto 0);
  signal panel_axi_awsize   : std_logic_vector(2 downto 0);
  signal panel_axi_awburst  : std_logic_vector(1 downto 0);
  signal panel_axi_awlock   : std_logic;
  signal panel_axi_awcache  : std_logic_vector(3 downto 0);
  signal panel_axi_awprot   : std_logic_vector(2 downto 0);
  signal panel_axi_awqos    : std_logic_vector(3 downto 0);
  signal panel_axi_awregion : std_logic_vector(3 downto 0);
  signal panel_axi_awuser   : std_logic_vector(C_PANEL_AXI_AWUSER_WIDTH-1 downto 0);
  signal panel_axi_awvalid  : std_logic;
  signal panel_axi_awready  : std_logic;
  signal panel_axi_wdata    : std_logic_vector(C_PANEL_AXI_DATA_WIDTH-1 downto 0);
  signal panel_axi_wstrb    : std_logic_vector((C_PANEL_AXI_DATA_WIDTH/8)-1 downto 0);
  signal panel_axi_wlast    : std_logic;
  signal panel_axi_wuser    : std_logic_vector(C_PANEL_AXI_WUSER_WIDTH-1 downto 0);
  signal panel_axi_wvalid   : std_logic;
  signal panel_axi_wready   : std_logic;
  signal panel_axi_bid      : std_logic_vector(C_PANEL_AXI_ID_WIDTH-1 downto 0);
  signal panel_axi_bresp    : std_logic_vector(1 downto 0);
  signal panel_axi_buser    : std_logic_vector(C_PANEL_AXI_BUSER_WIDTH-1 downto 0);
  signal panel_axi_bvalid   : std_logic;
  signal panel_axi_bready   : std_logic;
  signal panel_axi_arid     : std_logic_vector(C_PANEL_AXI_ID_WIDTH-1 downto 0);
  signal panel_axi_araddr   : std_logic_vector(C_PANEL_AXI_ADDR_WIDTH-1 downto 0);
  signal panel_axi_arlen    : std_logic_vector(7 downto 0);
  signal panel_axi_arsize   : std_logic_vector(2 downto 0);
  signal panel_axi_arburst  : std_logic_vector(1 downto 0);
  signal panel_axi_arlock   : std_logic;
  signal panel_axi_arcache  : std_logic_vector(3 downto 0);
  signal panel_axi_arprot   : std_logic_vector(2 downto 0);
  signal panel_axi_arqos    : std_logic_vector(3 downto 0);
  signal panel_axi_arregion : std_logic_vector(3 downto 0);
  signal panel_axi_aruser   : std_logic_vector(C_PANEL_AXI_ARUSER_WIDTH-1 downto 0);
  signal panel_axi_arvalid  : std_logic;
  signal panel_axi_arready  : std_logic;
  signal panel_axi_rid      : std_logic_vector(C_PANEL_AXI_ID_WIDTH-1 downto 0);
  signal panel_axi_rdata    : std_logic_vector(C_PANEL_AXI_DATA_WIDTH-1 downto 0);
  signal panel_axi_rresp    : std_logic_vector(1 downto 0);
  signal panel_axi_rlast    : std_logic;
  signal panel_axi_ruser    : std_logic_vector(C_PANEL_AXI_RUSER_WIDTH-1 downto 0);
  signal panel_axi_rvalid   : std_logic;
  signal panel_axi_rready   : std_logic;
  
begin
  inst_panel_driver_v1_0: panel_driver_v1_0
    generic map (
      C_PANEL_AXI_ID_WIDTH     => C_PANEL_AXI_ID_WIDTH,
      C_PANEL_AXI_DATA_WIDTH   => C_PANEL_AXI_DATA_WIDTH,
      C_PANEL_AXI_ADDR_WIDTH   => C_PANEL_AXI_ADDR_WIDTH,
      C_PANEL_AXI_AWUSER_WIDTH => C_PANEL_AXI_AWUSER_WIDTH,
      C_PANEL_AXI_ARUSER_WIDTH => C_PANEL_AXI_ARUSER_WIDTH,
      C_PANEL_AXI_WUSER_WIDTH  => C_PANEL_AXI_WUSER_WIDTH,
      C_PANEL_AXI_RUSER_WIDTH  => C_PANEL_AXI_RUSER_WIDTH,
      C_PANEL_AXI_BUSER_WIDTH  => C_PANEL_AXI_BUSER_WIDTH
      )
    port map (
      panel_out_clk => panel_out_clk, 
      panel_in_clk  => panel_in_clk ,
      panel_test    => panel_test   ,
      panel_reset   => '0'          ,
      panel_oe      => panel_oe     ,  
      panel_stb     => panel_stb    ,  
      panel_r0      => panel_r0     ,  
      panel_r1      => panel_r1     ,  
      panel_g0      => panel_g0     ,  
      panel_g1      => panel_g1     ,  
      panel_b0      => panel_b0     ,  
      panel_b1      => panel_b1     ,  
      panel_a       => panel_a      ,  
      panel_b       => panel_b      ,  
      panel_c       => panel_c      ,  
      panel_d       => panel_d      ,  

      panel_axi_aclk    => clk_100MHz        ,
      panel_axi_aresetn => panel_axi_aresetn ,
      panel_axi_awid    => panel_axi_awid    ,
      panel_axi_awaddr  => panel_axi_awaddr  ,
      panel_axi_awlen   => panel_axi_awlen   ,
      panel_axi_awsize  => panel_axi_awsize  ,
      panel_axi_awburst => panel_axi_awburst ,
      panel_axi_awlock  => panel_axi_awlock  ,
      panel_axi_awcache => panel_axi_awcache ,
      panel_axi_awprot  => panel_axi_awprot  ,
      panel_axi_awqos   => panel_axi_awqos   ,
      panel_axi_awregion=> panel_axi_awregion,
      panel_axi_awuser  => panel_axi_awuser  ,
      panel_axi_awvalid => panel_axi_awvalid ,
      panel_axi_awready => panel_axi_awready ,
      panel_axi_wdata   => panel_axi_wdata   ,
      panel_axi_wstrb   => panel_axi_wstrb   ,
      panel_axi_wlast   => panel_axi_wlast   ,
      panel_axi_wuser   => panel_axi_wuser   ,
      panel_axi_wvalid  => panel_axi_wvalid  ,
      panel_axi_wready  => panel_axi_wready  , 
      panel_axi_bid     => panel_axi_bid     ,
      panel_axi_bresp   => panel_axi_bresp   ,
      panel_axi_buser   => panel_axi_buser   ,
      panel_axi_bvalid  => panel_axi_bvalid  ,
      panel_axi_bready  => panel_axi_bready  ,
      panel_axi_arid    => panel_axi_arid    ,
      panel_axi_araddr  => panel_axi_araddr  ,
      panel_axi_arlen   => panel_axi_arlen   ,
      panel_axi_arsize  => panel_axi_arsize  ,
      panel_axi_arburst => panel_axi_arburst ,
      panel_axi_arlock  => panel_axi_arlock  ,
      panel_axi_arcache => panel_axi_arcache ,
      panel_axi_arprot  => panel_axi_arprot  ,
      panel_axi_arqos   => panel_axi_arqos   ,
      panel_axi_arregion=> panel_axi_arregion,
      panel_axi_aruser  => panel_axi_aruser  ,
      panel_axi_arvalid => panel_axi_arvalid ,
      panel_axi_arready => panel_axi_arready ,
      panel_axi_rid     => panel_axi_rid     ,
      panel_axi_rdata   => panel_axi_rdata   ,
      panel_axi_rresp   => panel_axi_rresp   ,
      panel_axi_rlast   => panel_axi_rlast   ,
      panel_axi_ruser   => panel_axi_ruser   ,
      panel_axi_rvalid  => panel_axi_rvalid  ,
      panel_axi_rready  => panel_axi_rready 
      );
  panelclk_process : process
  begin
    panel_in_clk <= '0';
    wait for clk100_period / 2;
    panel_in_clk <= '1';
    wait for clk100_period / 2;
  end process;

  clk100_process :process
  begin
    clk_100MHz <= '0';
    wait for clk100_period / 2;  --for 0.5 ns signal is '0'.
    clk_100MHz <= '1';
    wait for clk100_period / 2;  --for next 0.5 ns signal is '1'.
  end process;

  clk200_process :process
  begin
    clk_200MHz <= '0';
    wait for clk200_period / 2;  --for 0.5 ns signal is '0'.
    clk_200MHz <= '1';
    wait for clk200_period / 2;  --for next 0.5 ns signal is '1'.
  end process;
  
  stimulus :process
  procedure write_axi(address : in std_logic_vector(13 downto 0);
                      data    : in std_logic_Vector(31 downto 0)) is           
  begin
    -- Set the address
    PANEL_AXI_AWADDR  <= address;
    PANEL_AXI_WDATA   <= data;
    PANEL_AXI_AWVALID <= '1';
    PANEL_AXI_WVALID  <= '1';
    PANEL_AXI_WLAST   <= '1';
    PANEL_AXI_AWLEN   <= "00000001"; -- only writing one byte
    PANEL_AXI_AWBURST <= "00";

    -- wait a clock tick
    wait until clk_100MHz'event and clk_100MHz='0';

    wait until PANEL_AXI_BVALID = '1';

    PANEL_AXI_BREADY  <= '1';
    PANEL_AXI_AWVALID <= '0';
    PANEL_AXI_WVALID  <= '0';

    wait until PANEL_AXI_BVALID = '0';

  end procedure write_axi;
  begin
    panel_test <= "000";
    panel_axi_aresetn <= '0';
    wait for 1 ns;
    panel_axi_aresetn <= '0';
    wait for 10 ns;
    panel_axi_aresetn <= '1';
    wait for 1 ms;

    for i in 0 to 511 loop
--      write_axi(std_logic_vector("000" & to_unsigned(i, 8) & "00"),
--                std_logic_vector(to_unsigned(i, 8)) & X"00" &
--                std_logic_vector(to_unsigned(i, 8)) & X"00");
--      write_axi(std_logic_vector("001" & to_unsigned(i, 8) & "00"),
--                X"00" & std_logic_vector(to_unsigned(i, 8)) &
--                X"00" & std_logic_vector(to_unsigned(i, 8)));
      write_axi(std_logic_vector("000" & to_unsigned(i, 9) & "00"), X"80808080");
      write_axi(std_logic_vector("001" & to_unsigned(i, 9) & "00"), X"00000000");
    end loop;
    wait;
  end process;
  
end Behavioral;
