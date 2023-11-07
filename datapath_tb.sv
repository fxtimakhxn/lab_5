module datapath_tb();
    reg [15:0] datapath_in;
    reg [2:0] writenum, readnum;   
    reg vsel, write, clk, loada, loadb, loadc, loads, asel, bsel;
    reg [1:0] shift, ALUop; 
    wire Z_out; 
    wire [15:0] datapath_out;

    reg err;

    datapath dut(datapath_in,vsel,writenum,write,readnum,clk,loada,loadb,shift,asel,bsel,ALUop,loadc,loads,Z_out,datapath_out);

    initial begin 
    // SCENARIO #1: Ain = 202 (reg 2), Bin = 51 (shifted left) (reg 4), ALUop = Subtraction
    err = 0; 
    // checking mux #9 for vsel = 1
    vsel = 1;
    datapath_in = 16'd202;
    
    #10
    if(dut.data_in !== 16'd202) begin
        $display("ERROR! Output is %d. Expected: 202", dut.data_in);
        err = 1;
    end 

    write = 1;
    writenum = 3'd2; //want to write into register 2
    
    #10
    if(dut.data_out !== 16'd202) begin // if data_out == data_in
        $display("ERROR! Output is %d. Expected: 202", dut.data_out);
        err = 1;
    end

    // checking dff #3 A for loada = 1
    loada = 1; 
    #10 //1st clock cycle
    if(dut.out_a !== 16'd202) begin // if out_a == data_out
        $display("ERROR! Output is %d. Expected: 202", dut.out_a);
        err = 1;
    end

    loada = 0; //completed load A

    asel = 0;
    #10
    if(dut.Ain !== 16'd202) begin // if Ain == data_out
        $display("ERROR! Output is %d. Expected: 202", dut.Ain);
        err = 1;
    end
    datapath_in = 16'd51; // new value for B
    #10
    //mux #9
    if(dut.data_in !== 16'd51) begin // if data_in == datapath_in
        $display("ERROR! Output is %d. Expected: 202", dut.data_out);
        err = 1;
    end

    writenum = 3'd4; //write into register 4
    #10
    if(dut.data_out !== 16'd51) begin // if data_out == data_in
        $display("ERROR! Output is %d. Expected: 51", dut.data_out);
        err = 1;
    end

    loadb = 1; //store 51 (reg4) to B
    #10 //2nd clk

    if(dut.in !== 16'd202) begin // if in == data_out
        $display("ERROR! Output is %d. Expected: 51", dut.in);
        err = 1;
    end

    loadb = 0; // complete loadb

    shift = 2'b11; //shift right, MSB = B[15]
    #10
    if(dut.sout !== 16'b0000000000011001) begin // if sout != shifted B value
        $display("ERROR! Output is %b. Expected: 0000000000011001", dut.sout);
        err = 1;
    end

    bsel = 1; //Bin == 0000000000011001
    #10
    if(dut.Bin !== 16'b0000000000000110) begin // if Bin != shifted B value
        $display("ERROR! Output is %b. Expected: 0000000000011001", dut.Bin);
        err = 1;
    end

    ALUop = 2'b01; // Subtraction
    #10
    if(dut.out !== 16'b0000000010111000) begin //if out != Ain - Bin 
        $display("ERROR! Output is %b. Expected: 0000000010111000", dut.out);
        err = 1;
    end

    loadc = 1; //store output of ALU into C 
    #10 //3rd clk
    if(dut.datapath_out != 16'b0000000010111000) begin 
        $display("ERROR! Output is %b. Expected: 0000000010111000", dut.datapath_out);
        err = 1;
    end

    loadc = 0; //complete loadc

    loads = 1; //status stores the value of Z from ALU 
    #10 //4th clk
    if(dut.Z_out != 1'b0) begin 
        $display("ERROR! Output is %b. Expected: 0", dut.Z_out);
        err = 1;
    end

    //SCENARIO #2: 
    // Ain = 2 (reg 1) (shifted to the left), Bin = 7 (reg 0) , ALUop = Addition
    err = 0;
    vsel = 1;
    datapath_in = 16'd2;
    #10
    if(dut.data_in !== 16'd2) begin
        $display("ERROR! Output is %d. Expected: 2", dut.data_in);
        err = 1;
    end 

    write = 1;
    writenum = 3'd1; //want to write into register 1
    #10
    if(dut.data_out !== 16'd2) begin // if data_out == data_in
        $display("ERROR! Output is %d. Expected: 2", dut.data_out);
        err = 1;
    end

    // checking dff #3 A for loada = 1
    loada = 1; 
    
    #10 //1st clk
    if(dut.out_a !== 16'd2) begin // if out_a == data_out
        $display("ERROR! Output is %d. Expected: 2", dut.out_a);
        err = 1;
    end

    loada = 0; //completed load A

    asel = 0;
    #10
    if(dut.Ain !== 16'd2) begin // if Ain == data_out
        $display("ERROR! Output is %d. Expected: 2", dut.Ain);
        err = 1;
    end

    datapath_in = 16'd7; // value for B
    //mux #9
    #10
    if(dut.data_in !== 16'd7) begin // if data_in == datapath_in
        $display("ERROR! Output is %d. Expected: 7", dut.data_out);
        err = 1;
    end

    writenum = 3'd0; //write into register 0
    #10
    if(dut.data_out !== 16'd7) begin // if data_out == data_in
        $display("ERROR! Output is %d. Expected: 7", dut.data_out);
        err = 1;
    end

    loadb = 1; //store 51 (reg0) to B

    #10 //2nd clk
    if(dut.in !== 16'd7) begin // if in == data_out
        $display("ERROR! Output is %d. Expected: 7", dut.in);
        err = 1;
    end

    shift = 2'b01; //shift left, LSB = 0
    #10
    if(dut.sout !== 16'b0000000000001110) begin // if sout != shifted B value
        $display("ERROR! Output is %b. Expected: 0000000000001110", dut.sout);
        err = 1;
    end

    bsel = 1; //Bin == 0000000000001110
    #10
    if(dut.Bin !== 16'b0000000000001110) begin // if Bin != shifted B value
        $display("ERROR! Output is %b. Expected: 0000000000001110", dut.Bin);
        err = 1;
    end

    ALUop = 2'b00; //addition
    #10
    if(dut.out !== 16'b0000000000010000) begin //if out != Ain + Bin (16)
        $display("ERROR! Output is %b. Expected: 0000000010111000", dut.out);
        err = 1;
    end

    loadb = 0; //complete loadb
    loadc = 1; //store output of ALU (16) into C 
    #10 //3rd clk
    if(dut.datapath_out != 16'b0000000000010000) begin 
        $display("ERROR! Output is %b. Expected: 0000000010111000", dut.datapath_out);
        err = 1;
    end
    loadc = 0; //complete loadc
    loads = 1; //status stores the value of Z from ALU 
    #10 //4th clk
    if(dut.Z_out != 1'b0) begin 
        $display("ERROR! Output is %b. Expected: 0", dut.Z_out);
        err = 1;
    end

    //SCENARIO #3: 
    // Ain = 6 (reg 5) (shifted to the right and MSB = 0), Bin = 3 (reg 7) , ALUop = AND
    err = 0;
    vsel = 1;
    datapath_in = 16'd6;
    #10
    if(dut.data_in !== 16'd6) begin
        $display("ERROR! Output is %d. Expected: 2", dut.data_in);
        err = 1;
    end 

    write = 1;
    writenum = 3'd5; //want to write into register 5
    #10
    if(dut.data_out !== 16'd6) begin // if data_out == data_in
        $display("ERROR! Output is %d. Expected: 2", dut.data_out);
        err = 1;
    end

    // checking dff #3 A for loada = 1
    loada = 1; 

    #10 // 1st clk
    if(dut.out_a !== 16'd6) begin // if out_a == data_out
        $display("ERROR! Output is %d. Expected: 2", dut.out_a);
        err = 1;
    end

    loada = 0; //completed load A
    asel = 0;
    #10
    if(dut.Ain !== 16'd6) begin // if Ain == data_out
        $display("ERROR! Output is %d. Expected: 2", dut.Ain);
        err = 1;
    end

    datapath_in = 16'd3; // value for B
    //mux #9
    #10
    if(dut.data_in !== 16'd3) begin // if data_in == datapath_in
        $display("ERROR! Output is %d. Expected: 7", dut.data_out);
        err = 1;
    end

    writenum = 3'd7; //write into register 7
    #10
    if(dut.data_out !== 16'd3) begin // if data_out == data_in
        $display("ERROR! Output is %d. Expected: 7", dut.data_out);
        err = 1;
    end

    loadb = 1; //store 3 (reg7) to B

    #10 //2nd clk
    if(dut.in !== 16'd3) begin // if in == data_out
        $display("ERROR! Output is %d. Expected: 7", dut.in);
        err = 1;
    end

    shift = 2'b10; //shift right, MSD = 0
    #10
    if(dut.sout !== 16'b0000000000000001) begin // if sout != shifted B value
        $display("ERROR! Output is %b. Expected: 0000000000001110", dut.sout);
        err = 1;
    end

    bsel = 1; //Bin == b0000000000000001
    #10
    if(dut.Bin !== 16'b0000000000000001) begin // if Bin != shifted B value
        $display("ERROR! Output is %b. Expected: 0000000000000001", dut.Bin);
        err = 1;
    end

    ALUop = 2'b10; //AND
    #10
    if(dut.out !== 16'b0000000000000000) begin //if out != Ain && Bin (0)
        $display("ERROR! Output is %b. Expected: 0000000000000000", dut.out);
        err = 1;
    end

    loadb = 0; //complete loadb
    loadc = 1; //store output of ALU (0) into C 
    #10 //3rd clk

    if(dut.datapath_out != 16'b0000000000000000) begin 
        $display("ERROR! Output is %b. Expected: 0000000000000000", dut.datapath_out);
        err = 1;
    end

    loadc = 0; //complete loadc
    loads = 1; //status stores the value of Z from ALU - testing that Z_out = 1 for out = 0 
    #10 //4th clk

    if(dut.Z_out != 1'b1) begin 
        $display("ERROR! Output is %b. Expected: 0", dut.Z_out);
        err = 1;
    end
    end 
endmodule
