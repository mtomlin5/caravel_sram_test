//`define USE_POWER_PINS
module dpram_gen (clk, we, re, addrA_i, addrB_i, dA_i, dA_o, dB_o);
	parameter addr_w=8;
	parameter data_w=18;
	parameter NUM_WMASKS = 4;

	`ifdef USE_POWER_PINS
	    inout vccd1;	// User area 1 1.8V supply
	    inout vssd1;	// User area 1 digital ground
	`endif
	input wire clk; 
	input wire we; 
	input wire re; 
	input wire [addr_w-1:0] addrA_i; 
	input wire [addr_w-1:0] addrB_i; 
	input wire [data_w-1:0] dA_i; 
	output wire [data_w-1:0] dA_o; 
	output wire [data_w-1:0] dB_o;

	wire csb0, web0;
	//assign csb0 = ~(we | re);
	assign csb0 = ~(we);
	//assign csb0 = 1'b0;
	assign web0 = ~we;

	wire csb1;
	assign csb1 = (~re);
	
	wire [NUM_WMASKS-1:0] wmask0;
	assign wmask0 = 4'b1111;

	wire [31:0] dout1, dout0, din0;
	assign din0 = {{14{1'b0}}, dA_i};
	assign dA_o = dout0[17:0];
	assign dB_o = dout1[17:0];

	generate
		if (addr_w == 9)
			sky130_sram_2kbyte_1rw1r_32x512_8 i_sky130_sram_2kbyte_1rw1r_32x512_8 (
				`ifdef USE_POWER_PINS
		            .vccd1(vccd1),    // User area 1 1.8V supply
		            .vssd1(vssd1),    // User area 1 digital ground
		        `endif
				.clk0  (clk    ),
				.csb0  (csb0   ),
				.web0  (web0   ),
				.wmask0(wmask0 ),
				.addr0 (addrA_i),
				.din0  (din0   ),
				.dout0 (dout0  ),
				.clk1  (clk    ),
				.csb1  (csb1   ),
				.addr1 (addrB_i),
				.dout1 (dout1  )
			);

		if (addr_w == 8)
			sky130_sram_1kbyte_1rw1r_32x256_8 i_sky130_sram_1kbyte_1rw1r_32x256_8 (
				`ifdef USE_POWER_PINS
		            .vccd1(vccd1),    // User area 1 1.8V supply
		            .vssd1(vssd1),    // User area 1 digital ground
		        `endif
				.clk0  (clk    ),
				.csb0  (csb0   ),
				.web0  (web0   ),
				.wmask0(wmask0 ),
				.addr0 (addrA_i),
				.din0  (din0   ),
				.dout0 (dout0  ),
				.clk1  (clk    ),
				.csb1  (csb1   ),
				.addr1 (addrB_i),
				.dout1 (dout1  )
			);

		if (addr_w == 7)
			sky130_sram_1kbyte_1rw1r_32x256_8 i_sky130_sram_1kbyte_1rw1r_32x256_8 (
				`ifdef USE_POWER_PINS
		            .vccd1(vccd1),    // User area 1 1.8V supply
		            .vssd1(vssd1),    // User area 1 digital ground
		        `endif.clk0  (clk    ),
				.csb0  (csb0   ),
				.web0  (web0   ),
				.wmask0(wmask0 ),
				.addr0 ({1'b0,addrA_i}),
				.din0  (din0   ),
				.dout0 (dout0  ),
				.clk1  (clk    ),
				.csb1  (csb1   ),
				.addr1 ({1'b0,addrB_i}),
				.dout1 (dout1  )
			);

		if (addr_w < 7)
			//localparam DEPTH = $pow(2,addr_w);
			ff_ram #(.DEPTH(64), .WIDTH(data_w), .WRITE_FILE(0)) i_ff_ram (
				.i_clk       (clk    ),
				.i_write_en  (we     ),
				.i_read_en   (re     ),
				.i_addr_read (addrB_i),
				.i_addr_write(addrA_i),
				.i_data      (dA_i   ),
				.o_data      (dB_o   )
			);

			
	endgenerate

	// always @(posedge clk) begin
	// 	$display("data_w : %d, \t addr_w : %d\n", data_w, addr_w);
	// end
endmodule