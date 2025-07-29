######################################################
#                                                    #
#  ASPIDA CHIP IO FILE				     #
#  128 Pin Package				     #
#                                                    #
######################################################

Version: 2

Spacing: 28.75

Pad: corner1 NW ulcnr_tie
Pad: corner2 SW llcnr_tie
Pad: corner3 NE urcnr_tie
Pad: corner4 SE lrcnr_tie

# 38 pads MAX on W Side
# 37 pads on W Side

Skip: 0

# DOWN -> UP #

Pad: vss_3 		W allvss # 38
Pad: vdd_3 		W allvdd # 37

Pad: reset_ctrl_pad_	 W # 35
Pad: stop_fetch_pad_     W # 34
Pad: ei_r_req_pad_	 W # 33
Pad: ei_data_inout_pad_0 W # 32
Pad: ei_data_inout_pad_1 W # 31
Pad: ei_data_inout_pad_2 W # 30
Pad: ei_data_inout_pad_3 W # 29
Pad: ei_data_inout_pad_4 W # 28
Pad: ei_data_inout_pad_5 W # 27
Pad: ei_data_inout_pad_6 W # 26
Pad: ei_data_inout_pad_7 W # 25
Pad: ei_r_ack_pad_	 W # 24
Pad: ei_c_req_pad_      W # 23
Pad: ei_c_we_pad_       W # 22
Pad: ei_c_addr_pad_0    W # 21

Pad: vss_2 		W allvss # 20
Pad: vdd_2 		W allvdd # 19

Pad: ei_c_addr_pad_1    W # 18
Pad: ei_c_addr_pad_2    W # 17
Pad: ei_c_addr_pad_3    W # 16
Pad: ei_c_addr_pad_4    W # 15
Pad: ei_c_addr_pad_5    W # 14
Pad: ei_c_addr_pad_6    W # 13
Pad: ei_c_addr_pad_7    W # 12
Pad: ei_c_addr_pad_8    W # 11
Pad: ei_c_addr_pad_9    W # 10
Pad: ei_c_addr_pad_10   W # 9
Pad: ei_c_ack_pad_      W # 8
Pad: memory_load_enable_pad_ W # 7
Pad: scan_in_pad_	W # 6
Pad: scan_out_pad_	W # 5
Pad: shift_clk_pad_	W # 4

Pad: vdd_1 		W allvdd # 3
Pad: vss_1 		W allvss # 2

Pad: read_pad_ 		W # 1

# 26 pads MAX on S Side
# 26 pads on S Side

Skip: 0

# LEFT -> RIGHT #

Pad: vss_4 S allvss # 39
Pad: vdd_4 S allvdd # 40

Pad: r_BC_pad_0    	S # 41
Pad: r_BC_pad_1    	S # 42
Pad: r_BC_pad_2    	S # 43
Pad: r_BC_pad_3    	S # 44
Pad: r_BC_pad_4    	S # 45
Pad: r_BC_ack_pad_ 	S # 46
Pad: c_BC_ack_pad_ 	S # 47
Pad: c_BC_pad_0    	S # 48
Pad: c_BC_pad_1    	S # 49
Pad: c_BC_pad_2    	S # 50
Pad: c_BC_pad_3    	S # 51
Pad: c_BC_pad_4    	S # 52
Pad: inst_ram_load_pad_ S # 53
Pad: del_scan_en_pad_   S # 54
Pad: del_scan_in_pad_   S # 55
Pad: reset_DLX_d_pad_   S # 56
Pad: reset_DLX_c_pad_   S # 57
Pad: sync_async_pad_    S # 58
Pad: int_pad_	        S # 59
Pad: test_si_DLX_pad_   S # 60
Pad: test_se_pad_       S # 61

Pad: vdd_5 		S allvdd # 62
Pad: vss_5 		S allvss # 63

Pad: test_so_DLX_pad_ 	S # 64

# 38 pads MAX on E Side
# 37 pads on E Side

Skip: 0

# DOWN -> UP #

Pad: wish_dat_io_pad_0  E # 65
Pad: wish_dat_io_pad_1  E # 66
Pad: wish_dat_io_pad_2  E # 67
Pad: wish_dat_io_pad_3  E # 68 
Pad: wish_dat_io_pad_4  E # 69
Pad: wish_dat_io_pad_5  E # 70
Pad: wish_dat_io_pad_6  E # 71
Pad: wish_dat_io_pad_7  E # 72
Pad: wish_dat_io_pad_8  E # 73 

Pad: vss_6 		E allvss # 74
Pad: vdd_6 		E allvdd # 75

Pad: wish_dat_io_pad_9  E # 76
Pad: wish_dat_io_pad_10 E # 77
Pad: wish_dat_io_pad_11 E # 78
Pad: wish_dat_io_pad_12 E # 79
Pad: wish_dat_io_pad_13 E # 80
Pad: wish_dat_io_pad_14 E # 81
Pad: wish_dat_io_pad_15 E # 82

Pad: vss_7 		E allvss # 83
Pad: vdd_7 		E allvdd # 84

Pad: wish_dat_io_pad_16 E # 85
Pad: wish_dat_io_pad_17 E # 86
Pad: wish_dat_io_pad_18 E # 87
Pad: wish_dat_io_pad_19 E # 88
Pad: wish_dat_io_pad_20 E # 89
Pad: wish_dat_io_pad_21 E # 90
Pad: wish_dat_io_pad_22 E # 91

Pad: vdd_8 		E allvdd # 92
Pad: vss_8 		E allvss # 93

Pad: wish_dat_io_pad_23 E # 94
Pad: wish_dat_io_pad_24 E # 95
Pad: wish_dat_io_pad_25 E # 96
Pad: freeze_pad_	E # 97
Pad: stuckAtVdd_pad_	E # 98

Pad: wish_adr_o_pad_9   E # 100
Pad: wish_adr_o_pad_10  E # 101
Pad: wish_adr_o_pad_11  E # 102

# 26 pads MAX on N Side
# 26 pads on N Side

Skip: 0

# LEFT -> RIGHT #

Pad: wish_dat_io_pad_26 N # 128
Pad: wish_dat_io_pad_27 N # 127

Pad: vss_10             N allvss # 126
Pad: vdd_10             N allvdd # 125

Pad: wish_dat_io_pad_28 N # 124
Pad: wish_dat_io_pad_29 N # 123
Pad: wish_dat_io_pad_30 N # 122
Pad: wish_dat_io_pad_31 N # 121
Pad: wish_ack_i_pad     N # 120
Pad: wish_clk_pad       N # 119
Pad: wish_stb_cyc_o_pad N # 118
Pad: wish_we_o_pad      N # 117
Pad: wish_adr_o_pad_0   N # 116
Pad: wish_adr_o_pad_1   N # 115
Pad: wish_adr_o_pad_2   N # 114
Pad: wish_adr_o_pad_3   N # 113
Pad: wish_adr_o_pad_4   N # 112
Pad: wish_adr_o_pad_5   N # 111
Pad: wish_adr_o_pad_6   N # 110
Pad: wish_adr_o_pad_7   N # 109
Pad: wish_adr_o_pad_8   N # 108
Pad: global_g1_pad_ 	N # 107
Pad: global_g2_pad_ 	N # 106
Pad: cli_pad_	    	N # 105

Pad: vdd_9 		N allvdd # 104
Pad: vss_9 		N allvss # 103
