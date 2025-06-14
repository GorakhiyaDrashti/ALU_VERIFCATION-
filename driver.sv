class alu_driver extends uvm_driver#(alu_sequence_item);
  `uvm_component_utils(alu_driver)
  
  virtual alu_interface vif;
  alu_sequence_item item;
  
  //--------------------------
  //Constructor
  //--------------------------
  
  function new(string path = "driver_env", uvm_component parent  = null);
    super.new(path,parent); 
    `uvm_info("DRIVER_CLASS", "Inside constructor", UVM_HIGH);
  endfunction
  
  //--------------------------
  //Build phase
  //--------------------------
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DRIVER_CLASS", "BUILD_PHASE", UVM_HIGH);
    //// the ideal way to get the interface is in the build phase but we can get it anywhere.
    if(!(uvm_config_db #(virtual alu_interface)::get(this,"*", "vif", vif))) begin
    `uvm_error("DRIVER_CLASS", "Failed to get VIF from config DB!");
    end
    ///this(cntxt): Represents the UVM component instance that’s calling get()
    ///"*" matches any immediate child of cntxt, regardless of name.
    ///"vif"	Field name identifier for config. both should be same in set and get method
    ///vif (ref)	Receives the virtual interface handle this is okay if both set and get dosn't have same name. but it should match with the handle name declared in each class.
  endfunction
  
  //--------------------------
  //COnnect phase
  //--------------------------
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("DRIVER_CLASS", "CONNECT_PHASE", UVM_HIGH);
  endfunction
  
  //--------------------------
  //RUn phase
  //--------------------------
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("DRIVER_CLASS", "RUN_PHASE", UVM_HIGH);
     forever begin
       item = alu_sequence_item::type_id::create("item");
       seq_item_port.get_next_item(item);
       driver(item);/////created task 
       seq_item_port.item_done();
     end
  endtask
  
  //------------------------
  //Drive Task
  //------------------------
  task driver(alu_sequence_item item);
    @(posedge vif.clock);
    vif.reset <= item.reset;
    vif.A <= item.A;
    vif.B <= item.B;
    vif.op_code <= item.op_code;
  endtask
  
endclass : alu_driver
