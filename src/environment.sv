class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env)

  fifo_wagent wagt;
  fifo_ragent ragt;
  fifo_vsequencer vseqr;
  fifo_scoreboard scb;
  fifo_coverage cov;

  function new(string name = "fifo_env", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wagt = fifo_wagent::type_id::create("wagt",this);
    ragt = fifo_ragent::type_id::create("ragt",this);
    vseqr = fifo_vsequencer::type_id::create("vseqr", this);
    scb = fifo_scoreboard::type_id::create("scb", this);
    cov = fifo_coverage::type_id::create("cov", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    wagt.wmon.wmon_analysis_imp.connect(scb.exp_port.analysis_export);
    ragt.rmon.rmon_analysis_imp.connect(scb.act_port.analysis_export);
    wagt.wmon.wmon_analysis_imp.connect(cov.wmon_port);
    ragt.rmon.rmon_analysis_imp.connect(cov.rmon_port);
    vseqr.wseqr = wagt.wseqr;
    vseqr.rseqr = ragt.rseqr;
  endfunction: connect_phase

endclass: fifo_env
