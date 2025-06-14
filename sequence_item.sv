///object class

class alu_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(alu_sequence_item)
  
  //------------------
  // Instantiation
  //-------------------
 rand logic [7:0] A,B;
 rand logic [3:0] op_code;
 rand logic reset;
  
 logic [7:0] result; ///output
 bit carry_out;  //output
  
  //--------------------
  //Constraints
  //---------------------
  constraint input1_c {A inside {[10 : 20]};}
  constraint input2_c {B inside {[1 : 10]};}
  constraint op_code_c {op_code inside {0,1,2,3};}
  
  //---------------------
  //Constructor
  //---------------------
   
  function new(string path = "alu_sequence_item");
    super.new(path);
  endfunction
  
  
  
endclass : alu_sequence_item
