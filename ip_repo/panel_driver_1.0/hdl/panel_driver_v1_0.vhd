library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity panel_driver_v1_0 is
  generic (
    -- Users to add parameters here

    -- User parameters ends
    -- Do not modify the parameters beyond this line


    -- Parameters of Axi Slave Bus Interface PANEL_AXI
    C_PANEL_AXI_ID_WIDTH	: integer	:= 1;
    C_PANEL_AXI_DATA_WIDTH	: integer	:= 32;
    C_PANEL_AXI_ADDR_WIDTH	: integer	:= 14;
    C_PANEL_AXI_AWUSER_WIDTH	: integer	:= 0;
    C_PANEL_AXI_ARUSER_WIDTH	: integer	:= 0;
    C_PANEL_AXI_WUSER_WIDTH	: integer	:= 0;
    C_PANEL_AXI_RUSER_WIDTH	: integer	:= 0;
    C_PANEL_AXI_BUSER_WIDTH	: integer	:= 0
    );
  port (
    -- Users to add ports here
    panel_out_clk : out std_logic;
    panel_in_clk  : in std_logic;
    
    panel_test  : in std_logic_vector(2 downto 0);
    panel_reset : in std_logic;
    
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
    panel_axi_aclk	: in std_logic;
    panel_axi_aresetn	: in std_logic;
    panel_axi_awid	: in std_logic_vector(C_PANEL_AXI_ID_WIDTH-1 downto 0);
    panel_axi_awaddr	: in std_logic_vector(C_PANEL_AXI_ADDR_WIDTH-1 downto 0);
    panel_axi_awlen	: in std_logic_vector(7 downto 0);
    panel_axi_awsize	: in std_logic_vector(2 downto 0);
    panel_axi_awburst	: in std_logic_vector(1 downto 0);
    panel_axi_awlock	: in std_logic;
    panel_axi_awcache	: in std_logic_vector(3 downto 0);
    panel_axi_awprot	: in std_logic_vector(2 downto 0);
    panel_axi_awqos	: in std_logic_vector(3 downto 0);
    panel_axi_awregion	: in std_logic_vector(3 downto 0);
    panel_axi_awuser	: in std_logic_vector(C_PANEL_AXI_AWUSER_WIDTH-1 downto 0);
    panel_axi_awvalid	: in std_logic;
    panel_axi_awready	: out std_logic;
    panel_axi_wdata	: in std_logic_vector(C_PANEL_AXI_DATA_WIDTH-1 downto 0);
    panel_axi_wstrb	: in std_logic_vector((C_PANEL_AXI_DATA_WIDTH/8)-1 downto 0);
    panel_axi_wlast	: in std_logic;
    panel_axi_wuser	: in std_logic_vector(C_PANEL_AXI_WUSER_WIDTH-1 downto 0);
    panel_axi_wvalid	: in std_logic;
    panel_axi_wready	: out std_logic;
    panel_axi_bid	: out std_logic_vector(C_PANEL_AXI_ID_WIDTH-1 downto 0);
    panel_axi_bresp	: out std_logic_vector(1 downto 0);
    panel_axi_buser	: out std_logic_vector(C_PANEL_AXI_BUSER_WIDTH-1 downto 0);
    panel_axi_bvalid	: out std_logic;
    panel_axi_bready	: in std_logic;
    panel_axi_arid	: in std_logic_vector(C_PANEL_AXI_ID_WIDTH-1 downto 0);
    panel_axi_araddr	: in std_logic_vector(C_PANEL_AXI_ADDR_WIDTH-1 downto 0);
    panel_axi_arlen	: in std_logic_vector(7 downto 0);
    panel_axi_arsize	: in std_logic_vector(2 downto 0);
    panel_axi_arburst	: in std_logic_vector(1 downto 0);
    panel_axi_arlock	: in std_logic;
    panel_axi_arcache	: in std_logic_vector(3 downto 0);
    panel_axi_arprot	: in std_logic_vector(2 downto 0);
    panel_axi_arqos	: in std_logic_vector(3 downto 0);
    panel_axi_arregion	: in std_logic_vector(3 downto 0);
    panel_axi_aruser	: in std_logic_vector(C_PANEL_AXI_ARUSER_WIDTH-1 downto 0);
    panel_axi_arvalid	: in std_logic;
    panel_axi_arready	: out std_logic;
    panel_axi_rid	: out std_logic_vector(C_PANEL_AXI_ID_WIDTH-1 downto 0);
    panel_axi_rdata	: out std_logic_vector(C_PANEL_AXI_DATA_WIDTH-1 downto 0);
    panel_axi_rresp	: out std_logic_vector(1 downto 0);
    panel_axi_rlast	: out std_logic;
    panel_axi_ruser	: out std_logic_vector(C_PANEL_AXI_RUSER_WIDTH-1 downto 0);
    panel_axi_rvalid	: out std_logic;
    panel_axi_rready	: in std_logic
    );
end panel_driver_v1_0;

architecture arch_imp of panel_driver_v1_0 is
  signal clka  : std_logic;
  --signal wea	 : std_logic_vector(0 downto 0);
  signal driver_addr : std_logic_vector(11 downto 0);
  signal driver_data  : std_logic_vector(31 downto 0);
  signal douta : std_logic_vector(31 downto 0);
  signal clkb  : std_logic;
  signal web   : std_logic_vector(0 downto 0);
  signal addrb : std_logic_vector(11 downto 0);
  signal dinb  : std_logic_vector(31 downto 0);
  signal doutb : std_logic_vector(31 downto 0);
  signal panel_axi_aresetn_buf : std_logic;
  signal panel_axi_aresetn_sig : std_logic;
  signal panel_resetN : std_logic := '1';
  
  component panel_buf_mem is
    Port ( 
      clka  : in STD_LOGIC;
      wea   : in STD_LOGIC_VECTOR ( 0 to 0 );
      addra : in STD_LOGIC_VECTOR ( 11 downto 0 );
      dina  : in STD_LOGIC_VECTOR ( 31 downto 0 );
      douta : out STD_LOGIC_VECTOR ( 31 downto 0 );
      clkb  : in STD_LOGIC;
      web   : in STD_LOGIC_VECTOR ( 0 to 0 );
      addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
      dinb  : in STD_LOGIC_VECTOR ( 31 downto 0 );
      doutb : out STD_LOGIC_VECTOR ( 31 downto 0 )
      );
  end component panel_buf_mem;

  component panel_driver is
    Port ( clk        : in STD_LOGIC;
           resetN     : in std_logic;
           panel_test : in std_logic_vector(2 downto 0);
           
           buf_data : in STD_LOGIC_VECTOR (31 downto 0);
           buf_addr : out STD_LOGIC_VECTOR (11 downto 0);
           
           LED_CLK  : out STD_LOGIC;
           LED_OE   : out std_logic;
           LED_LATCH: out std_logic;
           LED_ADDR : out std_logic_vector(3 downto 0);
           LED_R    : out STD_LOGIC_VECTOR (1 downto 0);
           LED_G    : out STD_LOGIC_VECTOR (1 downto 0);
           LED_B    : out STD_LOGIC_VECTOR (1 downto 0));
  end component panel_driver;
  -- component declaration
  component panel_driver_v1_0_PANEL_AXI is
    generic (
      C_S_AXI_ID_WIDTH	        : integer	:= 1;
      C_S_AXI_DATA_WIDTH	: integer	:= 32;
      C_S_AXI_ADDR_WIDTH	: integer	:= 12;
      C_S_AXI_AWUSER_WIDTH	: integer	:= 0;
      C_S_AXI_ARUSER_WIDTH	: integer	:= 0;
      C_S_AXI_WUSER_WIDTH	: integer	:= 0;
      C_S_AXI_RUSER_WIDTH	: integer	:= 0;
      C_S_AXI_BUSER_WIDTH	: integer	:= 0
      );
    port (
      panel_buffer_wen      : out std_logic_vector(0 downto 0);
      panel_buffer_addr     : out std_logic_vector(11 downto 0);
      panel_buffer_data_in  : in  std_logic_vector(31 downto 0);
      panel_buffer_data_out : out std_logic_vector(31 downto 0);

      S_AXI_ACLK	: in std_logic;
      S_AXI_ARESETN	: in std_logic;
      S_AXI_AWID	: in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
      S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
      S_AXI_AWLEN	: in std_logic_vector(7 downto 0);
      S_AXI_AWSIZE	: in std_logic_vector(2 downto 0);
      S_AXI_AWBURST	: in std_logic_vector(1 downto 0);
      S_AXI_AWLOCK	: in std_logic;
      S_AXI_AWCACHE	: in std_logic_vector(3 downto 0);
      S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
      S_AXI_AWQOS	: in std_logic_vector(3 downto 0);
      S_AXI_AWREGION	: in std_logic_vector(3 downto 0);
      S_AXI_AWUSER	: in std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
      S_AXI_AWVALID	: in std_logic;
      S_AXI_AWREADY	: out std_logic;
      S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
      S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
      S_AXI_WLAST	: in std_logic;
      S_AXI_WUSER	: in std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
      S_AXI_WVALID	: in std_logic;
      S_AXI_WREADY	: out std_logic;
      S_AXI_BID	        : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
      S_AXI_BRESP	: out std_logic_vector(1 downto 0);
      S_AXI_BUSER	: out std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
      S_AXI_BVALID	: out std_logic;
      S_AXI_BREADY	: in std_logic;
      S_AXI_ARID	: in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
      S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
      S_AXI_ARLEN	: in std_logic_vector(7 downto 0);
      S_AXI_ARSIZE	: in std_logic_vector(2 downto 0);
      S_AXI_ARBURST	: in std_logic_vector(1 downto 0);
      S_AXI_ARLOCK	: in std_logic;
      S_AXI_ARCACHE	: in std_logic_vector(3 downto 0);
      S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
      S_AXI_ARQOS	: in std_logic_vector(3 downto 0);
      S_AXI_ARREGION	: in std_logic_vector(3 downto 0);
      S_AXI_ARUSER	: in std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
      S_AXI_ARVALID	: in std_logic;
      S_AXI_ARREADY	: out std_logic;
      S_AXI_RID	        : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
      S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
      S_AXI_RRESP	: out std_logic_vector(1 downto 0);
      S_AXI_RLAST	: out std_logic;
      S_AXI_RUSER	: out std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
      S_AXI_RVALID	: out std_logic;
      S_AXI_RREADY	: in std_logic
      );
  end component panel_driver_v1_0_PANEL_AXI;

begin

  panel_buf_mem_inst : panel_buf_mem
    port map (
      clka  => panel_in_clk,
      wea   => (others => '0'),
      addra => driver_addr,
      dina  => (others => '0'),
      douta => driver_data,
      
      clkb  => panel_axi_aclk,
      web   => web,
      addrb => addrb,
      doutb => doutb,
      dinb  => dinb
      );

  panel_driver_inst : panel_driver
    port map (
      clk   => panel_in_clk,
      resetN => panel_resetN, -- and because neg
      panel_test => panel_test,
             
      buf_data => driver_data,
      buf_addr => driver_addr,

      LED_CLK   => panel_out_clk,
      LED_OE    => panel_oe,
      LED_LATCH => panel_stb,
      LED_ADDR(0) => panel_a,
      LED_ADDR(1) => panel_b,
      LED_ADDR(2) => panel_c,
      LED_ADDR(3) => panel_d,
      LED_R(0)  => panel_r0,
      LED_R(1)  => panel_r1,
      LED_G(0)  => panel_g0,
      LED_G(1)  => panel_g1,
      LED_B(0)  => panel_b0,
      LED_B(1)  => panel_b1
      );

-- Instantiation of Axi Bus Interface PANEL_AXI
  panel_driver_v1_0_PANEL_AXI_inst : panel_driver_v1_0_PANEL_AXI
    generic map (
      C_S_AXI_ID_WIDTH	     => C_PANEL_AXI_ID_WIDTH,
      C_S_AXI_DATA_WIDTH     => C_PANEL_AXI_DATA_WIDTH,
      C_S_AXI_ADDR_WIDTH     => C_PANEL_AXI_ADDR_WIDTH,
      C_S_AXI_AWUSER_WIDTH   => C_PANEL_AXI_AWUSER_WIDTH,
      C_S_AXI_ARUSER_WIDTH   => C_PANEL_AXI_ARUSER_WIDTH,
      C_S_AXI_WUSER_WIDTH    => C_PANEL_AXI_WUSER_WIDTH,
      C_S_AXI_RUSER_WIDTH    => C_PANEL_AXI_RUSER_WIDTH,
      C_S_AXI_BUSER_WIDTH    => C_PANEL_AXI_BUSER_WIDTH
      )
    port map (
      panel_buffer_wen      => web,
      panel_buffer_addr     => addrb,
      panel_buffer_data_in  => doutb,
      panel_buffer_data_out => dinb,

      S_AXI_ACLK	=> panel_axi_aclk,
      S_AXI_ARESETN	=> panel_axi_aresetn,
      S_AXI_AWID	=> panel_axi_awid,
      S_AXI_AWADDR	=> panel_axi_awaddr,
      S_AXI_AWLEN	=> panel_axi_awlen,
      S_AXI_AWSIZE	=> panel_axi_awsize,
      S_AXI_AWBURST	=> panel_axi_awburst,
      S_AXI_AWLOCK	=> panel_axi_awlock,
      S_AXI_AWCACHE	=> panel_axi_awcache,
      S_AXI_AWPROT	=> panel_axi_awprot,
      S_AXI_AWQOS	=> panel_axi_awqos,
      S_AXI_AWREGION	=> panel_axi_awregion,
      S_AXI_AWUSER	=> panel_axi_awuser,
      S_AXI_AWVALID	=> panel_axi_awvalid,
      S_AXI_AWREADY	=> panel_axi_awready,
      S_AXI_WDATA	=> panel_axi_wdata,
      S_AXI_WSTRB	=> panel_axi_wstrb,
      S_AXI_WLAST	=> panel_axi_wlast,
      S_AXI_WUSER	=> panel_axi_wuser,
      S_AXI_WVALID	=> panel_axi_wvalid,
      S_AXI_WREADY	=> panel_axi_wready,
      S_AXI_BID	    => panel_axi_bid,
      S_AXI_BRESP	=> panel_axi_bresp,
      S_AXI_BUSER	=> panel_axi_buser,
      S_AXI_BVALID	=> panel_axi_bvalid,
      S_AXI_BREADY	=> panel_axi_bready,
      S_AXI_ARID	=> panel_axi_arid,
      S_AXI_ARADDR	=> panel_axi_araddr,
      S_AXI_ARLEN	=> panel_axi_arlen,
      S_AXI_ARSIZE	=> panel_axi_arsize,
      S_AXI_ARBURST	=> panel_axi_arburst,
      S_AXI_ARLOCK	=> panel_axi_arlock,
      S_AXI_ARCACHE	=> panel_axi_arcache,
      S_AXI_ARPROT	=> panel_axi_arprot,
      S_AXI_ARQOS	=> panel_axi_arqos,
      S_AXI_ARREGION=> panel_axi_arregion,
      S_AXI_ARUSER	=> panel_axi_aruser,
      S_AXI_ARVALID	=> panel_axi_arvalid,
      S_AXI_ARREADY	=> panel_axi_arready,
      S_AXI_RID	    => panel_axi_rid,
      S_AXI_RDATA	=> panel_axi_rdata,
      S_AXI_RRESP	=> panel_axi_rresp,
      S_AXI_RLAST	=> panel_axi_rlast,
      S_AXI_RUSER	=> panel_axi_ruser,
      S_AXI_RVALID	=> panel_axi_rvalid,
      S_AXI_RREADY	=> panel_axi_rready
      );
      
      panel_resetN <= panel_axi_aresetn and not panel_reset;
end arch_imp;
