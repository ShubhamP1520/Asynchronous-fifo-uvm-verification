class fifo_wseq_item extends uvm_sequence_item;

  rand logic winc;
  rand logic [`DSIZE-1:0] wdata;
  logic wfull;

  `uvm_object_utils_begin(fifo_wseq_item)
  `uvm_field_int(wdata, UVM_ALL_ON)
  `uvm_field_int(winc, UVM_ALL_ON)
  `uvm_field_int(wfull, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "fifo_wseq_item");
    super.new(name);
  endfunction

endclass
