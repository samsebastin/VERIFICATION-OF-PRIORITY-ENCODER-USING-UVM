

//////////////////////////////////////////////////////////////////////////////////

class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);

	`uvm_component_utils(virtual_sequencer)
	
	function new(string name="virtual_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	write_sequencer write_seqr[];
	read_sequencer read_seqr[];
	
	env_config ch;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(env_config)::get(this,"","env_config",ch))
			`uvm_fatal("VIRTUAL SEQUENCER","CONFIG FAILED INSIDE VIRTUAL SEQUENCER CLASS");
			
		write_seqr=new[ch.no_of_write_agents];
		read_seqr=new[ch.no_of_read_agents];
		
	endfunction
	
endclass

/////////////////////////////////////////////////////////////////////////////////////