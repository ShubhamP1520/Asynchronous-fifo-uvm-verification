class fifo_ragent extends uvm_agent;
  `uvm_component_utils(fifo_ragent)

  fifo_rdriver rdrv;
  fifo_rmonitor rmon;
  fifo_rsequencer rseqr;

  function new(string name = "fifo_ragent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rdrv = fifo_rdriver::type_id::create("rdrv", this);
    rmon = fifo_rmonitor::type_id::create("rmon", this);
    rseqr = fifo_rsequencer::type_id::create("rseqr", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    rdrv.seq_item_port.connect(rseqr.seq_item_export);
  endfunction
endclass
