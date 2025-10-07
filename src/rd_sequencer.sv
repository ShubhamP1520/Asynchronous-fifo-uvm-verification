class fifo_wsequencer extends uvm_sequencer#(fifo_wseq_item);
  `uvm_component_utils(fifo_wsequencer)

  function new(string name = "fifo_wsequencer", uvm_component parent);
    super.new(name, parent);
  endfunction: new

endclass: fifo_wsequencer
