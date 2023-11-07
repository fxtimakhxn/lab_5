module datapath(datapath_in,vsel,writenum,write,readnum,clk,loada,loadb,shift,asel,bsel,ALUop,loadc,loads,Z_out,datapath_out);
    input [15:0] datapath_in;
    input [2:0] writenum, readnum;   
    input vsel, write, clk, loada, loadb, loadc, loads, asel, bsel;
    input [1:0] shift, ALUop; 
    output Z_out; 
    output [15:0] datapath_out;

    wire [15:0] out_a; 

    //instantatious of register file, shifter and ALU 
    regfile REGFILE(data_in,writenum,write,readnum,clk,data_out);
    shifter shifter(in,shift,sout);
    ALU alu(Ain,Bin,ALUop,out,Z);
    
    //instantatious of mux #9,6,7
    assign data_in = vsel ? datapath_in : datapath_out; //#9
    assign Ain = asel ? 16'b0 : out_a; //#6
    assign Bin = bsel ? {11'b0,datapath_in[4:0]} : sout; //#7

    //instantatious of register A, B, C and status
    vDFFE A (clk, loada, data_out, out_a); //load enable for register A 
    vDFFE B (clk, loadb, data_out, in); //load enable for register B 
    vDFFE C (clk, loadc, out, datapath_out); //load enable for register C 
    vDFFE status (clk, loads, Z, Z_out); //load enable for status

endmodule
