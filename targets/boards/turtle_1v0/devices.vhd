-- ******************************************************************
-- ******************************************************************
-- ******************************************************************
-- This file is generated by soc_gen and will be overwritten next time
-- the tool is run. See soc_top/README for information on running soc_gen.
-- ******************************************************************
-- byte bus post-processing script (script Apr/2017) --
-- ******************************************************************
-- ******************************************************************
-- ******************************************************************
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.config.all;
use work.clk_config.all;
use work.cpu2j0_pack.all;
use work.data_bus_pack.all;
use work.ddrc_cnt_pack.all;
entity devices is
    port (
        cache01sel_ctrl_temp : out std_logic;
        clk_emac : in std_logic;
        clk_sys : in std_logic;
        cpu0_data_master_ack : in std_logic;
        cpu0_data_master_en : in std_logic;
        cpu0_ddr_ibus_o : in cpu_instruction_o_t;
        cpu0_event_i : out cpu_event_i_t;
        cpu0_event_o : in cpu_event_o_t;
        cpu0_periph_dbus_i : out cpu_data_i_t;
        cpu0_periph_dbus_o : in cpu_data_o_t;
        cpu1_data_master_ack : in std_logic;
        cpu1_data_master_en : in std_logic;
        cpu1_ddr_ibus_o : in cpu_instruction_o_t;
        cpu1_event_i : out cpu_event_i_t;
        cpu1_event_o : in cpu_event_o_t;
        cpu1_periph_dbus_i : out cpu_data_i_t;
        cpu1_periph_dbus_o : in cpu_data_o_t;
        dcache0_ctrl : out cache_ctrl_t;
        dcache1_ctrl : out cache_ctrl_t;
        ddr_status : in ddr_status_o_t;
        emac_phy_clk : out std_logic;
        emac_phy_crs_dv : in std_logic;
        emac_phy_rxd : in std_logic_vector(1 downto 0);
        emac_phy_rxerr : in std_logic;
        emac_phy_txd : out std_logic_vector(1 downto 0);
        emac_phy_txen : out std_logic;
        flash_clk : out std_logic;
        flash_cs : out std_logic_vector(1 downto 0);
        flash_miso : in std_logic;
        flash_mosi : out std_logic;
        icache0_ctrl : out cache_ctrl_t;
        icache1_ctrl : out cache_ctrl_t;
        pi : in std_logic_vector(31 downto 0);
        po : out std_logic_vector(31 downto 0);
        reset : in std_logic;
        uart0_rx : in std_logic;
        uart0_tx : out std_logic
    );
end;
architecture impl of devices is
    signal rtc_nsec : std_logic_vector(31 downto 0);
    signal rtc_sec : std_logic_vector(63 downto 0);
    signal cpu01_periph_dbus_i : cpu_data_i_t;
    signal cpu01_periph_dbus_o : cpu_data_o_t;
    type device_t is (NONE, DEV_AIC0, DEV_AIC1, DEV_CACHE_CTRL, DEV_EMAC, DEV_FLASH, DEV_GPIO, DEV_UART0);
    signal active_dev : device_t;
    type data_bus_i_t is array (device_t'left to device_t'right) of cpu_data_i_t;
    type data_bus_o_t is array (device_t'left to device_t'right) of cpu_data_o_t;
    signal devs_bus_i : data_bus_i_t;
    signal devs_bus_o : data_bus_o_t;
    function decode_address (addr : std_logic_vector(31 downto 0)) return device_t is
    begin
        -- Assumes addr(31 downto 28) = x"a".
        -- Address decoding closer to CPU checks those bits.
        if addr(27 downto 18) = "1011110011" then
            if addr(17 downto 11) = "0100000" then
                if addr(10) = '0' then
                    if addr(9) = '0' then
                        if addr(8) = '0' then
                            if addr(7) = '0' then
                                if addr(6) = '0' then
                                    -- ABCD0000-ABCD000F
                                    return DEV_GPIO;
                                else
                                    -- ABCD0040-ABCD0047
                                    return DEV_FLASH;
                                end if;
                            else
                                -- ABCD00C0-ABCD00FF
                                return DEV_CACHE_CTRL;
                            end if;
                        else
                            -- ABCD0100-ABCD010F
                            return DEV_UART0;
                        end if;
                    else
                        -- ABCD0200-ABCD023F
                        return DEV_AIC0;
                    end if;
                else
                    -- ABCD0500-ABCD053F
                    return DEV_AIC1;
                end if;
            elsif addr(17) = '1' then
                -- ABCE0000-ABCE1FFF
                return DEV_EMAC;
            end if;
        end if;
        return NONE;
    end;
    signal irqs0 : std_logic_vector(7 downto 0) := (others => '0');
    signal irqs1 : std_logic_vector(7 downto 0) := (others => '0');
begin
    cpus_mux : entity work.multi_master_bus_muxff(a)
        port map (
            clk => clk_sys,
            rst => reset,
            m1_i => cpu0_periph_dbus_i,
            m1_o => cpu0_periph_dbus_o,
            m2_i => cpu1_periph_dbus_i,
            m2_o => cpu1_periph_dbus_o,
            slave_i => cpu01_periph_dbus_i,
            slave_o => cpu01_periph_dbus_o
        );
    -- multiplex data bus to and from devices
    active_dev <= decode_address(cpu01_periph_dbus_o.a);
    cpu01_periph_dbus_i.d <= devs_bus_i(active_dev).d;

    word_ack_gen : entity work.word_ack_gen ( impl )
      port map (
        adr                  => cpu01_periph_dbus_o.a,
        word_bus_en          => cpu01_periph_dbus_o.en,
        ack_thru_in_aic0     => devs_bus_i(DEV_AIC0).ack,
        ack_thru_in_aic1     => devs_bus_i(DEV_AIC1).ack,
        ack_thru_in_emac     => devs_bus_i(DEV_EMAC).ack,
        ack_thru_in_uart0    => devs_bus_i(DEV_UART0).ack,
        word_ack             => cpu01_periph_dbus_i.ack
    );
    bus_split : for dev in device_t'left to device_t'right generate
        devs_bus_o(dev) <= mask_data_o(cpu01_periph_dbus_o, to_bit(dev = active_dev));
    end generate;
    devs_bus_i(NONE) <= loopback_bus(devs_bus_o(NONE));
    -- Instantiate devices
    aic0 : entity work.aic(behav)
        generic map (
            c_busperiod => CFG_CLK_CPU_PERIOD_NS,
            rtc_sec_length34b => TRUE,
            vector_numbers => (x"11", x"12", x"00", x"14", x"15", x"00", x"00", x"00")
        )
        port map (
            back_i => cpu0_data_master_ack,
            bstb_i => cpu0_data_master_en,
            clk_bus => clk_sys,
            db_i => devs_bus_o(DEV_AIC0),
            db_o => devs_bus_i(DEV_AIC0),
            enmi_i => '1',
            event_i => cpu0_event_o,
            event_o => cpu0_event_i,
            irq_i => irqs0,
            reboot => open,
            rst_i => reset,
            rtc_nsec => rtc_nsec,
            rtc_sec => rtc_sec
        );
    aic1 : entity work.aic(behav)
        generic map (
            c_busperiod => CFG_CLK_CPU_PERIOD_NS,
            rtc_sec_length34b => TRUE,
            vector_numbers => (x"00", x"00", x"00", x"14", x"00", x"00", x"00", x"00")
        )
        port map (
            back_i => cpu1_data_master_ack,
            bstb_i => cpu1_data_master_en,
            clk_bus => clk_sys,
            db_i => devs_bus_o(DEV_AIC1),
            db_o => devs_bus_i(DEV_AIC1),
            enmi_i => '1',
            event_i => cpu1_event_o,
            event_o => cpu1_event_i,
            irq_i => irqs1,
            reboot => open,
            rst_i => reset,
            rtc_nsec => open,
            rtc_sec => open
        );
    cache_ctrl : entity work.icache_modereg(arch)
        port map (
            cache01sel_ctrl_temp => cache01sel_ctrl_temp,
            cache0_ctrl_dc => dcache0_ctrl,
            cache0_ctrl_ic => icache0_ctrl,
            cache1_ctrl_dc => dcache1_ctrl,
            cache1_ctrl_ic => icache1_ctrl,
            clk => clk_sys,
            cpu0_ddr_ibus_o => cpu0_ddr_ibus_o,
            cpu1_ddr_ibus_o => cpu1_ddr_ibus_o,
            db_i => devs_bus_o(DEV_CACHE_CTRL),
            db_o => devs_bus_i(DEV_CACHE_CTRL),
            ddr_status => ddr_status,
            int0 => irqs0(3),
            int1 => irqs1(3),
            rst => reset
        );
    emac : configuration work.eth_mac_rmii_fpga
        generic map (
            async_bridge_impl2 => TRUE,
            async_bus_bridge => FALSE,
            c_addr_width => 11,
            c_buswidth => 32,
            default_mac_addr => x"000000000000",
            insert_read_delay_ethrx => FALSE,
            insert_write_delay_ethrx => FALSE
        )
        port map (
            clk_bus => clk_sys,
            clk_emac => clk_emac,
            db_i => devs_bus_o(DEV_EMAC),
            db_o => devs_bus_i(DEV_EMAC),
            eth_intr => irqs0(0),
            phy_clk => emac_phy_clk,
            phy_crs_dv => emac_phy_crs_dv,
            phy_rxd => emac_phy_rxd,
            phy_rxerr => emac_phy_rxerr,
            phy_txd => emac_phy_txd,
            phy_txen => emac_phy_txen,
            reset => reset,
            rtc_nsec_i => x"00000000",
            rtc_sec_i => x"0000000000000000"
        );
    flash : entity work.spi2(arch)
        generic map (
            clk_freq => CFG_CLK_CPU_FREQ_HZ,
            num_cs => 2
        )
        port map (
            busy => open,
            clk => clk_sys,
            cpha => '0',
            cpol => '0',
            cs => flash_cs,
            db_i => devs_bus_o(DEV_FLASH),
            db_o => devs_bus_i(DEV_FLASH),
            miso => flash_miso,
            mosi => flash_mosi,
            rst => reset,
            spi_clk => flash_clk
        );
    gpio : entity work.pio(beh)
        port map (
            clk_bus => clk_sys,
            db_i => devs_bus_o(DEV_GPIO),
            db_o => devs_bus_i(DEV_GPIO),
            irq => irqs0(4),
            p_i => pi,
            p_o => po,
            reset => reset
        );
    uart0 : entity work.uartlitedb(arch)
        generic map (
            bps => 38400.0,
            fclk => CFG_CLK_CPU_FREQ_HZ,
            intcfg => 1
        )
        port map (
            clk => clk_sys,
            db_i => devs_bus_o(DEV_UART0),
            db_o => devs_bus_i(DEV_UART0),
            int => irqs0(1),
            rst => reset,
            rx => uart0_rx,
            tx => uart0_tx
        );
end;
