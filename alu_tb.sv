module alu_tb();
    reg [15:0] Ain, Bin;
    reg [1:0] ALUop;
    wire [15:0] out;
    wire Z;
    reg err;

    alu dut(Ain,Bin,ALUop,out,Z); // instantiate an instance of alu

    task my_checker;
        input [15:0] expected_output;
        input [1:0] expected_op;
        input expected_z;
        begin
            if (out !== expected_output) begin
                $display("ERROR output is %b, expected %b", out, expected_output);
            end
            if (ALUop !== expected_op) begin
                $display("ERROR! ALUop is %b, expected: %b", ALUop, expected_op);
            end
            if( Z !== expected_z) begin
                $display("ERROR! Z is %b, expected: %b", Z, expected_z);
            end
        end
    endtask

    initial begin //initialization
        err = 1'b0; 
        Ain = 16'd0;
        Bin = 16'd0;
        #5;

        // testing addition
        $display("Testing addition!!");
        ALUop = 2'b00;
        // A + B = out
        // 0 + 0 = 0
        #5;
        my_checker(16'd0, 2'b00, 1'b1); 

        // 1 + 2 = 3
        Ain = 16'd1;
        Bin = 16'd2;
        #5;
        my_checker(16'd3, 2'b00, 1'b0);

        // 17 + 29 = 46
        Ain = 16'd17;
        Bin = 16'd29;
        #5;
        my_checker(16'd46, 2'b00, 1'b0);

        // 77 + 66 = 143
        Ain = 16'd77;
        Bin = 16'd66;
        #5;
        my_checker(16'd143, 2'b00, 1'b0);

        // 538 + 771
        Ain = 16'd538;
        Bin = 16'd771;
        #5;
        my_checker(16'd1309, 2'b00, 1'b0);

        // 4987 + 27 777
        Ain = 16'd4987;
        Bin = 16'd27777;
        #5; 
        my_checker(16'd32764, 2'b00, 1'b0);

        //testing subtraction
        $display("Testing subtraction wooo");
        ALUop = 2'b01;

        // A - B = out

        // 0 - 0
        Ain = 16'd0;
        Bin = 16'd0;
        #5;
        my_checker(16'd0, 2'b01, 1'b1);

        // 5 - 2
        Ain = 16'd5;
        Bin = 16'd2;
        #5;
        my_checker(16'd2, 2'b01, 1'b0);

        // 53 - 27
        Ain = 16'd53;
        Bin = 16'd27;
        #5;
        my_checker(16'd26, 2'b01, 1'b0);

        //3876 - 1212
        Ain = 16'd3876;
        Bin = 16'd1212;
        #5;
        my_checker(16'd2664, 2'b01, 1'b0);

        // Testing AND
        $display("Testing A AND B");
        ALUop = 2'b10;

        // A & B = out

        // 0 & 0
        Ain = 16'd0;
        Bin = 16'd0;
        #5;
        my_checker(16'd0, 2'b10, 1'b1);

        // 0 & 1
        Ain = 16'd0;
        Bin = 16'b1111111111111111;
        #5;
        my_checker(16'd0, 2'b10, 1'b1);

        // 1 & 1
        Ain = 16'b1111111111111111;
        Bin = 16'b1111111111111111;
        #5;
        my_checker(16'b1111111111111111, 2'b10, 1'b0);

        // Testing NOT 
        $display("Testing NOT B");
        ALUop = 2'b11;

        // ~B = out

        // ~0
        Bin = 16'd0;
        #5;
        my_checker(16'b1111111111111111, 2'b11, 1'b0);

        // ~0010000000000000
        Bin = 16'b0010000000000000;
        #5;
        my_checker(16'b1101111111111111, 2'b11, 1'b0);

        // ~1
        Bin = 16'b1111111111111111;
        #5;
        my_checker(16'd0, 2'b11, 1'b1);

    end

endmodule