class fifo_wdriver extends uvm_driver#(fifo_wseq_item);

  virtual fifo_inf inf;
  `uvm_component_utils(fifo_wdriver)

  function new(string name = "fifo_wdriver", uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_inf)::get(this, "", "fifo_inf", inf)) begin
      `uvm_info("WDRV", "THE SET IS FAILED IN TOP", UVM_NONE)
    end
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    repeat(3)@(inf.wdrv_cb);
    forever begin
      seq_item_port.get_next_item(req);
      w_drive();
      repeat(1)@(inf.wdrv_cb);
      $display("");
      `uvm_info("WDRV", $sformatf("WRITE DRIVER:WINC : %0d | WDATA : %0d",req.winc, req.wdata), UVM_NONE)
      seq_item_port.item_done();
    end
  endtask: run_phase

  task w_drive();
    inf.winc <= req.winc;
    inf.wdata <= req.wdata;
  endtask: w_drive

endclass: fifo_wdriver
