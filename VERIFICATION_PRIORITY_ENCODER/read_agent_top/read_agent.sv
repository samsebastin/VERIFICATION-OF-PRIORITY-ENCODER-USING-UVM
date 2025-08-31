

/////////////////////////////////////////////////////////////////////////////////////////

class read_agent extends uvm_agent;

	`uvm_component_utils(read_agent)
	
	function new(string name="read_agent",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	read_monitor read_mon;
	read_driver read_drv;
	read_sequencer read_seqr;
	
	read_config ch;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(read_config)::get(this,"","read_config",ch))
			`uvm_fatal("READ AGENT","CONFIG FAILED INSIDE READ AGENT CLASS");
			
		read_mon=read_monitor::type_id::create("read_mon",this);
		
		if(ch.is_active==UVM_ACTIVE)
		begin	
			read_drv=read_driver::type_id::create("read_drv",this);
			read_seqr=read_sequencer::type_id::create("read_seqr",this);
		end
		
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		if(ch.is_active==UVM_ACTIVE)
		begin
			read_drv.seq_item_port.connect(read_seqr.seq_item_export);
		end
		
	endfunction
	
endclass

/////////////////////////////////////////////////////////////////////////