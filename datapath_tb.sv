module datapath_tb();
    reg [15:0] datapath_in,
    reg [2:0] writenum, readnum;   
    reg vsel, write, clk, loada, loadb, loadc, loads, asel, bsel;
    reg [1:0] shift, ALUop; 
    wire Z_out; 
    wire [15:0] datapath_out;

    reg err;

    datapath dut(datapath_in,vsel,writenum,write,readnum,clk,loada,loadb,shift,asel,bsel,ALUop,loadc,loads,Z_out,datapath_out);

    // SCENARIO #1: Ain = 202 (reg 2), Bin = 51 (shifted left) (reg 4), ALUop = Subtraction

    // checking mux #9 for vsel = 1
    //will check vsel = 0 when we have a datapath_out at the end 
    vsel = 1;
    datapath_in = 16'd202;
    if(dut.data_in !== 16'd202) begin
        $display("ERROR! Output is %d. Expected: 202", dut.data_in);
        err = 1;
    end 

    write = 1;
    writenum = 3'd2; //want to write into register 2

    if(dut.data_out !== 16'd202) begin // if data_out == data_in
        $display("ERROR! Output is %d. Expected: 202", dut.data_out);
        err = 1;
    end

    // checking dff #3 A for loada = 1
    loada = 1; 

    //#10 //wait for a clock cycle
    if(dut.out_a !== 16'd202) begin // if out_a == data_out
        $display("ERROR! Output is %d. Expected: 202", dut.out_a);
        err = 1;
    end

    loada = 0; //completed load A

    asel = 0;
    if(dut.Ain !== 16'd202) begin // if Ain == data_out
        $display("ERROR! Output is %d. Expected: 202", dut.Ain);
        err = 1;
    end

    datapath_in = 16'd51; // new value for B
    //mux #9
    if(dut.data_in !== 16'd51) begin // if data_in == datapath_in
        $display("ERROR! Output is %d. Expected: 202", dut.data_out);
        err = 1;
    end

    writenum = 3'd4; //write into register 4

    if(dut.data_out !== 16'd51) begin // if data_out == data_in
        $display("ERROR! Output is %d. Expected: 51", dut.data_out);
        err = 1;
    end

    loadb = 1; //store 51 (reg4) to B

    //#10
    if(dut.in !== 16'd202) begin // if in == data_out
        $display("ERROR! Output is %d. Expected: 51", dut.in);
        err = 1;
    end

    shift = 2'b11; //shift right, MSB = B[15]

    //#10
    if(dut.sout !== 16'b0000000000011001) begin // if sout != shifted B value
        $display("ERROR! Output is %b. Expected: 0000000000011001", dut.sout);
        err = 1;
    end

    bsel = 1; //Bin == 0000000000011001

    if(dut.Bin !== 16'b0000000000000110) begin // if Bin != shifted B value
        $display("ERROR! Output is %b. Expected: 0000000000011001", dut.Bin);
        err = 1;
    end

    ALUop = 2'b01; // Subtraction
    //Fatima code:



    //SCENARIO #2: 
    // Ain = 2 (reg 1) (shifted to the left), Bin = 7 (reg 0) , ALUop = Addition

    vsel = 1;
    datapath_in = 16'd2;
    if(dut.data_in !== 16'd2) begin
        $display("ERROR! Output is %d. Expected: 2", dut.data_in);
        err = 1;
    end 

    write = 1;
    writenum = 3'd0; //want to write into register 0

    if(dut.data_out !== 16'2) begin // if data_out == data_in
        $display("ERROR! Output is %d. Expected: 2", dut.data_out);
        err = 1;
    end

    // checking dff #3 A for loada = 1
    loada = 1; 

    //#10 //wait for a clock cycle
    if(dut.out_a !== 16'd2) begin // if out_a == data_out
        $display("ERROR! Output is %d. Expected: 2", dut.out_a);
        err = 1;
    end

    loada = 0; //completed load A

    asel = 0;
    if(dut.Ain !== 16'd2) begin // if Ain == data_out
        $display("ERROR! Output is %d. Expected: 2", dut.Ain);
        err = 1;
    end

    datapath_in = 16'd7; // value for B
    //mux #9
    if(dut.data_in !== 16'd7) begin // if data_in == datapath_in
        $display("ERROR! Output is %d. Expected: 7", dut.data_out);
        err = 1;
    end

    writenum = 3'd1; //write into register 4

    if(dut.data_out !== 16'd7) begin // if data_out == data_in
        $display("ERROR! Output is %d. Expected: 7", dut.data_out);
        err = 1;
    end

    loadb = 1; //store 51 (reg4) to B

    //#10
    if(dut.in !== 16'd7) begin // if in == data_out
        $display("ERROR! Output is %d. Expected: 7", dut.in);
        err = 1;
    end

    shift = 2'b01; //shift left, LSB = 0

    //#10
    if(dut.sout !== 16'b0000000000001110) begin // if sout != shifted B value
        $display("ERROR! Output is %b. Expected: 0000000000001110", dut.sout);
        err = 1;
    end

    bsel = 1; //Bin == 0000000000001110

    if(dut.Bin !== 16'b0000000000001110) begin // if Bin != shifted B value
        $display("ERROR! Output is %b. Expected: 0000000000001110", dut.Bin);
        err = 1;
    end

    ALUop = 2'b00; //addition

    //FATIMA CODE




endmodule
