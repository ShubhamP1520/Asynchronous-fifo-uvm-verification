class fifo_wsequence extends uvm_sequence#(fifo_wseq_item);
  `uvm_object_utils(fifo_wsequence)

  fifo_wseq_item req;

  function new( string name = "fifo_wsequence");
      super.new(name);
  endfunction: new

  task body();
    repeat(`no_trans) begin
      req = fifo_wseq_item::type_id::create("req");
      `uvm_rand_send_with(req, {req.winc == 1;})
    end
  endtask: body
endclass : fifo_wsequence

class fifo_wsequence2 extends uvm_sequence#(fifo_wseq_item);
  `uvm_object_utils(fifo_wsequence2)

  fifo_wseq_item req;

  function new( string name = "fifo_wsequence2");
      super.new(name);
  endfunction: new

  task body();
    repeat(`no_trans) begin
      req = fifo_wseq_item::type_id::create("req");
      `uvm_rand_send_with(req, {req.winc == 1;})
    end
    repeat(`no_trans) begin
      req = fifo_wseq_item::type_id::create("req");
      `uvm_rand_send_with(req, {req.winc == 0;})
    end

  endtask: body
endclass : fifo_wsequence3

