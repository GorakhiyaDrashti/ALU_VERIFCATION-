class alu_seqr extends uvm_sequencer#(alu_sequence_item);
  `uvm_component_utils(alu_seqr);
  
  //------------------------
  //Constructor
  //------------------------
  
  function new(string path = "alu_seqr", uvm_component parent  = null);
    super.new(path,parent); 
    `uvm_info("SEQUENCER_CLASS", "Inside constructor", UVM_HIGH);
  endfunction
  
  //------------------------
  //Build phase
  //------------------------
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SEQUENCER_CLASS", "BUILD_PHASE", UVM_HIGH);
  endfunction
  
  //------------------------
  //connect phase
  //------------------------
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SEQUENCER_CLASS", "CONNECT_PHASE", UVM_HIGH);
  endfunction
  
  
endclass : alu_seqr
