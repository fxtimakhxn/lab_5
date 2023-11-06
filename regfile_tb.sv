module regfile_tb();
    reg [15:0] data_in; 
    reg [2:0] wrtienum,rednum; 
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

        $display(); 
        data_in = ; 
        writenum = ; 
        readnum = ; 
        #5 
        my_checker(); 

        //if pass all checks, error keeps value of 0 and displays passed otherwise failed displays. 
        if(~err) $display("PASSED"); 
        else $display("FAILED");
        $stop; 
    end 
endmodule: regfile_tb
