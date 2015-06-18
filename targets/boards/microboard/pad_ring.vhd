-- Copyright (c) 2015, Smart Energy Instruments Inc.
-- All rights reserved.  For details, see COPYING in the top level directory.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.config.all;
use work.cpu2j0_pack.all;
use work.data_bus_pack.all;
use work.ddr_pack.all;
library unisim;
use unisim.vcomponents.all;
entity pad_ring is
    port (
        pin_clock_y3 : in std_logic;
        pin_led1 : out std_logic;
        pin_led2 : out std_logic;
        pin_led3 : out std_logic;
        pin_led4 : out std_logic;
        pin_lpddr_a0 : out std_logic;
        pin_lpddr_a1 : out std_logic;
        pin_lpddr_a2 : out std_logic;
        pin_lpddr_a3 : out std_logic;
        pin_lpddr_a4 : out std_logic;
        pin_lpddr_a5 : out std_logic;
        pin_lpddr_a6 : out std_logic;
        pin_lpddr_a7 : out std_logic;
        pin_lpddr_a8 : out std_logic;
        pin_lpddr_a9 : out std_logic;
        pin_lpddr_a10 : out std_logic;
        pin_lpddr_a11 : out std_logic;
        pin_lpddr_a12 : out std_logic;
        pin_lpddr_ba0 : out std_logic;
        pin_lpddr_ba1 : out std_logic;
        pin_lpddr_cas : out std_logic;
        pin_lpddr_ck_n : out std_logic;
        pin_lpddr_ck_p : out std_logic;
        pin_lpddr_cke : out std_logic;
        pin_lpddr_dq0 : inout std_logic;
        pin_lpddr_dq1 : inout std_logic;
        pin_lpddr_dq2 : inout std_logic;
        pin_lpddr_dq3 : inout std_logic;
        pin_lpddr_dq4 : inout std_logic;
        pin_lpddr_dq5 : inout std_logic;
        pin_lpddr_dq6 : inout std_logic;
        pin_lpddr_dq7 : inout std_logic;
        pin_lpddr_dq8 : inout std_logic;
        pin_lpddr_dq9 : inout std_logic;
        pin_lpddr_dq10 : inout std_logic;
        pin_lpddr_dq11 : inout std_logic;
        pin_lpddr_dq12 : inout std_logic;
        pin_lpddr_dq13 : inout std_logic;
        pin_lpddr_dq14 : inout std_logic;
        pin_lpddr_dq15 : inout std_logic;
        pin_lpddr_ldm : out std_logic;
        pin_lpddr_ldqs : inout std_logic;
        pin_lpddr_ras : out std_logic;
        pin_lpddr_udm : out std_logic;
        pin_lpddr_udqs : inout std_logic;
        pin_lpddr_we : out std_logic;
        pin_pmod1_p10 : in std_logic;
        pin_pmod1_p2 : out std_logic;
        pin_pmod1_p8 : out std_logic;
        pin_pmod1_p9 : out std_logic;
        pin_rxd : in std_logic;
        pin_spi_cs : out std_logic;
        pin_txd : out std_logic
    );
end;
architecture impl of pad_ring is
    attribute loc : string;
    attribute pullup : string;
    -- Pin attributes
    attribute loc    of pin_clock_y3   : signal is "c10";
    attribute loc    of pin_led1       : signal is "p4";
    attribute loc    of pin_led2       : signal is "l6";
    attribute loc    of pin_led3       : signal is "f5";
    attribute loc    of pin_led4       : signal is "c2";
    attribute loc    of pin_lpddr_a0   : signal is "j7";
    attribute loc    of pin_lpddr_a1   : signal is "j6";
    attribute loc    of pin_lpddr_a2   : signal is "h5";
    attribute loc    of pin_lpddr_a3   : signal is "l7";
    attribute loc    of pin_lpddr_a4   : signal is "f3";
    attribute loc    of pin_lpddr_a5   : signal is "h4";
    attribute loc    of pin_lpddr_a6   : signal is "h3";
    attribute loc    of pin_lpddr_a7   : signal is "h6";
    attribute loc    of pin_lpddr_a8   : signal is "d2";
    attribute loc    of pin_lpddr_a9   : signal is "d1";
    attribute loc    of pin_lpddr_a10  : signal is "f4";
    attribute loc    of pin_lpddr_a11  : signal is "d3";
    attribute loc    of pin_lpddr_a12  : signal is "g6";
    attribute loc    of pin_lpddr_ba0  : signal is "f2";
    attribute loc    of pin_lpddr_ba1  : signal is "f1";
    attribute loc    of pin_lpddr_cas  : signal is "k5";
    attribute loc    of pin_lpddr_ck_n : signal is "g1";
    attribute loc    of pin_lpddr_ck_p : signal is "g3";
    attribute loc    of pin_lpddr_cke  : signal is "h7";
    attribute loc    of pin_lpddr_dq0  : signal is "l2";
    attribute loc    of pin_lpddr_dq1  : signal is "l1";
    attribute loc    of pin_lpddr_dq2  : signal is "k2";
    attribute loc    of pin_lpddr_dq3  : signal is "k1";
    attribute loc    of pin_lpddr_dq4  : signal is "h2";
    attribute loc    of pin_lpddr_dq5  : signal is "h1";
    attribute loc    of pin_lpddr_dq6  : signal is "j3";
    attribute loc    of pin_lpddr_dq7  : signal is "j1";
    attribute loc    of pin_lpddr_dq8  : signal is "m3";
    attribute loc    of pin_lpddr_dq9  : signal is "m1";
    attribute loc    of pin_lpddr_dq10 : signal is "n2";
    attribute loc    of pin_lpddr_dq11 : signal is "n1";
    attribute loc    of pin_lpddr_dq12 : signal is "t2";
    attribute loc    of pin_lpddr_dq13 : signal is "t1";
    attribute loc    of pin_lpddr_dq14 : signal is "u2";
    attribute loc    of pin_lpddr_dq15 : signal is "u1";
    attribute loc    of pin_lpddr_ldm  : signal is "k3";
    attribute loc    of pin_lpddr_ldqs : signal is "l4";
    attribute loc    of pin_lpddr_ras  : signal is "l5";
    attribute loc    of pin_lpddr_udm  : signal is "k4";
    attribute loc    of pin_lpddr_udqs : signal is "p2";
    attribute loc    of pin_lpddr_we   : signal is "e3";
    attribute loc    of pin_pmod1_p10  : signal is "d18";
    attribute pullup of pin_pmod1_p10  : signal is "true";
    attribute loc    of pin_pmod1_p2   : signal is "f16";
    attribute loc    of pin_pmod1_p8   : signal is "g14";
    attribute loc    of pin_pmod1_p9   : signal is "d17";
    attribute loc    of pin_rxd        : signal is "r7";
    attribute loc    of pin_spi_cs     : signal is "v3";
    attribute loc    of pin_txd        : signal is "t7";
    signal clk31_todcm : std_logic;
    signal clk_sys : std_logic;
    signal clk_sys2x : std_logic;
    signal clk_sys_90 : std_logic;
    signal clock_locked : std_logic;
    signal clock_y3 : std_logic;
    signal ddr_clk : std_logic;
    signal ddr_sd_ctrl : sd_ctrl_t;
    signal ddr_sd_data_i : sd_data_i_t;
    signal ddr_sd_data_o : sd_data_o_t;
    signal dr_data_i : dr_data_i_t;
    signal dr_data_o : dr_data_o_t;
    signal pi : std_logic_vector(31 downto 0);
    signal pll_rst : std_logic;
    signal po : std_logic_vector(31 downto 0);
    signal reset : std_logic;
    signal spi_clk : std_logic;
    signal spi_cs : std_logic_vector(1 downto 0);
    signal spi_miso : std_logic;
    signal spi_mosi : std_logic;
    signal uart_rx : std_logic;
    signal uart_tx : std_logic;
begin
    soc : entity work.soc(impl)
        port map (
            clk_sys => clk_sys,
            clk_sys2x => clk_sys2x,
            clk_sys_90 => clk_sys_90,
            clock_locked => clock_locked,
            ddr_sd_ctrl => ddr_sd_ctrl,
            ddr_sd_data_i => ddr_sd_data_i,
            ddr_sd_data_o => ddr_sd_data_o,
            pi => pi,
            po => po,
            reset => reset,
            spi_clk => spi_clk,
            spi_cs => spi_cs,
            spi_miso => spi_miso,
            spi_mosi => spi_mosi,
            uart_rx => uart_rx,
            uart_tx => uart_tx
        );
    ddr_clkgen : entity work.ddr_clkgen(interface)
        port map (
            clk0_o => clk_sys,
            clk125_o => open,
            clk180_o => open,
            clk2x_o => clk_sys2x,
            clk90_o => clk_sys_90,
            clk_i => clk31_todcm,
            locked => clock_locked,
            reset_i => pll_rst
        );
    ddr_iocells : entity work.ddr_iocells(interface)
        port map (
            ckpo => ddr_clk,
            ddr_clk0 => clk_sys,
            ddr_clk90 => clk_sys_90,
            dr_data_i => dr_data_i,
            dr_data_o => dr_data_o,
            reset => reset,
            sd_data_i => ddr_sd_data_i,
            sd_data_o => ddr_sd_data_o
        );
    pll_250 : entity work.pll_250(xilinx)
        port map (
            clk => clock_y3,
            clk250 => open,
            clk31 => clk31_todcm,
            clk_0 => open,
            clk_180 => open,
            clk_270 => open,
            clk_90 => open,
            locked => open,
            reset_o => pll_rst
        );
    reset_gen : entity work.reset_gen(arch)
        port map (
            clock_locked => clock_locked,
            reset => reset
        );
    -- led
    pi(0) <= po(0);
    -- led
    pi(1) <= po(1);
    -- led
    pi(2) <= po(2);
    -- led
    pi(3) <= po(3);
    pi(5) <= '0';
    pi(6) <= '0';
    pi(7) <= '0';
    pi(8) <= '0';
    pi(9) <= '0';
    pi(10) <= '0';
    pi(11) <= '0';
    pi(12) <= '0';
    pi(13) <= '0';
    pi(14) <= '0';
    pi(15) <= '0';
    pi(16) <= '0';
    pi(17) <= '0';
    pi(18) <= '0';
    pi(19) <= '0';
    pi(20) <= '0';
    pi(21) <= '0';
    pi(22) <= '0';
    pi(23) <= '0';
    pi(24) <= '0';
    pi(25) <= '0';
    pi(26) <= '0';
    pi(27) <= '0';
    pi(28) <= '0';
    pi(29) <= '0';
    pi(30) <= '0';
    pi(31) <= '0';
    clock_y3 <= pin_clock_y3;
    obuf_led1 : OBUF
        generic map (
            IOSTANDARD => "LVCMOS18"
        )
        port map (
            I => po(1),
            O => pin_led1
        );
    obuf_led2 : OBUF
        generic map (
            IOSTANDARD => "LVCMOS18"
        )
        port map (
            I => po(2),
            O => pin_led2
        );
    obuf_led3 : OBUF
        generic map (
            IOSTANDARD => "LVCMOS18"
        )
        port map (
            I => po(3),
            O => pin_led3
        );
    obuf_led4 : OBUF
        generic map (
            IOSTANDARD => "LVCMOS18"
        )
        port map (
            I => po(4),
            O => pin_led4
        );
    obuf_lpddr_a0 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(0),
            O => pin_lpddr_a0
        );
    obuf_lpddr_a1 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(1),
            O => pin_lpddr_a1
        );
    obuf_lpddr_a2 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(2),
            O => pin_lpddr_a2
        );
    obuf_lpddr_a3 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(3),
            O => pin_lpddr_a3
        );
    obuf_lpddr_a4 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(4),
            O => pin_lpddr_a4
        );
    obuf_lpddr_a5 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(5),
            O => pin_lpddr_a5
        );
    obuf_lpddr_a6 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(6),
            O => pin_lpddr_a6
        );
    obuf_lpddr_a7 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(7),
            O => pin_lpddr_a7
        );
    obuf_lpddr_a8 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(8),
            O => pin_lpddr_a8
        );
    obuf_lpddr_a9 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(9),
            O => pin_lpddr_a9
        );
    obuf_lpddr_a10 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(10),
            O => pin_lpddr_a10
        );
    obuf_lpddr_a11 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(11),
            O => pin_lpddr_a11
        );
    obuf_lpddr_a12 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.a(12),
            O => pin_lpddr_a12
        );
    obuf_lpddr_ba0 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.ba(0),
            O => pin_lpddr_ba0
        );
    obuf_lpddr_ba1 : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.ba(1),
            O => pin_lpddr_ba1
        );
    obuf_lpddr_cas : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.cas,
            O => pin_lpddr_cas
        );
    obuf_lpddr_cke : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.cke,
            O => pin_lpddr_cke
        );
    iobuf_lpddr_dq0 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(0),
            T => dr_data_o.dq_outen(0),
            O => dr_data_i.dqi(0),
            IO => pin_lpddr_dq0
        );
    iobuf_lpddr_dq1 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(1),
            T => dr_data_o.dq_outen(1),
            O => dr_data_i.dqi(1),
            IO => pin_lpddr_dq1
        );
    iobuf_lpddr_dq2 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(2),
            T => dr_data_o.dq_outen(2),
            O => dr_data_i.dqi(2),
            IO => pin_lpddr_dq2
        );
    iobuf_lpddr_dq3 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(3),
            T => dr_data_o.dq_outen(3),
            O => dr_data_i.dqi(3),
            IO => pin_lpddr_dq3
        );
    iobuf_lpddr_dq4 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(4),
            T => dr_data_o.dq_outen(4),
            O => dr_data_i.dqi(4),
            IO => pin_lpddr_dq4
        );
    iobuf_lpddr_dq5 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(5),
            T => dr_data_o.dq_outen(5),
            O => dr_data_i.dqi(5),
            IO => pin_lpddr_dq5
        );
    iobuf_lpddr_dq6 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(6),
            T => dr_data_o.dq_outen(6),
            O => dr_data_i.dqi(6),
            IO => pin_lpddr_dq6
        );
    iobuf_lpddr_dq7 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(7),
            T => dr_data_o.dq_outen(7),
            O => dr_data_i.dqi(7),
            IO => pin_lpddr_dq7
        );
    iobuf_lpddr_dq8 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(8),
            T => dr_data_o.dq_outen(8),
            O => dr_data_i.dqi(8),
            IO => pin_lpddr_dq8
        );
    iobuf_lpddr_dq9 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(9),
            T => dr_data_o.dq_outen(9),
            O => dr_data_i.dqi(9),
            IO => pin_lpddr_dq9
        );
    iobuf_lpddr_dq10 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(10),
            T => dr_data_o.dq_outen(10),
            O => dr_data_i.dqi(10),
            IO => pin_lpddr_dq10
        );
    iobuf_lpddr_dq11 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(11),
            T => dr_data_o.dq_outen(11),
            O => dr_data_i.dqi(11),
            IO => pin_lpddr_dq11
        );
    iobuf_lpddr_dq12 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(12),
            T => dr_data_o.dq_outen(12),
            O => dr_data_i.dqi(12),
            IO => pin_lpddr_dq12
        );
    iobuf_lpddr_dq13 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(13),
            T => dr_data_o.dq_outen(13),
            O => dr_data_i.dqi(13),
            IO => pin_lpddr_dq13
        );
    iobuf_lpddr_dq14 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(14),
            T => dr_data_o.dq_outen(14),
            O => dr_data_i.dqi(14),
            IO => pin_lpddr_dq14
        );
    iobuf_lpddr_dq15 : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqo(15),
            T => dr_data_o.dq_outen(15),
            O => dr_data_i.dqi(15),
            IO => pin_lpddr_dq15
        );
    obuft_lpddr_ldm : OBUFT
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dmo(0),
            T => dr_data_o.dq_outen(16),
            O => pin_lpddr_ldm
        );
    iobuf_lpddr_ldqs : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqso(0),
            T => dr_data_o.dqs_outen(0),
            O => dr_data_i.dqsi(0),
            IO => pin_lpddr_ldqs
        );
    obuf_lpddr_ras : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.ras,
            O => pin_lpddr_ras
        );
    obuft_lpddr_udm : OBUFT
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dmo(1),
            T => dr_data_o.dq_outen(17),
            O => pin_lpddr_udm
        );
    iobuf_lpddr_udqs : IOBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => dr_data_o.dqso(1),
            T => dr_data_o.dqs_outen(1),
            O => dr_data_i.dqsi(1),
            IO => pin_lpddr_udqs
        );
    obuf_lpddr_we : OBUF
        generic map (
            IOSTANDARD => "MOBILE_DDR"
        )
        port map (
            I => ddr_sd_ctrl.we,
            O => pin_lpddr_we
        );
    ibuf_pmod1_p10 : IBUF
        generic map (
            IOSTANDARD => "LVCMOS25"
        )
        port map (
            I => pin_pmod1_p10,
            O => spi_miso
        );
    obuf_pmod1_p2 : OBUF
        generic map (
            IOSTANDARD => "LVCMOS25"
        )
        port map (
            I => spi_mosi,
            O => pin_pmod1_p2
        );
    obuf_pmod1_p8 : OBUF
        generic map (
            IOSTANDARD => "LVCMOS25"
        )
        port map (
            I => spi_cs(0),
            O => pin_pmod1_p8
        );
    obuf_pmod1_p9 : OBUF
        generic map (
            IOSTANDARD => "LVCMOS25"
        )
        port map (
            I => spi_clk,
            O => pin_pmod1_p9
        );
    ibuf_rxd : IBUF
        generic map (
            IOSTANDARD => "LVCMOS33"
        )
        port map (
            I => pin_rxd,
            O => uart_rx
        );
    obuf_spi_cs : OBUF
        generic map (
            IOSTANDARD => "LVCMOS33"
        )
        port map (
            I => '1',
            O => pin_spi_cs
        );
    obuf_txd : OBUF
        generic map (
            IOSTANDARD => "LVCMOS33"
        )
        port map (
            I => uart_tx,
            O => pin_txd
        );
    obufds_lpddr_ck_p_lpddr_ck_n : OBUFDS
        generic map (
            IOSTANDARD => "DIFF_MOBILE_DDR"
        )
        port map (
            I => ddr_clk,
            O => pin_lpddr_ck_p,
            OB => pin_lpddr_ck_n
        );
end;
