class fifo_rdriver extends uvm_driver#(fifo_rseq_item);

  virtual fifo_inf inf;
  `uvm_component_utils(fifo_rdriver)


  function new(string name = "fifo_rdriver", uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_inf)::get(this, "", "fifo_inf", inf)) begin
      `uvm_info("RDRV", "THE SET IS FAILED IN TOP", UVM_NONE)
    end
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    repeat(3) @(inf.rdrv_cb);
    forever begin
      seq_item_port.get_next_item(req);
      r_drive();
      repeat(1) @(inf.rdrv_cb);
      `uvm_info("RDRV", $sformatf("READ DRIVER: RINC = %0d",req.rinc), UVM_NONE)
      seq_item_port.item_done();
    end
  endtask: run_phase

  task r_drive();
    inf.rinc <= req.rinc;
  endtask: r_drive

endclass: fifo_rdriver
