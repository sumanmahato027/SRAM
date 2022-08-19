module test_bench;

	reg [7:0] i;	//Input variable
	wire [7:0] o;	//Output variable
	reg [1:0] select;
	reg read, clear;	
	
	Circuit C1(i[0], i[1], i[2], i[3], i[4], i[5], i[6], i[7], o[0], o[1], o[2], o[3], o[4], o[5], o[6], o[7], select[0], select[1], read, clear);
	
	initial 
		begin
			
			/*
				Sequence of operations:
				1 - erase memory by setting clear as LOW (active LOW reset for DFFs)
				2 - once memory is erased, clear can be set back to HIGH for data storage
				3 - perform READ operation and read all 32 bits. Result should be 0 for all since memory was cleared.
				4 - Set circuit to WRITE mode and write in some data
				5 - perform READ operation to verify that data was written
				6 - erase memory
				7 - perform READ operation to verify that memory was wiped
			*/
			
				i = 8'b11001010;	//some random input state which won't be stored
			
				clear = 1'b0;	//active LOW reset for all DFFs to clear memory
			#10 clear = 1'b1;   
			
			/*	MEMORY HAS BEEN CLEARED  */
					
			#10 read = 1'b1;   //Setting circuit to READ mode by giving active LOW enable to multiplexers
			
			/*  CIRCUIT IS NOW IN READ MODE  */
			
				select = 2'b00;    //Telling multiplexers to read from DFF IC's 0 and 4
			
			#10 select = 2'b01;   //Telling multiplexers to read from DFF IC's 1 and 5
			
			#10 select = 2'b10;   //Telling multiplexers to read from DFF IC's 2 and 6
			
			#10 select = 2'b11;   //Telling multiplexers to read from DFF IC's 3 and 7
			
			/*  DATA HAS NOW BEEN READ FROM THE MEMORY. ALL BITS ARE 0  */
			
			#10 read = 1'b0;	//Setting circuit to WRITE mode by giving active low to decoder
			
			/*  CIRCUIT IS NOW IN WRITE MODE  */
			
				select = 2'b00;  //Telling decoder to provide HIGH signals to DFF ICs 0 and 4 for storage
				i = 8'b00010001;   //Writing this value into DFF IC's
			
			#10 select = 2'b01;    //Telling decoder to provide HIGH signals to DFF ICs 1 and 5 for storage
				i = 8'b00100010;	//Writing this value into DFF IC's
			
			#10 select = 2'b10;    //Telling decoder to provide HIGH signals to DFF ICs 2 and 6 for storage
				i = 8'b01000100;	//Writing this value into DFF IC's
			
			#10 select = 2'b11;    //Telling decoder to provide HIGH signals to DFF ICs 3 and 7 for storage
				i = 8'b10001000;	//Writing this value into DFF IC's
			
			/*  DATA HAS BEEN WRITTEN TO THE MEMORY  */
			
			#10 read = 1'b1;	//Setting circuit to READ mode by giving active LOW enable to multiplexers
			
			/*  CIRCUIT IS NOW IN READ MODE  */
			
				select = 2'b00;    //Telling multiplexers to read from DFF IC's 0 and 4
			
			#10 select = 2'b01;   //Telling multiplexers to read from DFF IC's 1 and 5
			
			#10 select = 2'b10;   //Telling multiplexers to read from DFF IC's 2 and 6
			
			#10 select = 2'b11;   //Telling multiplexers to read from DFF IC's 3 and 7

			/*  DATA HAS NOW BEEN READ FROM THE MEMORY. ALL BITS SHOULD MATCH THE ENTERED DATA  */
			
			#10	clear = 1'b0;	//active LOW reset for all DFFs to clear memory
			#10 clear = 1'b1;   //disabling reset so that DFFs can store data
			
			/*	MEMORY HAS BEEN CLEARED  */
					
			#10 read = 1'b1;   //Setting circuit to READ mode by giving active LOW enable to multiplexers
			
			/*  CIRCUIT IS NOW IN READ MODE  */
			
				select = 2'b00;    //Telling multiplexers to read from DFF IC's 0 and 4
			
			#10 select = 2'b01;   //Telling multiplexers to read from DFF IC's 1 and 5
			
			#10 select = 2'b10;   //Telling multiplexers to read from DFF IC's 2 and 6
			
			#10 select = 2'b11;   //Telling multiplexers to read from DFF IC's 3 and 7
			
			/*  DATA HAS NOW BEEN READ FROM THE MEMORY. ALL BITS ARE 0  */
					
		end
endmodule