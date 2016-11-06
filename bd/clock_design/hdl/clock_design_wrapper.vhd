--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
--Date        : Sun Nov  6 15:12:10 2016
--Host        : devel-virt running 64-bit Ubuntu 16.04.1 LTS
--Command     : generate_target clock_design_wrapper.bd
--Design      : clock_design_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clock_design_wrapper is
  port (
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    clk : in STD_LOGIC;
    hb_led : out STD_LOGIC;
    panel_a : out STD_LOGIC;
    panel_b : out STD_LOGIC;
    panel_b0 : out STD_LOGIC;
    panel_b1 : out STD_LOGIC;
    panel_c : out STD_LOGIC;
    panel_d : out STD_LOGIC;
    panel_g0 : out STD_LOGIC;
    panel_g1 : out STD_LOGIC;
    panel_oe : out STD_LOGIC;
    panel_out_clk : out STD_LOGIC;
    panel_r0 : out STD_LOGIC;
    panel_r1 : out STD_LOGIC;
    panel_stb : out STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
end clock_design_wrapper;

architecture STRUCTURE of clock_design_wrapper is
  component clock_design is
  port (
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    hb_led : out STD_LOGIC;
    clk : in STD_LOGIC;
    panel_out_clk : out STD_LOGIC;
    panel_stb : out STD_LOGIC;
    panel_r0 : out STD_LOGIC;
    panel_oe : out STD_LOGIC;
    panel_r1 : out STD_LOGIC;
    panel_g0 : out STD_LOGIC;
    panel_g1 : out STD_LOGIC;
    panel_b0 : out STD_LOGIC;
    panel_b1 : out STD_LOGIC;
    panel_c : out STD_LOGIC;
    panel_b : out STD_LOGIC;
    panel_a : out STD_LOGIC;
    panel_d : out STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  end component clock_design;
begin
clock_design_i: component clock_design
     port map (
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      clk => clk,
      hb_led => hb_led,
      panel_a => panel_a,
      panel_b => panel_b,
      panel_b0 => panel_b0,
      panel_b1 => panel_b1,
      panel_c => panel_c,
      panel_d => panel_d,
      panel_g0 => panel_g0,
      panel_g1 => panel_g1,
      panel_oe => panel_oe,
      panel_out_clk => panel_out_clk,
      panel_r0 => panel_r0,
      panel_r1 => panel_r1,
      panel_stb => panel_stb,
      sw(2 downto 0) => sw(2 downto 0)
    );
end STRUCTURE;
