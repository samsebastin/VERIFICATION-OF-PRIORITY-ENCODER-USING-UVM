

/////////////////////////////////////////////////////////////////////////

class write_agent_top extends uvm_env;

	`uvm_component_utils(write_agent_top)
	
	function new(string name="write_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	write_agent write_agt[];
	
	env_config ch;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(env_config)::get(this,"","env_config",ch))
			`uvm_fatal("WRITE AGENT TOP","CONFIG FAILED INSIDE WRITE AGENT TOP");
			
		write_agt=new[ch.no_of_write_agents];
		
		foreach(write_agt[i])
		begin
			write_agt[i]=write_agent::type_id::create($sformatf("write_agt[%0d]",i),this);
		end
		
	endfunction
	
endclass

/////////////////////////////////////////////////////////////////////////////////