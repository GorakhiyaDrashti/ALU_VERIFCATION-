class alu_mon extends uvm_monitor;
  `uvm_component_utils(alu_mon)
  
  virtual alu_interface vif;
  alu_sequence_item item;
  
  uvm_analysis_port #(alu_sequence_item) monitor_port;
  
  //------------------------
  //constructor
  //------------------------
  
  function new(string path = "alu_mon", uvm_component parent  = null);
    super.new(path,parent); 
    `uvm_info("MON_CLASS", "Inside constructor", UVM_HIGH);
  endfunction
  
  //------------------------
  //Build Phase
  //------------------------  
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MON_CLASS", "BUILD_PHASE", UVM_HIGH);
    if(!(uvm_config_db #(virtual alu_interface)::get(this,"*", "vif", vif))) begin
      `uvm_error("MON_CLASS", "Failed to get VIF from config DB!");
      monitor_port = new("monitor_port", this);
    end
  endfunction
  
  //------------------------
  //connect phase
  //------------------------
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MON_CLASS", "CONNECT_PHASE", UVM_HIGH);
  endfunction
  
  //------------------------
  //run phase
  //------------------------
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MON_CLASS", "RUN_PHASE", UVM_HIGH);
    forever begin
      item = alu_sequence_item::type_id::create("item", this);
      wait(!vif.reset);
      
      ///sample inputs
      @(posedge vif.clock);
      item.A = vif.A;
      item.B = vif.B;
      item.op_code = vif.op_code;
      
      //sample outputs
      @(posedge vif.clock);
      item.result = vif.result; 
      
      /// send item to scoreboard
      monitor_port.write(item);
      
      
    end
    
  endtask
endclass : alu_mon
