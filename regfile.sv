module regfile(data_in,writenum,write,readnum,clk,data_out);
    input [15:0] data_in;
    input [2:0] writenum, readnum;
    input write, clk;
    output [15:0] data_out;

    vDFFR U0 (clk, load ,data_in, register); //load is the writenum ANDed with write and register is what the load enable writes to 



endmodule

//code for Load Enable 
module vDFFE(clk, en, in, out) ;
  parameter n = 16;  // width
  input clk, en ; //en is the load part
  input  [n-1:0] in ;
  output [n-1:0] out ;
  reg    [n-1:0] out ;
  wire   [n-1:0] next_out ;

  assign next_out = en ? in : out;

  always @(posedge clk)
    out = next_out;  
endmodule
