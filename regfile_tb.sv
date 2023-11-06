module regfile_tb();
    reg [15:0] data_in; 
    reg [2:0] writenum, readnum; 
    reg write, clk 
    wire [15:0] data_out; 
    reg err; 

    regfile dut(data_in,writenum,write,readnum,clk,data_out);

    task my_checker;
        input [15:0] expected_data_out; 
        begin 
            if(dut.data_out !== expected_data_out);
                $display("ERRORR ** output is %b, expected %b", dut.data_out, expected_data_out);
                err = 1'b1; 
        end 
    endtask;

    initial begin // setting frequency of clock
		clk = 0; #5;
		forever begin 
			clk = 1; #5;
			clk = 0; #5;
		end 
	end 

    initial begin 
        //intalization of error to 0  
        err = 1'b0; 

        //testing when write = 0
        //When write is 0, the registers should be updated 
        write = 1'b0; 

        $display(); 
        data_in = ; 
        writenum = ; 
        readnum = ; 
        #5 
        my_checker(); 


        //testing when write = 1
        //When write is 1, the value of data_in is written in the respective register from writenum 
        write = 1'b1; 

        // register 0
        $display("Testing writing/reading to register 0"); 
        data_in = 16'd512; 
        writenum = 3'd0; 
        readnum = 3'd0; 
        #5 
        my_checker(16'd512); 

        // register 1
        $display("Testing writing/reading to register 1"); 
        data_in = 16'd1020; 
        writenum = 3'd1; 
        readnum = 3'd1; 
        #5 
        my_checker(16'd1020); 
        
        // register 2
        $display("Testing writing/reading to register 2"); 
        data_in = 16'd38; 
        writenum = 3'd2; 
        readnum = 3'd2; 
        #5 
        my_checker(16'd38); 

                // register 3
        $display("Testing writing/reading to register 3"); 
        data_in = 16'd85; 
        writenum = 3'd3; 
        readnum = 3'd3; 
        #5 
        my_checker(16'd85); 
        
                // register 4
        $display("Testing writing/reading to register 4"); 
        data_in = 16'd2345; 
        writenum = 3'd4; 
        readnum = 3'd4; 
        #5 
        my_checker(16'd2345); 

                // register 5
        $display("Testing writing/reading to register 5"); 
        data_in = 16'd1100; 
        writenum = 3'd5; 
        readnum = 3'd5; 
        #5 
        my_checker(16'd1100); 

                // register 6
        $display("Testing writing/reading to register 6"); 
        data_in = 16'd3333; 
        writenum = 3'd6; 
        readnum = 3'd6; 
        #5 
        my_checker(16'd3333); 

                // register 7
        $display("Testing writing/reading to register 7"); 
        data_in = 16'd5; 
        writenum = 3'd7; 
        readnum = 3'd7; 
        #5 
        my_checker(16'd5); 

        //if pass all checks, error keeps value of 0 and displays passed otherwise failed displays. 
        if(~err) $display("PASSED"); 
        else $display("FAILED");
        $stop; 
    end 
endmodule: regfile_tb
