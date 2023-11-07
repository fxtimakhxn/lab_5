module shifter_tb();
    reg [15:0] in; 
    reg [1:0] shift; 
    wire [15:0] sout; 
    reg err; 

    shifter dut(in,shift,sout);

    task my_checker;
        input [15:0] expected_sout; 
        begin 
            if(dut.sout !== expected_sout) begin
                $display("ERRORR ** output is %b, expected %b", dut.sout, expected_sout);
                err = 1'b1; 
            end
        end 
    endtask; 

    initial begin 
        //intalization 
        in = 16'b0000000000000000; 
        err = 1'b0; 

        shift = 2'b00;
        //checking various inputs when shift = 00
        $display("checking when shift is 00");
        //input is binary 1 
        in = 16'b0000000000000001; //when in is inputted, the output should be the same
        #10; //wait for 10 seconds
        my_checker(16'b0000000000000001); //Checks if the corresponding output matches

        //input is binary 897 
        in = 16'b0000001110000001; //when in is inputted, the output should be the same
        #10; //wait for 10 seconds
        my_checker(16'b0000001110000001); //Checks if the corresponding output matches

        //input is binary ?? 
        in = 16'b1111100000000000;  //when in is inputted, the output should be the same
        #10; //wait for 10 seconds
        my_checker(16'b1111100000000000); //Checks if the corresponding output matches

        //checking various inputs when shift = 01
        shift = 2'b01;
        $display("checking when shift is 01");
        //input is binary ?? 
        in = 16'b0000000000001111; //when in is inputted, the output should have all the digits shifted left and LSB = 0 
        #10; //wait for 10 seconds
        my_checker(16'b0000000000011110); //Checks if the corresponding output matches

        //input is binary ?? 
        in = 16'b1111000000000110; //when in is inputted, the output should have all the digits shifted left and LSB = 0 
        #10; //wait for 10 seconds
        my_checker(16'b1110000000001100); //Checks if the corresponding output matches

        //input is binary ?? 
        in = 16'b1001110000000100; //when in is inputted, the output should have all the digits shifted left and LSB = 0 
        #10; //wait for 10 seconds
        my_checker(16'b0011100000001000); //Checks if the corresponding output matches

        //checking various inputs when shift = 10 
        shift = 2'b10;
        $display("checking when shift is 10");
        //input is binary ?? 
        in = 16'b1111100000000000; //when in is inputted, the output should have all the digits shifted right and MSB = 0 
        #10; //wait for 10 seconds
        my_checker(16'b0111110000000000); //Checks if the corresponding output matches

        //input is binary ?? 
        in = 16'b0100000000000000; //when in is inputted, the output should have all the digits shifted right and MSB = 0 
        #10; //wait for 10 seconds
        my_checker(16'b0010000000000000); //Checks if the corresponding output matches

        //input is binary ?? 
        in = 16'b0000011110000001; //when in is inputted, the output should have all the digits shifted right and MSB = 0 
        #10; //wait for 10 seconds
        my_checker(16'b0000001111000000); //Checks if the corresponding output matches

        //checking various when shift = 11
        shift = 2'b11;
        $display("checking when shift is 11");
        //input is binary ?? 
        in = 16'b1110001110000001; //when in is inputted, the output should have all the digits shifted right and MSB = copy of in[15]
        #10; //wait for 10 seconds
        my_checker(16'b1111000111000000); //Checks if the corresponding output matches

        //input is binary ?? 
        in = 16'b0000001111111111; //when in is inputted, the output should have all the digits shifted right and MSB = copy of in[15]
        #10; //wait for 10 seconds
        my_checker(16'b0000000111111111); //Checks if the corresponding output matches

        //input is binary ?? 
        in = 16'b1111111100000001; //when in is inputted, the output should have all the digits shifted right and MSB = copy of in[15]
        #10; //wait for 10 seconds
        my_checker(16'b1111111110000000); //Checks if the corresponding output matches

        if(~err) $display("PASSED"); 
        else $display("FAILED");
    end
endmodule: shifter_tb //CHECK WAVEFORM AND SEE IF NEED TO ADD $stop 
