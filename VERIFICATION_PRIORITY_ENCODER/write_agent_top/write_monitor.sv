

////////////////////////////////////////////////////////////////////////////////////

class write_monitor extends uvm_monitor;

	`uvm_component_utils(write_monitor)
	
	function new(string name="write_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	virtual pe_vif.WR_MON_MP vif;
	trans h;
	uvm_analysis_port#(trans) wrm2sb;
	
	env_config ch;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(env_config)::get(this,"","env_config",ch))
			`uvm_fatal("WRITE MONITOR","CONFIG FAILED INSIDE WRITE MONITOR CLASS");
			
		wrm2sb=new("wrm2sb",this);
		
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		foreach(ch.write_cfg[i])
		begin
			this.vif=ch.write_cfg[i].vif;
		end
		
	endfunction
	
	virtual task run_phase(uvm_phase phase);
	
		forever
		begin
			h=trans::type_id::create("h");
			data_from_dut();
			wrm2sb.write(h);
		end
		
	endtask
	
	task data_from_dut();
	
		#5;
		this.h.in = vif.in;
		
	endtask
	
endclass

/////////////////////////////////////////////////////////////////////////////////