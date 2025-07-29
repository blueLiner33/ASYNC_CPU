read -f verilog {ASPIDA_top.v aspida_net.v DLX_syn.v}

current_design ASPIDA_top


set_dont_touch {DLX_sync_desync_with_ctrls processor aspida_net_core chain_inst sram_latency sramlat_* dff* sync* inbuf* iobuf* *PAD* *_pad* osc* ring_osc ring_osc_1 ring_osc_2 ring_osc_3 ring_osc_4 C_gate2 lc_semi_dec_master sync_ip_complete sync_dp_complete sync_im* sync_dm* mutex} true

set_dont_touch {memory_load_enable_pad_ scan_in_pad_ scan_out_pad_ shift_clk_pad_ read_pad_ inst_ram_load_pad_ del_scan_en_pad_ del_scan_in_pad_ reset_DLX_d_pad_ reset_DLX_c_pad_ sync_async_pad_ int_pad_ test_si_DLX_pad_ test_se_pad_ global_g1_pad_ global_g2_pad_ r_BC_pad_0 r_BC_pad_1 r_BC_pad_2 r_BC_pad_3 r_BC_pad_4 r_BC_ack_pad_ c_BC_ack_pad_ c_BC_pad_0 c_BC_pad_1 c_BC_pad_2 c_BC_pad_3 c_BC_pad_4 ei_c_req_pad_ ei_c_we_pad_ ei_c_addr_pad_0 ei_c_addr_pad_1 ei_c_addr_pad_2 ei_c_addr_pad_3 ei_c_addr_pad_4 ei_c_addr_pad_5 ei_c_addr_pad_6 ei_c_addr_pad_7 ei_c_addr_pad_8 ei_c_addr_pad_9 ei_c_addr_pad_10 ei_c_ack_pad_ ei_r_req_pad_ ei_data_inout_pad_0 ei_data_inout_pad_1 ei_data_inout_pad_2 ei_data_inout_pad_3 ei_data_inout_pad_4 ei_data_inout_pad_5 ei_data_inout_pad_6 ei_data_inout_pad_7 ei_r_ack_pad_ wish_ack_i_pad wish_clk_pad wish_stb_cyc_o_pad wish_we_o_pad wish_adr_o_pad_0 wish_adr_o_pad_1 wish_adr_o_pad_2 wish_adr_o_pad_3 wish_adr_o_pad_4 wish_adr_o_pad_5 wish_adr_o_pad_6 wish_adr_o_pad_7 wish_adr_o_pad_8 wish_adr_o_pad_9 wish_adr_o_pad_10 wish_adr_o_pad_11 wish_dat_io_pad_0 wish_dat_io_pad_1 wish_dat_io_pad_2 wish_dat_io_pad_3 wish_dat_io_pad_4 wish_dat_io_pad_5 wish_dat_io_pad_6 wish_dat_io_pad_7 wish_dat_io_pad_8 wish_dat_io_pad_9 wish_dat_io_pad_10 wish_dat_io_pad_11 wish_dat_io_pad_12 wish_dat_io_pad_13 wish_dat_io_pad_14 wish_dat_io_pad_15 wish_dat_io_pad_16 wish_dat_io_pad_17 wish_dat_io_pad_18 wish_dat_io_pad_19 wish_dat_io_pad_20 wish_dat_io_pad_21 wish_dat_io_pad_22 wish_dat_io_pad_23 wish_dat_io_pad_24 wish_dat_io_pad_25 wish_dat_io_pad_26 wish_dat_io_pad_27 wish_dat_io_pad_28 wish_dat_io_pad_29 wish_dat_io_pad_30 wish_dat_io_pad_31 cli_pad_ test_so_DLX_pad_ stuckAtVdd_pad_}



/* create_clock -name global_g1 -period 8 -waveform {3 5} global_g1 */
/* create_clock -name global_g2 -period 8 -waveform {6 8} global_g2 */
create_clock -period 10 shift_clk_PAD

set_false_path -from {reset_DLX_c_PAD reset_DLX_d_PAD use_chain_PAD memory_load_enable_PAD sync_async_PAD reset_ctrl_PAD STOP_FETCH_PAD}
set_false_path -through delem_shift_reg/*
set_false_path -through {sync1g2 sync2g2 sync1shift sync2shift}
set_false_path -through chain_inst/*
set_disable_timing chain_inst

compile -map_effort high

write -h -f db -o ASPIDA-CHIP.db

/* change_names -rules simple_names -hierarchy */

verilogout_no_tri = true
list verilogout_no_tri

write -h -f verilog -o ASPIDA-CHIP-Mapped.v
