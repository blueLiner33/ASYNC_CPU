/*
Copyright 2019 Tomas Brabec

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Change log:
    2019, Mar.  - Created by Tomas Brabec. see-https://github.com/brabect1/sv_handshake_comps/blob/master/src/reqack_pipe_stage.sv
    2025, Jul.  - Translated to Verilog and modified by Jack Albers.
*/

module reqack_arbiter_two2one
#(
    parameter DWIDTH = 1
)
(
    input  prod0_req,
    output prod0_ack,
    input  [DWIDTH-1:0] prod0_dat,

    input  prod1_req,
    output prod1_ack,
    input  [DWIDTH-1:0] prod1_dat,

    output cons_req,
    input  cons_ack,
    output [DWIDTH-1:0] cons_dat,

    input  clk,
    input  rst_n
);

reg prod0_ack, prod1_ack;
reg cons_req;
reg [DWIDTH-1:0] cons_dat;

reg prod0_req_allow, prod1_req_allow;
reg prod0_req_accept, prod1_req_accept;
reg prod0_req_req_fall, prod1_req_req_fall;
reg prod0_req_pend, prod1_req_pend;
reg [1:0] sync_prod0_req_req, sync_prod1_req_req;
reg prod0_req_req_i, prod1_req_req_i;
reg prod0_req_req_d, prod1_req_req_d;

reg cons_ack_d;
reg cons_ack_fall;
reg [1:0] sync_cons_ack;
reg cons_req_clr;

reg prod_src_last;

// Synchronizers and edge detection
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        prod0_req_req_d <= 0;
        prod1_req_req_d <= 0;
        cons_ack_d      <= 0;
    end else begin
        prod0_req_req_d <= prod0_req_req_i;
        prod1_req_req_d <= prod1_req_req_i;
        cons_ack_d      <= sync_cons_ack[0];
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        sync_cons_ack <= 2'b00;
    else
        sync_cons_ack <= {cons_ack, sync_cons_ack[1]};
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        cons_dat <= 0;
    else if (prod0_req_accept)
        cons_dat <= prod0_dat;
    else if (prod1_req_accept)
        cons_dat <= prod1_dat;
end

assign cons_req_clr = cons_req & sync_cons_ack[0];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        cons_req <= 0;
    else if (prod0_req_accept | prod1_req_accept | cons_req_clr)
        cons_req <= prod0_req_accept | prod1_req_accept | (~cons_req_clr);
end

assign cons_ack_fall = cons_ack_d & ~sync_cons_ack[0];

assign prod0_req_req_i = sync_prod0_req_req[0] | prod0_req_pend;
assign prod0_req_req_fall = prod0_req_req_d & ~prod0_req_req_i;
assign prod0_req_accept = prod0_req_req_i & ~prod0_ack & prod0_req_allow;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        sync_prod0_req_req <= 2'b00;
    else
        sync_prod0_req_req <= {prod0_req, sync_prod0_req_req[1]};
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        prod0_ack <= 0;
    else if (prod0_req_accept | prod0_req_req_fall)
        prod0_ack <= prod0_req_accept | (~prod0_req_req_fall);
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        prod0_req_pend <= 0;
    else if (prod0_req_accept | cons_ack_fall)
        prod0_req_pend <= prod0_req_accept | (~cons_ack_fall);
end

assign prod1_req_req_i = sync_prod1_req_req[0] | prod1_req_pend;
assign prod1_req_req_fall = prod1_req_req_d & ~prod1_req_req_i;
assign prod1_req_accept = prod1_req_req_i & ~prod1_ack & prod1_req_allow;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        sync_prod1_req_req <= 2'b00;
    else
        sync_prod1_req_req <= {prod1_req, sync_prod1_req_req[1]};
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        prod1_ack <= 0;
    else if (prod1_req_accept | prod1_req_req_fall)
        prod1_ack <= prod1_req_accept | (~prod1_req_req_fall);
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        prod1_req_pend <= 0;
    else if (prod1_req_accept | cons_ack_fall)
        prod1_req_pend <= prod1_req_accept | (~cons_ack_fall);
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        prod_src_last <= 0;
    else if (prod0_req_accept | prod1_req_accept)
        prod_src_last <= prod1_req_accept;
end

assign prod0_req_allow = ( prod_src_last | ~prod1_req_req_i);
assign prod1_req_allow = (~prod_src_last | ~prod0_req_req_i);

endmodule
