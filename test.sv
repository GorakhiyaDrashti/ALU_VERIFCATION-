class alu_test extends uvm_test;
  `uvm_component_utils(alu_test)
  
  
  
  alu_env env;
  alu_sequence reset_seq;
  alu_test_sequence test_seq;
  
  //------------------------
  //Constructor
  //------------------------
  function new(string path = "alu_test", uvm_component parent = null);
    super.new(path,parent);
    `uvm_info("TEST_CLASS", "Inside constructor", UVM_HIGH );
  endfunction
  
  //------------------------
  //Build Phase
  //------------------------
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TEST_CLASS", "BUILD_PHASE", UVM_HIGH);
    env = alu_env::type_id::create("env", this);
    
  endfunction
  
  //------------------------
  //Connect Phase
  //------------------------
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TET_CLASS", "CONNECT_PHASE", UVM_HIGH);
  endfunction
  
  //------------------------
  //Run phase
  //------------------------
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("TEST_CLASS", "RUN_PHASE", UVM_HIGH);
    phase.raise_objection(this);
    
    ///reset sequence
    reset_seq = alu_sequence::type_id::create("alu_sequence",this);
    reset_seq.start(env.agent.seqr);
    
    repeat(100) begin
    ///test_sequence
    test_seq = alu_test_sequence::type_id::create("test_seq",this);
    test_seq.start(env.agent.seqr);
    #10;
    end
    phase.drop_objection(this);
  endtask
endclass: alu_test
