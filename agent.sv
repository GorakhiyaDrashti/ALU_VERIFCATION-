class alu_agent extends uvm_agent;
  `uvm_component_utils(alu_agent)
  
  alu_driver drv;
  alu_mon mon;
  alu_seqr seqr;
  alu_sequence_item item;
  
  //------------------------
  //Constructor 
  //------------------------
  
  function new(string path = "alu_agent", uvm_component parent  = null);
    super.new(path,parent); 
    `uvm_info("AGENT_CLASS", "Inside constructor", UVM_HIGH);
  endfunction
  
  //------------------------
  //Build Phase
  //------------------------

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("AGENT_CLASS", "BUILD_PHASE", UVM_HIGH);
    drv = alu_driver::type_id::create("alu_driver",this);
    mon = alu_mon::type_id::create("alu_mon",this);
    seqr = alu_seqr::type_id::create("alu_sequencer",this);
  endfunction
  
  //------------------------
  //Connect phase
  //------------------------
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("AGENT_CLASS", "CONNECT_PHASE", UVM_HIGH);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
  //------------------------
  //Run phase
  //------------------------
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("AGENT_CLASS", "RUN_PHASE", UVM_HIGH);
     
  endtask
endclass : alu_agent
