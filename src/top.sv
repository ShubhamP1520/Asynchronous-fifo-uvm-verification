`include "uvm_macros.svh"
`include "fifo_inf.sv"
`include "FIFO.v"

module top;

  import uvm_pkg::*;
  import pkg::*;

  bit wclk;
  bit rclk;
  bit wrst_n;
  bit rrst_n;

  fifo_inf inf(wclk, wrst_n, rclk, rrst_n);
  
  always #5 wclk = ~wclk;
  always #10 rclk = ~rclk;

  FIFO async_fifo(

    .rdata(inf.rdata),
    .wfull(inf.wfull),
    .rempty(inf.rempty),
    .wdata(inf.wdata),
    .winc(inf.winc),
    .wclk(wclk),
    .wrst_n(wrst_n),
    .rinc(inf.rinc),
    .rclk(rclk),
    .rrst_n(rrst_n)
  );

  initial begin
    wclk = 0;
    rclk = 0;
    wrst_n = 0;
    rrst_n = 0;
    #20 rrst_n = 1;
    #20 wrst_n = 1;
  end

  initial begin
    uvm_config_db#(virtual fifo_inf)::set(null, "*", "fifo_inf", inf);
    run_test("fifo_test");
  end
endmodule: top
