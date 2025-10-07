class fifo_wagent extends uvm_agent;
  `uvm_component_utils(fifo_wagent)

  fifo_wdriver wdrv;
  fifo_wmonitor wmon;
  fifo_wsequencer wseqr;

  function new(string name = "fifo_wagent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wdrv = fifo_wdriver::type_id::create("wdrv", this);
    wmon = fifo_wmonitor::type_id::create("wmon", this);
    wseqr = fifo_wsequencer::type_id::create("wseqr", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    wdrv.seq_item_port.connect(wseqr.seq_item_export);
  endfunction
endclass

