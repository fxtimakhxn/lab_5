module datapath_tb();
    reg [15:0] datapath_in;
    reg [2:0] writenum, readnum;   
    reg vsel, write, clk, loada, loadb, loadc, loads, asel, bsel;
    reg [1:0] shift, ALUop; 
    wire Z_out; 
    wire [15:0] datapath_out;

    reg err;

    datapath DUT(datapath_in,vsel,writenum,write,readnum,clk,loada,loadb,shift,asel,bsel,ALUop,loadc,loads,Z_out,datapath_out);

    initial begin
        clk = 0;
        forever begin
            clk = 1; #5;
            clk = 0; #5;
        end
    end

    initial begin 
    clk = 0;
    
    //SCENARIO #1: 
    // Ain = 2 (reg 1) (shifted to the left), Bin = 7 (reg 0) , ALUop = Addition

    err = 0;
    vsel = 1;
    datapath_in = 16'd2;
    #10

    write = 1;
    writenum = 3'd1; //want to write into register 1
    #10

    // checking dff #3 A for loada = 1
    readnum = 3'd1;

    #10 
    loada = 1; 
    #10
    loada = 0; //completed load A

    asel = 0;
    #10

    datapath_in = 16'd7; // value for B
    //mux #9

    writenum = 3'd0; //write into register 0
    #10
    readnum = 3'd0;
    #10
    loadb = 1; //store 7 (reg0) to B

    #10 //2nd clk
    loadb = 0;

    shift = 2'b01; //shift left

    bsel = 0; 
    #10
    ALUop = 2'b00; //addition
    #10
    loadc = 1; //store output of ALU (16) into C 

    loads = 1; //status stores the value of Z from ALU 
    #10 //3rd clk
    if(datapath_out != 16'b0000000000010000) begin 
        $display("ERROR! Output is %b. Expected: 0000000010111000", datapath_out);
        err = 1;
    end
    loadc = 0; //complete loadc
    loads = 0;

    vsel = 0;
    write = 1;
    writenum = 3'd2;
    #10 //4th clk
    if(Z_out != 1'b0) begin 
        $display("ERROR! Output is %b. Expected: 0", Z_out);
        err = 1;
    end

    $stop;
    end
endmodule
