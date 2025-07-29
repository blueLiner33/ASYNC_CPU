set sdc_version 1.3

current_design ASPIDA_top

set_max_transition 1 [current_design]
set_max_fanout 16 [current_design]

set_false_path -from [list reset_DLX_c_PAD reset_DLX_d_PAD memory_load_enable_PAD]
set_false_path -through [list sync1g2 sync2g2 sync1shift sync2shift delem_shift_reg]

set_dont_touch [list chain_inst sramlat_dmem sramlat_imem sync_ip_complete sync_im_complete sync_dp_complete sync_dm_complete sync_im_decup sync_dm_decup0 sync_dm_decup1 sync_dm_decup2 sync_dm_decup3 sync_dm_decup4 arb_im0 arb_im1]

set_dont_touch [list processor/Ctrl__IFinst___Regs_1 processor/Ctrl__IDinst___Regs_1 processor/Ctrl__EXinst___Regs_1 processor/Ctrl__MEMinst___Regs_1]

set_disable_timing chain_inst

# EFFECTIVE PERIOD of 8ns DEFINED #

create_clock -name global_g1 -period 8 -waveform {3 5} global_g1_PAD
create_clock -name global_g2 -period 8 -waveform {6 8} global_g2_PAD

# SHIFT CLOCK for LOADING/UNLOADING SRAMs #

create_clock -name shift_clk -period 10 shift_clk_PAD

# De-Synchronisation Latch Enables #

create_clock -name g1_IF_m -period 8 -waveform {3 5} processor/Ctrl__IFinst___Regs_1/en1
create_clock -name g2_IF_s -period 8 -waveform {6 8} processor/Ctrl__IFinst___Regs_1/en2

create_clock -name g1_ID_m -period 8 -waveform {3 5} processor/Ctrl__IDinst___Regs_1/en1
create_clock -name g2_ID_s -period 8 -waveform {6 8} processor/Ctrl__IDinst___Regs_1/en2

create_clock -name g1_EX_m -period 8 -waveform {3 5} processor/Ctrl__EXinst___Regs_1/en1
create_clock -name g2_EX_s -period 8 -waveform {6 8} processor/Ctrl__EXinst___Regs_1/en2

create_clock -name g1_MEM_m -period 8 -waveform {3 5} processor/Ctrl__MEMinst___Regs_1/en1
create_clock -name g2_MEM_s -period 8 -waveform {6 8} processor/Ctrl__MEMinst___Regs_1/en2

# Clock False Paths #

set_false_path -from shift_clk -to global_g1
set_false_path -from shift_clk -to global_g2
set_false_path -from global_g1 -to shift_clk
set_false_path -from global_g2 -to shift_clk
set_false_path -from shift_clk -to [list g1_IF_m g2_IF_s g1_EX_m g2_EX_s g1_MEM_m g2_MEM_s]
set_false_path -from [list g1_IF_m g2_IF_s g1_EX_m g2_EX_s g1_MEM_m g2_MEM_s] -to shift_clk
set_false_path -from global_g2 -to [list g1_IF_m g2_IF_s g1_EX_m g2_EX_s g1_MEM_m g2_MEM_s]
set_false_path -from [list g1_IF_m g2_IF_s g1_EX_m g2_EX_s g1_MEM_m g2_MEM_s] -to global_g2
set_false_path -from global_g1 -to [list g1_IF_m g2_IF_s g1_EX_m g2_EX_s g1_MEM_m g2_MEM_s]
set_false_path -from [list g1_IF_m g2_IF_s g1_EX_m g2_EX_s g1_MEM_m g2_MEM_s] -to global_g1

# Delay Elements #

# Timings are based on report_timing in Synopsys with:
# set_drive 3.111701 all_inputs()
# set_load 0.006109 all_outputs()
# on the individual matched_delay modules.

# Older timings in V0-V6 were based on SOC Encounter.

#set_max_delay -rise -from processor/Ctrl__IFinst___Regs_1/delay/in -to processor/Ctrl__IFinst___Regs_1/delay/out 6.43
set_max_delay -rise -from processor/Ctrl__IFinst___Regs_1/delay/in -to processor/Ctrl__IFinst___Regs_1/delay/out 1

#set_max_delay -rise -from processor/Ctrl__IFinst___Regs_1/delay/in -to processor/Ctrl__IFinst___Regs_1/delay/out 8.40 
#set_min_delay -rise -from processor/Ctrl__IFinst___Regs_1/delay/in -to processor/Ctrl__IFinst___Regs_1/delay/out 7.40

#set_max_delay -rise -from processor/Ctrl__IDinst___Regs_1/delay/in -to processor/Ctrl__IDinst___Regs_1/delay/out 7.03
set_max_delay -rise -from processor/Ctrl__IDinst___Regs_1/delay/in -to processor/Ctrl__IDinst___Regs_1/delay/out 1

#set_max_delay -rise -from processor/Ctrl__IDinst___Regs_1/delay/in -to processor/Ctrl__IDinst___Regs_1/delay/out 9.66
#set_min_delay -rise -from processor/Ctrl__IDinst___Regs_1/delay/in -to processor/Ctrl__IDinst___Regs_1/delay/out 8.66
 
#set_max_delay -rise -from processor/Ctrl__EXinst___Regs_1/delay/in -to processor/Ctrl__EXinst___Regs_1/delay/out 7.23
set_max_delay -rise -from processor/Ctrl__EXinst___Regs_1/delay/in -to processor/Ctrl__EXinst___Regs_1/delay/out 1

#set_max_delay -rise -from processor/Ctrl__EXinst___Regs_1/delay/in -to processor/Ctrl__EXinst___Regs_1/delay/out 9.88
#set_min_delay -rise -from processor/Ctrl__EXinst___Regs_1/delay/in -to processor/Ctrl__EXinst___Regs_1/delay/out 8.88

#set_max_delay -rise -from processor/Ctrl__MEMinst___Regs_1/delay/in -to processor/Ctrl__MEMinst___Regs_1/delay/out 1.92
set_max_delay -rise -from processor/Ctrl__MEMinst___Regs_1/delay/in -to processor/Ctrl__MEMinst___Regs_1/delay/out 1

#set_max_delay -rise -from processor/Ctrl__MEMinst___Regs_1/delay/in -to processor/Ctrl__MEMinst___Regs_1/delay/out 3.02
#set_min_delay -rise -from processor/Ctrl__MEMinst___Regs_1/delay/in -to processor/Ctrl__MEMinst___Regs_1/delay/out 2.02

#set_max_delay -rise -from sramlat_dmem/in -to sramlat_dmem/out 10.06
set_max_delay -rise -from sramlat_dmem/in -to sramlat_dmem/out 1

#set_max_delay -rise -from sramlat_imem/in -to sramlat_imem/out 10.06
set_max_delay -rise -from sramlat_imem/in -to sramlat_imem/out 1


