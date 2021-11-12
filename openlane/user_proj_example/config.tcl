set script_dir [file dirname [file normalize [info script]]]

########################################################################################
# Setup
########################################################################################
set ::env(PDK) "sky130A"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

# User config
set ::env(DESIGN_NAME) user_proj_example

set ::env(VERILOG_FILES) "\
	$::env(CARAVEL_ROOT)/verilog/rtl/defines.v \
	$script_dir/../../verilog/rtl/user_proj_example.v "
	#$script_dir/../../verilog/rtl/dpram_gen.v

# set ::env(VERILOG_FILES_BLACKBOX) "\
# 	$script_dir/../../verilog/rtl/sky130_sram_1kbyte_1rw1r_32x256_8/sky130_sram_1kbyte_1rw1r_32x256_8.v"
# #$script_dir/../../verilog/rtl/openram_testchip.v

# set ::env(EXTRA_LEFS) "\
# 	$script_dir/../../lef/sky130_sram_1kbyte_1rw1r_32x256_8.lef"
# #	$script_dir/../../lef/openram_testchip.lef


# set ::env(EXTRA_GDS_FILES) "\
# 	$script_dir/../../gds/sky130_sram_1kbyte_1rw1r_32x256_8.gds"
# #	$script_dir/../../gds/openram_testchip.gds

set ::env(RESET_PORT) {wb_rst_i}



########################################################################################
# Timing
########################################################################################
set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_NET) "clk"
set ::env(CLOCK_PERIOD) "20"


########################################################################################
# Synthesis
########################################################################################
#set ::env(BASE_SDC_FILE) "$script_dir/user_proj_example.sdc"
# set ::env(SYNTH_CAP_LOAD) "33.5"
# set ::env(SYNTH_MAX_FANOUT) "4"
# set ::env(SYNTH_MAX_TRAN) 1

########################################################################################
# Floorplanning
########################################################################################
set ::env(DESIGN_IS_CORE) 0
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 250 250"
set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg
#set ::env(MACRO_PLACEMENT_CFG) $::env(DESIGN_DIR)/macro.cfg
set ::env(FP_PDN_IRDROP) 0

# set ::env(FP_PDN_MACROS) "\
# 	SRAM0 vccd1 vssd1
# 	"

########################################################################################
# Placement
########################################################################################

#set ::env(PL_BASIC_PLACEMENT) 1
set ::env(PL_TARGET_DENSITY) 0.3

########################################################################################
# Routing
########################################################################################

set ::env(GLB_RT_MAXLAYER) 5
set ::env(ROUTING_CORES) 24

########################################################################################
# CHECK ME
########################################################################################
# You can draw more power domains if you need to 
set ::env(VDD_NETS) [list {vccd1}]
set ::env(GND_NETS) [list {vssd1}]
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"
set ::env(DIODE_INSERTION_STRATEGY) 4
# set ::env(GLB_RT_MAX_DIODE_INS_ITERS) 50
# set ::env(GLB_RT_ANT_ITERS) 50
#set ::env(PL_RANDOM_GLB_PLACEMENT) 1
set ::env(USE_ARC_ANTENNA_CHECK) 0

########################################################################################
# Timing
########################################################################################

########################################################################################
# Timing
########################################################################################


########################################################################################
# EOF
########################################################################################
set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}



