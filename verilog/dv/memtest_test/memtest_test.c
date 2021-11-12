/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

// This include is relative to $CARAVEL_PATH (see Makefile)
#include "verilog/dv/caravel/defs.h"
#include "verilog/dv/caravel/stub.c"

#define SRAM0_PORT0 0x30000000
#define SRAM0_PORT1 0x30100000
#define SRAM1_PORT0 0x30200000
#define SRAM1_PORT1 0x30300000
#define SET_IO 0x30800000
#define N 5

/*
	IO Test:
		- Configures MPRJ lower 8-IO pins as outputs
		- Observes counter value through the MPRJ lower 8 IO pins (in the testbench)
*/

void main()
{
	/* 
	IO Control Registers
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 3-bits | 1-bit | 1-bit | 1-bit  | 1-bit  | 1-bit | 1-bit   | 1-bit   | 1-bit | 1-bit | 1-bit   |

	Output: 0000_0110_0000_1110  (0x1808) = GPIO_MODE_USER_STD_OUTPUT
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 110    | 0     | 0     | 0      | 0      | 0     | 0       | 1       | 0     | 0     | 0       |
	
	 
	Input: 0000_0001_0000_1111 (0x0402) = GPIO_MODE_USER_STD_INPUT_NOPULL
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 001    | 0     | 0     | 0      | 0      | 0     | 0       | 0       | 0     | 1     | 0       |

	*/

	/* Set up the housekeeping SPI to be connected internally so	*/
	/* that external pin changes don't affect it.			*/

	reg_spimaster_config = 0xa002;	// Enable, prescaler = 2,
                                        // connect to housekeeping SPI

	reg_mprj_datah = 0x00000000;
    reg_mprj_datal = 0x00000000;

	// Connect the housekeeping SPI to the SPI master
	// so that the CSB line is not left floating.  This allows
	// all of the GPIO pins to be used for user functions.

	// Configure lower 8-IOs as user output
	// Observe counter value in the testbench
	// reg_mprj_io_0 =  GPIO_MODE_USER_STD_OUTPUT;
	// reg_mprj_io_1 =  GPIO_MODE_USER_STD_OUTPUT;
	// reg_mprj_io_2 =  GPIO_MODE_USER_STD_OUTPUT;
	// reg_mprj_io_3 =  GPIO_MODE_USER_STD_OUTPUT;
	// reg_mprj_io_4 =  GPIO_MODE_USER_STD_OUTPUT;
	// reg_mprj_io_5 =  GPIO_MODE_USER_STD_OUTPUT;
	// reg_mprj_io_6 =  GPIO_MODE_USER_STD_OUTPUT;
	// reg_mprj_io_7 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_0  =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_1  =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_2  =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_3  =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_4  =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_5  =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_6  =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_7  =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_8  =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_9  =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_10 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_11 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_12 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_13 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_14 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_15 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_16 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_17 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_18 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_19 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_20 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_21 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_22 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_23 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_24 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_25 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_26 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_27 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_28 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_29 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_30 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_31 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_32 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_33 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_34 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_35 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_36 =  GPIO_MODE_USER_STD_OUTPUT;
	reg_mprj_io_37 =  GPIO_MODE_USER_STD_OUTPUT;

	

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

	//reg_la2_oenb = reg_la2_iena = 0xFFFFFFFF;    // [95:64]

	int i, temp;
	volatile uint32_t *mem_ptr;
	volatile uint32_t *write_io_ptr;
	write_io_ptr = (uint32_t *) SET_IO;

	mem_ptr = (uint32_t *) SRAM0_PORT0;
	for (i = 0; i < N; ++i) {
		//Read
		//temp = (int) *cochlea_interface_32;
		
		//Write
		*mem_ptr = 10*i;
		
		//Increment Address
		mem_ptr = mem_ptr + 1;
	}
	*mem_ptr = 0xFFFFFFFF;

    mem_ptr = (uint32_t *) SRAM0_PORT0;
	for (i = 0; i < N+1; ++i) {
		//Read
		//temp = (int) *cochlea_interface_32;
		temp = (int) *mem_ptr;
		//reg_mprj_datal = temp;

		*write_io_ptr = temp;

		//Write Back
		//*mem_ptr = 10*(int) *mem_ptr;
		mem_ptr = mem_ptr + 1; 
	}

    mem_ptr = (uint32_t *) SRAM0_PORT1;
	for (i = 0; i < N+1; ++i) {
		//Read
		//temp = (int) *cochlea_interface_32;
		temp = (int) *mem_ptr;
		//reg_mprj_datal = temp;

		*write_io_ptr = temp;

		//Write Back
		//*mem_ptr = 10*(int) *mem_ptr;
		mem_ptr = mem_ptr + 1; 
	}

	// //SRAM 1
	// mem_ptr = (uint32_t *) SRAM1_PORT0;
	// for (i = 0; i < N; ++i) {
	// 	//Read
	// 	//temp = (int) *cochlea_interface_32;
		
	// 	//Write
	// 	*mem_ptr = 5*i;
		
	// 	//Increment Address
	// 	mem_ptr = mem_ptr + 1;
	// }
	// *mem_ptr = 0xFFFFFFFF;

 //    mem_ptr = (uint32_t *) SRAM1_PORT0;
	// for (i = 0; i < N+1; ++i) {
	// 	//Read
	// 	//temp = (int) *cochlea_interface_32;
	// 	temp = (int) *mem_ptr;
	// 	//reg_mprj_datal = temp;

	// 	*write_io_ptr = temp;

	// 	//Write Back
	// 	//*mem_ptr = 10*(int) *mem_ptr;
	// 	mem_ptr = mem_ptr + 1; 
	// }

 //    mem_ptr = (uint32_t *) SRAM1_PORT1;
	// for (i = 0; i < N+1; ++i) {
	// 	//Read
	// 	//temp = (int) *cochlea_interface_32;
	// 	temp = (int) *mem_ptr;
	// 	//reg_mprj_datal = temp;

	// 	*write_io_ptr = temp;

	// 	//Write Back
	// 	//*mem_ptr = 10*(int) *mem_ptr;
	// 	mem_ptr = mem_ptr + 1; 
	// }




}

