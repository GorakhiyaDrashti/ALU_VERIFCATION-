// Code your testbench here
// or browse Examples
`timescale 1ns/1ns

  //-------------------------------
  //Include Files
  //------------------------------
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scorebard.sv"
`include "env.sv"
`include "test.sv"






module top;
  
  
  //-----------------------------
  //Instantiating
  //-----------------------------
  
  logic clock;
  alu_interface intf(.clock(clock));
  
  alu dut(
    .clock(intf.clock),
    .reset(intf.reset),
    .A(intf.A),
    .B(intf.B),
    .ALU_Sel(intf.op_code),
    .ALU_Out(intf.result),
    .CarryOut(intf.carry_out)
  );
  
  //--------------------------
  //Interface Setting
  //--------------------------
  
  //// monitor and driver will reqire the handle of the virtual interface 
  initial begin
    uvm_config_db #(virtual alu_interface)::set(null, "*", "vif", intf);/// first 2 arguments is for the path, 3rd is the name by which we can access and 4th is the name in the config file od that interface
  end
  
  //--------------------------
  //Start The Test
  //--------------------------
  
  initial begin
    run_test("alu_test");
  end
  
  initial begin
    clock = 0;
    #5;
    forever begin
      clock = ~clock;
      #2;
    end
  end
  
  initial begin
    #5000;
    $display("sorry! ran out of clock cycles");
    $finish();
  end
  
  //--------------------------------
  
endmodule
