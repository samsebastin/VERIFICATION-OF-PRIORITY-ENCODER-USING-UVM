

/////////////////////////////////////////////////////////////////////////////////

class read_monitor extends uvm_monitor;

	`uvm_component_utils(read_monitor)
	
	function new(string name="read_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	virtual pe_vif.RD_MON_MP vif;
	trans h;
	uvm_analysis_port#(trans) rdm2sb;
	
	env_config ch;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(env_config)::get(this,"","env_config",ch))
			`uvm_fatal("READ MONITOR","DATAS FROM THE DUT TO THE READ MONITOR");
			
		rdm2sb=new("rdm2sb",this);
			
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		foreach(ch.read_cfg[i])
		begin
			this.vif=ch.read_cfg[i].vif;
		end
		
	endfunction

	virtual task run_phase(uvm_phase phase);
	
		forever
		begin
			h=trans::type_id::create("h");
			data_from_dut();
			rdm2sb.write(h);
		end
		
	endtask
	
	task data_from_dut();
		
		#5;
		this.h.out = vif.out;
		
	endtask
		
endclass

///////////////////////////////////////////////////////////////////////////////