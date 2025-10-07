class fifo_rsequence extends uvm_sequence#(fifo_rseq_item);
  `uvm_object_utils(fifo_rsequence)

  fifo_rseq_item req;

  function new( string name = "fifo_rsequence");
      super.new(name);
  endfunction: new

  task body();
    repeat(`no_trans) begin
      req = fifo_rseq_item::type_id::create("req");
      `uvm_rand_send_with(req,{req.rinc == 1;})
    end
 endtask: body

endclass : fifo_rsequence

class fifo_rsequence2 extends uvm_sequence#(fifo_rseq_item);
  `uvm_object_utils(fifo_rsequence2)

  fifo_rseq_item req;

  function new( string name = "fifo_rsequence2");
      super.new(name);
  endfunction: new

  task body();
    repeat(`no_trans) begin
      req = fifo_rseq_item::type_id::create("req");
      `uvm_rand_send_with(req,{req.rinc == 0;})
    end
   repeat(`no_trans) begin
      req = fifo_rseq_item::type_id::create("req");
      `uvm_rand_send_with(req,{req.rinc == 1;})
    end

 endtask: body

endclass : fifo_rsequence2
