

///////////////////////////////////////////////////////////////////////////////////////

class virtual_sequence extends uvm_sequence#(uvm_sequence_item);

	`uvm_object_utils(virtual_sequence)
	
	function new(string name="virtual_sequence");
		super.new(name);
	endfunction
	
	virtual_sequencer vseqr;
	write_sequencer write_seqr[];
	read_sequencer read_seqr[];
	seq seqh;
	
	env_config ch;
	
	virtual task body();
	
		if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",ch))
			`uvm_fatal("VIRTUAL SEQUENCE","CONFIG FAILED INSIDE VIRTUAL SEQUENCE CLASS");
			
		write_seqr=new[ch.no_of_write_agents];
		read_seqr=new[ch.no_of_read_agents];
			
		seqh=seq::type_id::create("seqh");
		
		if(!$cast(vseqr,m_sequencer))
			`uvm_fatal("VIRTUAL SEQUENCE","CASTING FAILED INSIDE VIRTUAL SEQUENCE CLASS");
			
		foreach(write_seqr[i])
		begin
			if(ch.write_cfg[i].is_active==UVM_ACTIVE)
			begin
				write_seqr[i]=vseqr.write_seqr[i];
			end
		end
		
		foreach(read_seqr[i])
		begin
			if(ch.read_cfg[i].is_active==UVM_ACTIVE)
			begin
				read_seqr[i]=vseqr.read_seqr[i];
			end
		end
		
		foreach(write_seqr[i])
		begin
			if(ch.write_cfg[i].is_active==UVM_ACTIVE)
			begin
				seqh.start(write_seqr[i]);
			end
		end
		
		foreach(read_seqr[i])
		begin
			if(ch.read_cfg[i].is_active==UVM_ACTIVE)
			begin
				seqh.start(read_seqr[i]);
			end
		end
		
	endtask
	
endclass

////////////////////////////////////////////////////////////////////////////////////////////