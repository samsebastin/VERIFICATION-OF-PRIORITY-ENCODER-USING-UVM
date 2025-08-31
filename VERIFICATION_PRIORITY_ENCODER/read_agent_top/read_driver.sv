

/////////////////////////////////////////////////////////////////////////////

class read_driver extends uvm_driver#(trans);

	`uvm_component_utils(read_driver)
	
	function new(string name="read_driver",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	virtual task run_phase(uvm_phase phase);
	
		forever
		begin
			seq_item_port.get_next_item(req);
			`uvm_info("READ DRIVER","RECIEVED DATAS FROM READ DRIVER CLASS",UVM_NONE);
			req.print();
			seq_item_port.item_done();
		end
		
	endtask
	
endclass

/////////////////////////////////////////////////////////////////////////////