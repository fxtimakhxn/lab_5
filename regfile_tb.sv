module regfile_tb();
    reg [15:0] data_in; 
    reg [2:0] writenum,readnum; 
    reg write, clk; 
    wire [15:0] data_out; 
    reg err; 

    regfile DUT(data_in,writenum,write,readnum,clk,data_out);

    task my_checker;
        input [15:0] expected_data_out; 
        begin 
            if(data_out !== expected_data_out);
                $display("ERRORR ** output is %b, expected %b", data_out, expected_data_out);
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

        //testing when write = 1
        //When write is 1, the value of data_in is written in the respective register from writenum 
        write = 1'b1; 

        // register 0
        $display("Testing writing/reading to register 0"); 
        data_in = 16'd512; 
        writenum = 3'd0; 
        readnum = 3'd0; 
        #10
        my_checker(16'd512); //output should match data_in stored in R0

        //testing when write = 0
        //When write is 0, the registers should be updated 
        write = 1'b0; 

        //testing if R0 did not get updated
        $display("checking R0"); 
        data_in = 16'd698; 
        writenum = 3'd0; 
        readnum = 3'd0; 
        #10
        my_checker(16'd512); //output should keep the inital data_in value from above test stored in R0

        write = 1'b1;

        // register 1
        $display("Testing writing/reading to register 1"); 
        data_in = 16'd1020; 
        writenum = 3'd1; 
        readnum = 3'd1; 
        #10
        my_checker(16'd1020); //output should match data_in stored in R1

        write = 1'b0;

        //testing if R1 did not get updated
        $display("checking R1"); 
        data_in = 16'd1000; 
        writenum = 3'd1; 
        readnum = 3'd1; 
        #10
        my_checker(16'd1020); //output should keep the inital data_in value from above test stored in R1

        write = 1'b1; 
        
        // register 2
        $display("Testing writing/reading to register 2"); 
        data_in = 16'd38; 
        writenum = 3'd2; 
        readnum = 3'd2; 
        #10
        my_checker(16'd38); //output should match data_in stored in R2

        write = 1'b0;

        //testing if R2 did not get updated
        $display("checking R2"); 
        data_in = 16'd8; 
        writenum = 3'd2; 
        readnum = 3'd2; 
        #10
        my_checker(16'd38); //output should keep the inital data_in value from above test stored in R2

        write = 1'b1;

                // register 3
        $display("Testing writing/reading to register 3"); 
        data_in = 16'd85; 
        writenum = 3'd3; 
        readnum = 3'd3; 
        #10
        my_checker(16'd85); //output should match data_in stored in R3

        write = 1'b0;

        //testing if R3 did not get updated
        $display("checking R3"); 
        data_in = 16'd97; 
        writenum = 3'd3; 
        readnum = 3'd3; 
        #10
        my_checker(16'd85); //output should keep the inital data_in value from above test stored in R3

        write = 1'b1;
        
                // register 4
        $display("Testing writing/reading to register 4"); 
        data_in = 16'd2345; 
        writenum = 3'd4; 
        readnum = 3'd4; 
        #10
        my_checker(16'd2345); //output should match data_in stored in R4

        write = 1'b0;

        //testing if R4 did not get updated
        $display("checking R4"); 
        data_in = 16'd786; 
        writenum = 3'd4; 
        readnum = 3'd4; 
        #10
        my_checker(16'd2345); //output should keep the inital data_in value from above test stored in R4

        write = 1'b1;

                // register 5
        $display("Testing writing/reading to register 5"); 
        data_in = 16'd1100; 
        writenum = 3'd5; 
        readnum = 3'd5; 
        #10
        my_checker(16'd1100); //output should match data_in stored in R5

        write = 1'b0;

        //testing if R5 did not get updated
        $display("checking R5"); 
        data_in = 16'd22; 
        writenum = 3'd5; 
        readnum = 3'd5; 
        #10
        my_checker(16'd1100); //output should keep the inital data_in value from above test stored in R5

        write = 1'b1;

                // register 6
        $display("Testing writing/reading to register 6"); 
        data_in = 16'd3333; 
        writenum = 3'd6; 
        readnum = 3'd6; 
        #10
        my_checker(16'd3333); //output should match data_in stored in R6

        write = 1'b0;

         //testing if R6 did not get updated
        $display("checking R6"); 
        data_in = 16'd567; 
        writenum = 3'd6; 
        readnum = 3'd6; 
        #10
        my_checker(16'd3333); //output should keep the inital data_in value from above test stored in R6

        write = 1'b1;

                // register 7
        $display("Testing writing/reading to register 7"); 
        data_in = 16'd5; 
        writenum = 3'd7; 
        readnum = 3'd7; 
        #10
        my_checker(16'd5); //output should match data_in stored in R7

        write = 1'b0;

        //testing if R7 did not get updated
        $display("checking R7"); 
        data_in = 16'd1; 
        writenum = 3'd7; 
        readnum = 3'd7; 
        #10
        my_checker(16'd5); //output should keep the inital data_in value from above test stored in R7

        //if pass all checks, error keeps value of 0 and displays passed otherwise failed displays. 
        if(~err) $display("PASSED"); 
        else $display("FAILED");
        $stop; 
    end 
endmodule: regfile_tb
