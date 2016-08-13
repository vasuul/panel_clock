library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity heartbeat_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface HB_AXI
		C_HB_AXI_DATA_WIDTH	: integer	:= 32;
		C_HB_AXI_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here\
		hb_clock: in std_logic;
        hb_output : out std_logic;
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface HB_AXI
		hb_axi_aclk	: in std_logic;
		hb_axi_aresetn	: in std_logic;
		hb_axi_awaddr	: in std_logic_vector(C_HB_AXI_ADDR_WIDTH-1 downto 0);
		hb_axi_awprot	: in std_logic_vector(2 downto 0);
		hb_axi_awvalid	: in std_logic;
		hb_axi_awready	: out std_logic;
		hb_axi_wdata	: in std_logic_vector(C_HB_AXI_DATA_WIDTH-1 downto 0);
		hb_axi_wstrb	: in std_logic_vector((C_HB_AXI_DATA_WIDTH/8)-1 downto 0);
		hb_axi_wvalid	: in std_logic;
		hb_axi_wready	: out std_logic;
		hb_axi_bresp	: out std_logic_vector(1 downto 0);
		hb_axi_bvalid	: out std_logic;
		hb_axi_bready	: in std_logic;
		hb_axi_araddr	: in std_logic_vector(C_HB_AXI_ADDR_WIDTH-1 downto 0);
		hb_axi_arprot	: in std_logic_vector(2 downto 0);
		hb_axi_arvalid	: in std_logic;
		hb_axi_arready	: out std_logic;
		hb_axi_rdata	: out std_logic_vector(C_HB_AXI_DATA_WIDTH-1 downto 0);
		hb_axi_rresp	: out std_logic_vector(1 downto 0);
		hb_axi_rvalid	: out std_logic;
		hb_axi_rready	: in std_logic
	);
end heartbeat_v1_0;

architecture arch_imp of heartbeat_v1_0 is

    signal hb_int_counter : integer := 0;
    signal hb_ext_counter : integer := 0;
    signal int_hb_output : std_logic := '0';

	-- component declaration
	component heartbeat_v1_0_HB_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component heartbeat_v1_0_HB_AXI;

begin

-- Instantiation of Axi Bus Interface HB_AXI
heartbeat_v1_0_HB_AXI_inst : heartbeat_v1_0_HB_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_HB_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_HB_AXI_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> hb_axi_aclk,
		S_AXI_ARESETN	=> hb_axi_aresetn,
		S_AXI_AWADDR	=> hb_axi_awaddr,
		S_AXI_AWPROT	=> hb_axi_awprot,
		S_AXI_AWVALID	=> hb_axi_awvalid,
		S_AXI_AWREADY	=> hb_axi_awready,
		S_AXI_WDATA	=> hb_axi_wdata,
		S_AXI_WSTRB	=> hb_axi_wstrb,
		S_AXI_WVALID	=> hb_axi_wvalid,
		S_AXI_WREADY	=> hb_axi_wready,
		S_AXI_BRESP	=> hb_axi_bresp,
		S_AXI_BVALID	=> hb_axi_bvalid,
		S_AXI_BREADY	=> hb_axi_bready,
		S_AXI_ARADDR	=> hb_axi_araddr,
		S_AXI_ARPROT	=> hb_axi_arprot,
		S_AXI_ARVALID	=> hb_axi_arvalid,
		S_AXI_ARREADY	=> hb_axi_arready,
		S_AXI_RDATA	=> hb_axi_rdata,
		S_AXI_RRESP	=> hb_axi_rresp,
		S_AXI_RVALID	=> hb_axi_rvalid,
		S_AXI_RREADY	=> hb_axi_rready
	);

	-- Add user logic here
	
	process (hb_clock)
    begin
      if rising_edge(hb_clock) then
        -- The outer loop will tick at 125KHz
        if(hb_ext_counter >= 125000) then
          hb_ext_counter <= 0;
          
          -- For a 1 second timer, the inner loop will tick at 1KHz
          if(hb_int_counter >= 1000) then
            hb_int_counter <= 0;

            int_hb_output <= not int_hb_output;
          else
            hb_int_counter <= hb_int_counter + 1;
          end if; -- end if hb_int_counter else
        else
          hb_ext_counter <= hb_ext_counter + 1;
        end if;
      end if; -- end if rising edge
    end process;


    -- make sure to assign the actual output    
    hb_output <= int_hb_output;
    
	-- User logic ends

end arch_imp;
