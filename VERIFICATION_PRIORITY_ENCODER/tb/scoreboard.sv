

/////////////////////////////////////////////////////////////////////////////////

class scoreboard extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)
	
	uvm_tlm_analysis_fifo#(trans) wrm2sb;
	uvm_tlm_analysis_fifo#(trans) rdm2sb;
	trans wm;
	trans rm;
	trans cg;
	
	covergroup pe_cg;
	
		option.per_instance=1;
		
		in : coverpoint cg.in 
								{
								bins in[] = {1,2,4,8};
								}
								
	endgroup
	
	function new(string name="scoreboard",uvm_component parent);
		super.new(name,parent);
		pe_cg=new();
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		wrm2sb=new("wrm2sb",this);
		rdm2sb=new("rdm2sb",this);
	endfunction
	
	virtual task run_phase(uvm_phase phase);
	
		forever
		begin
			wrm2sb.get(wm);
			cg = wm;
			pe_cg.sample();
			rdm2sb.get(rm);
			dummy(wm);
			method_to_check(wm);
		end
		
	endtask
	
	task dummy(trans wm1);
	
		if(wm1.in[3])
			wm1.out = 2'b11;
		else if(wm1.in[2])
			wm1.out = 2'b10;
		else if(wm1.in[1])
			wm1.out = 2'b01;
		else
			wm1.out = 2'b00;
			
	endtask
	
	task method_to_check(trans wm2);
	
		`uvm_info("SCORE BOARD","DATAS FROM REFERENCE MODEL",UVM_NONE);
		wm2.print();
		`uvm_info("SCORE BOARD","DATAS FROM READ MONITOR",UVM_NONE);
		rm.print();
		
		$display("");
		$display("out from reference model = %b        out from read monitor = %b",wm2.out,rm.out);
		$display("");
	
		if(wm2.out == this.rm.out)
		begin
			$display("#####################################################################################");
			$display("#####################################################################################");
			$display("##################                    SUCCESS                    ####################");
			$display("#####################################################################################");
			$display("#####################################################################################");
		end
		
		else
		begin
			$display("#####################################################################################");
			$display("#####################################################################################");
			$display("##################                    FAILURE                    ####################");
			$display("#####################################################################################");
			$display("#####################################################################################");
		end
		
	endtask
	
endclass

//////////////////////////////////////////////////////////////////////////////////