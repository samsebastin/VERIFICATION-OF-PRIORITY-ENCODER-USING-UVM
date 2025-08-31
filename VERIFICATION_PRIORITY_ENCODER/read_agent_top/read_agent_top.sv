

/////////////////////////////////////////////////////////////////////////////////

class read_agent_top extends uvm_env;

	`uvm_component_utils(read_agent_top)
	
	function new(string name="read_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	read_agent read_agt[];
	
	env_config ch;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(env_config)::get(this,"","env_config",ch))
			`uvm_fatal("READ AGENT TOP","CONFIG FAILED INSIDE READ AGENT TOP");
			
		read_agt=new[ch.no_of_read_agents];
		
		foreach(read_agt[i])
		begin
			read_agt[i]=read_agent::type_id::create($sformatf("read_agt[%0d]",i),this);
		end
		
	endfunction
	
endclass

/////////////////////////////////////////////////////////////////////////////////