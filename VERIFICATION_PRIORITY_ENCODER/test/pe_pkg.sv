

package pe_pkg;

	`include "uvm_macros.svh"
	
	import uvm_pkg::*;
	
	`include "write_config.sv"
	`include "read_config.sv"
	
	`include "env_config.sv"
	
	//write
	
	`include "write_trans.sv"
	`include "write_sequence.sv"
	`include "write_monitor.sv"
	`include "write_driver.sv"
	`include "write_sequencer.sv"
	`include "write_agent.sv"
	`include "write_agent_top.sv"
	
	//read

	`include "read_monitor.sv"
	`include "read_driver.sv"
	`include "read_sequencer.sv"
	`include "read_agent.sv"
	`include "read_agent_top.sv"
	
	`include "scoreboard.sv"
	`include "virtual_sequencer.sv"
	`include "virtual_sequence.sv"
	`include "environment.sv"
	
	`include "test.sv"
	
endpackage