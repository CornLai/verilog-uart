`timescale 1ns/10ps
`include "fsm_TX.v"

module testbench();
  reg en,clk_50M,rst_n,tick_uart;
  wire busy;
  fsm_TX u1(.clk_50M(clk_50M),.en(en),.rst_n(rst_n),.tick_uart(tick_uart));
  always

endmodule

