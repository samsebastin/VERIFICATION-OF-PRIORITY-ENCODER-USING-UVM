

///////////////////////////////////////////////////////////////////////////////////////

class env_config extends uvm_object;

	`uvm_object_utils(env_config)
	
	function new(string name="env_config");
		super.new(name);
	endfunction
	
	write_config write_cfg[];
	read_config read_cfg[];
	
	int no_of_trans;
	int no_of_write_agents;
	int no_of_read_agents;
	bit has_scoreboard;
	bit has_virtual_sequencer;
	
endclass

////////////////////////////////////////////////////////////////////////////////////