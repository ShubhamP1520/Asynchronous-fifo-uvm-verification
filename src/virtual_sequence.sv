class fifo_vsequence extends uvm_sequence;

  fifo_wsequence wseq;
  fifo_rsequence rseq;

  fifo_wsequence2 wseq2;
  fifo_rsequence2 rseq2;
  
  fifo_wsequencer wseqr;
  fifo_rsequencer rseqr;

  `uvm_object_utils(fifo_vsequence)
  `uvm_declare_p_sequencer(fifo_vsequencer)

  function new(string name = "fifo_vsequence");
    super.new(name);
  endfunction: new

  task body();
    wseq = fifo_wsequence::type_id::create("wseq");
    rseq = fifo_rsequence::type_id::create("rseq");
    wseq2 = fifo_wsequence2::type_id::create("wseq2");
    rseq2 = fifo_rsequence2::type_id::create("rseq2");
    fork
      wseq.start(p_sequencer.wseqr);
      rseq.start(p_sequencer.rseqr);
    join
    fork
      wseq2.start(p_sequencer.wseqr);
      rseq2.start(p_sequencer.rseqr);
    join
  endtask: body

endclass: fifo_vsequence
