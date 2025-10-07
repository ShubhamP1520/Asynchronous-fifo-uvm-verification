class fifo_vsequencer extends uvm_sequencer;

  `uvm_component_utils(fifo_vsequencer)

  fifo_wsequencer wseqr;
  fifo_rsequencer rseqr;

  function new(string name = "fifo_vsequencer", uvm_component parent);
    super.new(name, parent);
  endfunction: new

endclass
