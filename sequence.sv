////object classs

class alu_sequence extends uvm_sequence;
  `uvm_object_utils(alu_sequence)
  
  alu_sequence_item reset_pkt;
  
  //-------------------------------------
  // Constructor
  //-------------------------------------
  
  function new(string path = "alu_sequence");
    super.new(path);
    `uvm_info("SEQUENCE_CLASS", "Inside constructor", UVM_HIGH);
  endfunction
  
  
  //-------------------------------------
  // Task Body
  //-------------------------------------
  
  task body();
   `uvm_info("SEQUENCE_CLASS", "Inside body task!", UVM_HIGH);
    reset_pkt = alu_sequence_item::type_id::create("reset_pkt");
    start_item(reset_pkt);
    reset_pkt.randomize() with {reset == 1;};
    finish_item(reset_pkt);
  endtask
endclass : alu_sequence


class alu_test_sequence extends alu_sequence;
  `uvm_object_utils(alu_test_sequence)
  
  alu_sequence_item item;
  
  
  //-------------------------------------
  // Constructor
  //-------------------------------------
  
  function new(string path = "alu_test_sequence");
    super.new(path);
    `uvm_info(get_type_name(), "constructor", UVM_NONE);
  endfunction
  
  
  //-------------------------------------
  // Task Body
  //-------------------------------------
  
  task body();
    `uvm_info("Test Sequence", "Task Body", UVM_NONE);
    item = alu_sequence_item::type_id::create("item");
    start_item(item);
    item.randomize();
    finish_item(item);  
  endtask
  
endclass : alu_test_sequence
