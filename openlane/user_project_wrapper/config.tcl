# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

# Base Configurations. Don't Touch
# section begin

set ::env(PDK) "sky130A"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

# YOU ARE NOT ALLOWED TO CHANGE ANY VARIABLES DEFINED IN THE FIXED WRAPPER CFGS 
source $::env(CARAVEL_ROOT)/openlane/user_project_wrapper_empty/fixed_wrapper_cfgs.tcl

# YOU CAN CHANGE ANY VARIABLES DEFINED IN THE DEFAULT WRAPPER CFGS BY OVERRIDING THEM IN THIS CONFIG.TCL
source $::env(CARAVEL_ROOT)/openlane/user_project_wrapper_empty/default_wrapper_cfgs.tcl

set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) user_project_wrapper
#section end

# User Configurations

## Source Verilog Files
set ::env(VERILOG_FILES) "\
	$::env(CARAVEL_ROOT)/verilog/rtl/defines.v \
	$script_dir/../../verilog/rtl/user_project_wrapper.v"

## Clock configurations
set ::env(CLOCK_PORT) "user_clock2"
set ::env(CLOCK_NET) "mprj.clk"

set ::env(CLOCK_PERIOD) "20"

## Internal Macros
### Macro PDN Connections
# set ::env(FP_PDN_MACRO_HOOKS) "\
# 	mprj vccd1 vssd1 \
# 	SRAM0 vccd1 vssd1 \
# 	SRAM1 vccd1 vssd1"
set ::env(FP_PDN_MACRO_HOOKS) "\
	mprj vccd1 vssd1 \
	SRAM0 vccd1 vssd1"

### Macro Placement
set ::env(MACRO_PLACEMENT_CFG) $script_dir/macro.cfg

### Black-box verilog and views
set ::env(VERILOG_FILES_BLACKBOX) "\
	$::env(CARAVEL_ROOT)/verilog/rtl/defines.v \
	$script_dir/../../verilog/rtl/user_proj_example.v \
	$script_dir/../../verilog/rtl/sky130_sram_1kbyte_1rw1r_32x256_8/sky130_sram_1kbyte_1rw1r_32x256_8.v \
	$script_dir/../../verilog/rtl/sky130_sram_2kbyte_1rw1r_32x512_8/sky130_sram_2kbyte_1rw1r_32x512_8.v"

set ::env(EXTRA_LEFS) "\
	$script_dir/../../lef/user_proj_example.lef
	$script_dir/../../lef/sky130_sram_1kbyte_1rw1r_32x256_8.lef \
	$script_dir/../../lef/sky130_sram_2kbyte_1rw1r_32x512_8.lef"

set ::env(EXTRA_GDS_FILES) "\
	$script_dir/../../gds/user_proj_example.gds \
	$script_dir/../../gds/sky130_sram_1kbyte_1rw1r_32x256_8.gds \
	$script_dir/../../gds/sky130_sram_2kbyte_1rw1r_32x512_8.gds"

set ::env(GLB_RT_MAXLAYER) 5

# set ::env(GLB_RT_OBS) "li1 2200.00 2410 2679.78 2807.5,  \
# 	               		met1 2200.00 2410 2679.78 2807.5, \
# 	               		met2 2200.00 2410 2679.78 2807.5, \
# 	              		met3 2200.00 2410 2679.78 2807.5, \
# 	              		met4 2200.00 2410 2679.78 2807.5, \
# 		       			met5 0 0 2920 3520 \
# 		       			li1 815 2410 1498.1 2826.53,  \
# 	               	   met1 815 2410 1498.1 2826.53, \
# 	               	   met2 815 2410 1498.1 2826.53, \
# 	              	   met3 815 2410 1498.1 2826.53, \
# 	              	   met4 815 2410 1498.1 2826.53"
set ::env(GLB_RT_OBS) "li1 2200.00 1200.00 2679.78 1597.5,  \
	               		met1 2200.00 1200.00 2679.78 1597.5, \
	               		met2 2200.00 1200.00 2679.78 1597.5, \
	              		met3 2200.00 1200.00 2679.78 1597.5, \
	              		met4 2200.00 1200.00 2679.78 1597.5, \
		       			met5 0 0 2920 3520"

# set ::env(GLB_RT_OBS) "li1 1175 840 1858 1256.5,  \
# 	               	   met1 1175 840 1858 1256.5, \
# 	               	   met2 1175 840 1858 1256.5, \
# 	              	   met3 1175 840 1858 1256.5, \
# 	              	   met4 1175 840 1858 1256.5, \
# 		       		   met5 0 0 2920 3520"
# set ::env(GLB_RT_OBS) "li1 2200.00 1200.00 2680 1597.7,  \
# 	               		met1 2200.00 1200.00 2680 1597.7, \
# 	               		met2 2200.00 1200.00 2680 1597.7, \
# 	              		met3 2200.00 1200.00 2680 1597.7, \
# 	              		met4 2200.00 1200.00 2680 1597.7, \
# 		       			met5 0 0 2920 3520"

# disable pdn check nodes becuase it hangs with multiple power domains.
# any issue with pdn connections will be flagged with LVS so it is not a critical check.
set ::env(FP_PDN_CHECK_NODES) 0

# The following is because there are no std cells in the example wrapper project.
set ::env(SYNTH_TOP_LEVEL) 1
set ::env(PL_RANDOM_GLB_PLACEMENT) 1

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 0
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

set ::env(FP_PDN_ENABLE_RAILS) 0

set ::env(DIODE_INSERTION_STRATEGY) 0
set ::env(FILL_INSERTION) 0
set ::env(TAP_DECAP_INSERTION) 0
set ::env(CLOCK_TREE_SYNTH) 0

set ::env(MAGIC_DRC_USE_GDS) 0
set ::env(ROUTING_CORES) 24
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"

## Riscduino
set ::env(DESIGN_IS_CORE) 1
set ::env(FP_PDN_CORE_RING) 1

set ::env(VDD_NETS) "vccd1 vccd2 vdda1 vdda2"
set ::env(GND_NETS) "vssd1 vssd2 vssa1 vssa2"