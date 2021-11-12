// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0
`define MPRJ_IO_PADS 38

module user_proj_example #(parameter BITS = 32) (
    `ifdef USE_POWER_PINS
    inout                      vccd1      , // User area 1 1.8V supply
    inout                      vssd1      , // User area 1 digital ground
    `endif
    // Wishbone Slave ports (WB MI A)
    input                      wb_clk_i   ,
    input                      wb_rst_i   ,
    input                      wbs_stb_i  ,
    input                      wbs_cyc_i  ,
    input                      wbs_we_i   ,
    input  [              3:0] wbs_sel_i  ,
    input  [             31:0] wbs_dat_i  ,
    input  [             31:0] wbs_adr_i  ,
    output                     wbs_ack_o  ,
    output [             31:0] wbs_dat_o  ,
    // Logic Analyzer Signals
    input  [            127:0] la_data_in ,
    output [            127:0] la_data_out,
    input  [            127:0] la_oenb    ,
    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in      ,
    output [`MPRJ_IO_PADS-1:0] io_out     ,
    output [`MPRJ_IO_PADS-1:0] io_oeb     ,
    // IRQ
    output [              2:0] irq        ,
    //output                     clk        ,
    output                     csb0       ,
    output                     web0       ,
    // output                     web2       ,
    output [             31:0] din0       ,
    input  [             31:0] dout0      ,
    output                     csb1       ,
    // output                     csb2       ,
    // output                     csb3       ,
    input  [             31:0] dout1      
    // input  [             31:0] dout2      ,
    // input  [             31:0] dout3      
);

    // WB Signals 
    wire clk;
    wire rst;
    
    wire [`MPRJ_IO_PADS-1:0] io_in;
    wire [`MPRJ_IO_PADS-1:0] io_out;
    wire [`MPRJ_IO_PADS-1:0] io_oeb;

    wire valid;
    wire [3:0] wstrb;
    wire [31:0] la_write;

    // WB ACK 
    reg ready;
    always @(posedge clk) begin : proc_
        if(rst) begin
            ready <= 0;
        end else begin
            ready <= 0;
            if (~ready & (we | re))
                ready <= 1;
        end
    end
    assign wbs_ack_o = ready;


    wire we;
    wire re;
    assign we = valid && wbs_we_i;
    assign re = valid && ~wbs_we_i;

    assign csb0 = ~((we | re) & (wbs_adr_i[31:20] == 12'h300));
    assign csb1 = ~(re  & (wbs_adr_i[31:20] == 12'h301));
    // assign csb2 = ~((we | re) & (wbs_adr_i[31:20] == 12'h302));
    // assign csb3 = ~(re  & (wbs_adr_i[31:20] == 12'h303));

    assign web0 = ~(we & (wbs_adr_i[31:20] == 12'h300));
    // assign web2 = ~(we & (wbs_adr_i[31:20] == 12'h302));

    //assign wmask0 = 4'b1111;

    assign din0 = wbs_dat_i;

    wire write_io;
    reg [37:0] io_int;
    reg io_index;
    assign write_io = (we && (wbs_adr_i == 32'h30800000));
    always @(posedge clk) begin
        if(wb_rst_i) begin
            io_int <= {38{1'b0}};
            io_index <= 0;
        end else if(write_io && ready) begin
            io_int[37:32] <= {6{io_index}};
            io_int[31:0] <= wbs_dat_i;
            io_index <= ~io_index;
        end
    end

    reg [31:0] o_data;
    always @(*) begin
        case (wbs_adr_i[31:20])
            12'h300: o_data = dout0;
            12'h301: o_data = dout1;
            // 12'h302: o_data = dout2;
            // 12'h303: o_data = dout3;
            default : o_data = 32'h00000000;
        endcase
    end

    // WB MI A
    assign valid = wbs_cyc_i && wbs_stb_i; 
    assign wstrb = wbs_sel_i & {4{wbs_we_i}};
    assign wbs_dat_o = o_data;

    // IO
    assign io_out = io_int;
    assign io_oeb = {(`MPRJ_IO_PADS-1){rst}};

    // IRQ
    assign irq = 3'b000;    // Unused

    // LA
    //assign la_data_out = {{(127-BITS){1'b0}}, count};

    //TODOOOOOOO
    //assign la_data_out = {wbs_adr_i, wbs_dat_i, io_int, {(64-38){1'b0}}};
    assign la_data_out = {(128){1'b0}};
    // Assuming LA probes [63:32] are for controlling the count register  
    assign la_write = ~la_oenb[63:32] & ~{BITS{valid}};
    // Assuming LA probes [65:64] are for controlling the count clk & reset  
    assign clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
    assign rst = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;


endmodule
`default_nettype wire
