class fifo_scoreboard extends uvm_scoreboard;

  bit [7:0] expect_q[$:15];
  int pass_count, fail_count;
  int full_match, full_mismatch;
 
  uvm_tlm_analysis_fifo #(fifo_wseq_item)  exp_port;
  uvm_tlm_analysis_fifo #(fifo_rseq_item)  act_port;

  `uvm_component_utils(fifo_scoreboard)

  function new( string name = "fifo_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port = new("exp_port", this);
    act_port = new("act_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    fifo_wseq_item get_expect;
    fifo_rseq_item get_actual;
    bit[7:0] tmp_trans;

    fork
      forever begin
        exp_port.get(get_expect);
        if(!get_expect.wfull) begin
          expect_q.push_back(get_expect.wdata);
        end
          if(get_expect.wfull == 1 && expect_q.size == `DEPTH)  begin
            $display("-------------------------------------------");
            `uvm_info(get_type_name(),$sformatf("| FIFO FULL PASSED | wdata = %0d |",get_expect.wdata),UVM_MEDIUM)
            $display("-------------------------------------------");
            full_match++;
          end
          else if(get_expect.wfull == 1 && expect_q.size != `DEPTH)begin
            $display("-------------------------------------------");
            `uvm_info(get_type_name(),"FIFO FULL FAILED",UVM_MEDIUM)
            $display("-------------------------------------------");
            full_mismatch++;
          end
      end
      forever begin
        act_port.get(get_actual);
        if(expect_q.size() > 0) begin
          tmp_trans = expect_q.pop_front();
          if(tmp_trans == get_actual.rdata) begin
            pass_count++;
            $display("");
            `uvm_info("SCB", "MATCHED", UVM_LOW)
            `uvm_info("SCB", $sformatf("EXP DATA: %0d | ACTUAL DATA: %0d", tmp_trans, get_actual.rdata), UVM_LOW)
            $display("");
            $display("-----------------------------------------------------------------------------------------------------------------------------");
          end
          else begin
            fail_count++;
            $display("");
            `uvm_error("SCB", "MISMATCHED")
            `uvm_info("SCB", $sformatf("EXP DATA: %0d | ACTUAL DATA: %0d", tmp_trans, get_actual.rdata), UVM_LOW)
            $display("");
            $display("-----------------------------------------------------------------------------------------------------------------------------");
          end
        end
        else begin
          `uvm_error("SCB", "RECIIVED FROM DUT, BUT EXPECTED QUEUE IS EMPTY");
          `uvm_info("SCB", $sformatf("EXP DATA: %0d | ACTUAL DATA: %0d", tmp_trans, get_actual.rdata), UVM_LOW)
        end
      end
    join_none
  endtask

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("-----------------------------------------------------------------------------------------------------------------------------");
    `uvm_info("SCB", $sformatf("TOTAL PASS: %0d", pass_count ), UVM_NONE)
    `uvm_info("SCB", $sformatf("TOTAL FAIL: %0d", fail_count ), UVM_NONE)
  endfunction
endclass
