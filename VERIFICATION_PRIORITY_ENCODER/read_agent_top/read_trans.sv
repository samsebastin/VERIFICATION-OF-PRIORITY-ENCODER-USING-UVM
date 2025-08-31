

////////////////////////////////////////////////////////////////////////////////////

class trans extends uvm_sequence_item;

	`uvm_object_utils(trans)
	
	function new(string name="trans");
		super.new(name);
	endfunction
	
	randc bit [3:0] in;
	bit [1:0] out;
	
	virtual function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("in",this.in,4,UVM_BIN);
		printer.print_field("out",this.out,2,UVM_BIN);
	endfunction
	
endclass

////////////////////////////////////////////////////////////////////////////////////