read ASPIDA-CHIP.db

current_design ASPIDA_top

set_dont_touch processor false

ungroup processor

ungroup processor/DLX_sync

verilogout_no_tri = true
list verilogout_no_tri

write -h -f verilog -o ASPIDA-CHIP-Mapped.v
