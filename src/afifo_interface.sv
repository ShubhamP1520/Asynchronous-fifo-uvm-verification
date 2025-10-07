interface fifo_inf (input logic wclk, wrst_n, rclk, rrst_n);
  logic [7:0] wdata;
  logic [7:0] rdata;
  logic winc;
  logic rinc;
  logic wfull;
  logic rempty;

  clocking wdrv_cb @(posedge wclk);
  default input #0 output #0;
    output wdata;
    output winc;
  endclocking

  clocking wmon_cb @(posedge wclk);
  default input #0 output #0;
    input wfull;
    input wdata;
    input winc;
  endclocking

  clocking rdrv_cb @(posedge rclk);
  default input #0 output #0;
    output rinc;
  endclocking

  clocking rmon_cb @(posedge rclk);
  default input #0 output #0;
    input rempty;
    input rdata;
    input rinc;
  endclocking

endinterface
