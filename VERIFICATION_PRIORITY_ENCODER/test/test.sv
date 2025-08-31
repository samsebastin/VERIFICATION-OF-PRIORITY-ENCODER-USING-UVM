

////////////////////////////////////////////////////////////////////////////////////////////

class test extends uvm_test;

	`uvm_component_utils(test)
	
	function new(string name="test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	environment env;
	virtual_sequence vseq;
	
	int no_of_trans=30;
	int no_of_write_agents=1;
	int no_of_read_agents=1;
	bit has_scoreboard=1;
	bit has_virtual_sequencer=1;
	
	env_config env_cfg;
	
	write_config write_cfg[];
	read_config read_cfg[];
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		env_cfg=env_config::type_id::create("env_cfg");
		
		env_cfg.no_of_trans=no_of_trans;
		env_cfg.no_of_write_agents=no_of_write_agents;
		env_cfg.no_of_read_agents=no_of_read_agents;
		env_cfg.has_scoreboard=has_scoreboard;
		env_cfg.has_virtual_sequencer=has_virtual_sequencer;
		
		env_cfg.write_cfg=new[no_of_write_agents];
		env_cfg.read_cfg=new[no_of_read_agents];
		
		write_cfg=new[no_of_write_agents];
		read_cfg=new[no_of_read_agents];
		
		foreach(write_cfg[i])
		begin
			write_cfg[i]=write_config::type_id::create($sformatf("write_cfg[%0d]",i));
			env_cfg.write_cfg[i]=write_cfg[i];
			
			if(!uvm_config_db#(virtual pe_vif)::get(this,"","pe_vif",write_cfg[i].vif))
				`uvm_fatal("TEST","INTERFACE CONFIG FAILED FOR WRITE CFG INSIDE TEST CLASS");
			
			if(i==0)
			begin
				write_cfg[i].is_active=UVM_ACTIVE;
				uvm_config_db#(write_config)::set(this,$sformatf("env.write_agt_top.write_agt[%0d]",i),"write_config",write_cfg[i]);
			end
			
			else
			begin	
				write_cfg[i].is_active=UVM_PASSIVE;
				uvm_config_db#(write_config)::set(this,$sformatf("env.write_agt_top.write_agt[%0d]",i),"write_config",write_cfg[i]);
			end
		end
		
		foreach(read_cfg[i])
		begin
			read_cfg[i]=read_config::type_id::create($sformatf("read_cfg[%0d]",i));
			env_cfg.read_cfg[i]=read_cfg[i];
			
			if(!uvm_config_db#(virtual pe_vif)::get(this,"","pe_vif",read_cfg[i].vif))
				`uvm_fatal("TEST","INTERFACE FAILED FOR READ CFG INSIDE TEST CLASS");
			
			if(i==0)
			begin
				read_cfg[i].is_active=UVM_PASSIVE;
				uvm_config_db#(read_config)::set(this,$sformatf("env.read_agt_top.read_agt[%0d]",i),"read_config",read_cfg[i]);
			end
			
			else 
			begin
				read_cfg[i].is_active=UVM_ACTIVE;
				uvm_config_db#(read_config)::set(this,$sformatf("env.read_agt_top.read_agt[%0d]",i),"read_config",read_cfg[i]);
			end
		end
		
		uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg);
		
		env=environment::type_id::create("env",this);
		vseq=virtual_sequence::type_id::create("vseq");
		
	endfunction
	
	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		
		uvm_top.print_topology();
		
	endfunction
	
	virtual task run_phase(uvm_phase phase);
	
		phase.raise_objection(this);
		vseq.start(env.vseqr);
		phase.drop_objection(this);
		
	endtask
	
endclass

////////////////////////////////////////////////////////////////////////////////////////////////////