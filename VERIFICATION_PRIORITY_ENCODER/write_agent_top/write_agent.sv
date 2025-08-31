

/////////////////////////////////////////////////////////////////////////////

class write_agent extends uvm_agent;

	`uvm_component_utils(write_agent)
	
	function new(string name="write_agent",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	write_monitor write_mon;
	write_driver write_drv;
	write_sequencer write_seqr;
	
	write_config ch;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(write_config)::get(this,"","write_config",ch))
			`uvm_fatal("WRITE AGENT","FAILED TO GET CONFIG INSIDE WRITE CONFIG");
			
		write_mon=write_monitor::type_id::create("write_mon",this);
		
		if(ch.is_active==UVM_ACTIVE)
		begin	
			write_drv=write_driver::type_id::create("write_drv",this);
			write_seqr=write_sequencer::type_id::create("write_seqr",this);
		end
		
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		if(ch.is_active==UVM_ACTIVE)
		begin
			write_drv.seq_item_port.connect(write_seqr.seq_item_export);
		end
		
	endfunction
	
endclass

/////////////////////////////////////////////////////////////////////////////////////////