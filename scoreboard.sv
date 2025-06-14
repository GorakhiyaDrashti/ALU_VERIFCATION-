class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard);
  
  /////monitor and scoreboard does not have the port and export by default in the parent class like driver and sequencer so, we have to create it out own.
  
  uvm_analysis_imp #(alu_sequence_item, alu_scoreboard) scoreboard_port;
  alu_sequence_item transactions[$];
  //------------------------
  //constructor
  //------------------------
  
  function new(string path = "alu_scoreboard", uvm_component parent  = null);
    super.new(path,parent); 
    `uvm_info("SCOREBOARD_CLASS", "Inside constructor", UVM_HIGH);
  endfunction
  
  //------------------------
  //Build phase
  //------------------------
  
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SCOREBOARD_CLASS", "BUILD_PHASE", UVM_HIGH);
    scoreboard_port = new("scorboard_port", this);
  endfunction
  
  //------------------------
  //connect phase
  //------------------------
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SCOREBOARD_CLASS", "CONNECT_PHASE", UVM_HIGH);
  endfunction
  
  //------------------------
  //write method
  //------------------------
  function void write(alu_sequence_item item);
    transactions.push_back(item);
  endfunction : write
  
  //------------------------
  //run phase
  //------------------------
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SCOREBOARD_CLASS", "RUN_PHASE", UVM_HIGH);
    forever begin
      //get the packet
      //generate expected value
      //compare it with actual value
      //score the transitions accordingly
      alu_sequence_item curr_trans;
      wait((transactions.size() ! = 0));
      cur_trans = transactions.pop_front();
      compare(curr_trans);
    end
  endtask
  
  //------------------------
  //compare task
  //------------------------
  task compare(alu_sequence_item curr_trans);
    int [7:0] expected;
    int [7:0] actual;
    case(curr_trans.op_code)
      0: begin //A + B
        expected = curr_trans.A + curr_trans.B;
      end
        
      1: begin //A - B
        expected = curr_trans.A - curr_trans.B;
      end
        
      2: begin //A * B
        expected = curr_trans.A * curr_trans.B;
      end
      
      3: begin //A / B
        expected = curr_trans.A / curr_trans.B;
      end
    endcase
      
    actual = curr_trans.result;
    
    if(actual != expected) begin
    `uvm_error("COMPARE", $sformatf("Transaction failed ACT = %0d, Exp = %0d", actual, expected))
    end
    
    else begin
      `uvm_info("COMPARE", $sformatf("Transaction failed ACT = %0d, Exp = %0d", actual, expected), UVM_LOW);
      
    end
    
     
  endtask
endclass : alu_scoreboard
