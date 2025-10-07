class fifo_rseq_item extends uvm_sequence_item;

  rand logic rinc;
  logic [`DSIZE-1:0] rdata;
  logic rempty;

  `uvm_object_utils_begin(fifo_rseq_item)
  `uvm_field_int(rinc, UVM_ALL_ON)
  `uvm_field_int(rdata, UVM_ALL_ON)
  `uvm_field_int(rempty, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "fifo_rseq_item");
    super.new(name);
  endfunction

endclass
