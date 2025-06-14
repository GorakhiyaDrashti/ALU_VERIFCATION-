scclass alu_env extends uvm_env;
  `uvm_component_utils(alu_env)
  
  alu_agent agent;
  alu_scoreboard scb;
  
  //------------------------
  //COnstructor
  //------------------------
  
  function new(string path = "alu_env", uvm_component parent  = null);
    super.new(path,parent); 
    `uvm_info("ENV_CLASS", "Inside constructor", UVM_HIGH);
  endfunction
  
  //------------------------
  //Build phase
  //------------------------
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ENV_CLASS", "BUILD_PHASE", UVM_HIGH);
    agent = alu_agent::type_id::create("agent", this);
    scb = alu_scoreboard::type_id::create("scoreboard", this);
  endfunction
  
  //------------------------
  //Connect phase
  //------------------------
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("ENV_CLASS", "CONNECT_PHASE", UVM_HIGH);
    agent.mon.mon_port.connect(scb.scoreboard_port);
  endfunction
  
  //------------------------
  //Run phase
  //------------------------
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("ENV_CLASS", "RUN_PHASE", UVM_HIGH);
  endtask
endclass : alu_env
