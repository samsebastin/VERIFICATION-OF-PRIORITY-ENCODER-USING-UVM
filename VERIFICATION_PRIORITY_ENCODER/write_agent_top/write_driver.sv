

//////////////////////////////////////////////////////////////////////////////

class write_driver extends uvm_driver#(trans);

	`uvm_component_utils(write_driver)
	
	function new(string name="write_driver",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	virtual pe_vif.WR_DRV_MP vif;
	
	env_config ch;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(env_config)::get(this,"","env_config",ch))
			`uvm_fatal("WRITE DRIVER","COFIG FAILED INSIDE WRITE DRIVER CLASS");
			
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		foreach(ch.write_cfg[i])
		begin
			if(ch.write_cfg[i].is_active==UVM_ACTIVE)
			begin
				this.vif=ch.write_cfg[i].vif;
			end
		end
		
	endfunction
	
	virtual task run_phase(uvm_phase phase);
	
		forever
		begin
			seq_item_port.get_next_item(req);
			data_to_dut(req);
			seq_item_port.item_done();
		end
		
	endtask
	
	task data_to_dut(trans h1);
	
		#5;
		vif.in = h1.in;
		
	endtask
	
endclass

/////////////////////////////////////////////////////////////////////////////