class fifo_rsequencer extends uvm_sequencer#(fifo_rseq_item);
  `uvm_component_utils(fifo_rsequencer)

  function new(string name = "fifo_rsequencer", uvm_component parent);
    super.new(name, parent);
  endfunction: new

endclass: fifo_rsequencer
