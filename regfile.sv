module regfile(data_in,writenum,write,readnum,clk,data_out);
  input [15:0] data_in;
  input [2:0] writenum, readnum;
  input write, clk;
  output [15:0] data_out;
 
  wire reg [7:0] writenum_dec, readnum_dec; //8 bit hot code from the decoder
  wire load0, load1, load2, load3, load4, load5, load6, load7; //the different loads into the load enable 
  wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7; //registers 0-7

    Dec U0 (writenum, writenum_dec); //decoder for writing to the registers 
    vDFFE U2 (clk, load0, data_in, R0); //load enable for r0 
    vDFFE U3 (clk, load1, data_in, R1); //load enable for r1 
    vDFFE U4 (clk, load2, data_in, R2); //load enable for r2 
    vDFFE U5 (clk, load3, data_in, R3); //load enable for r3 
    vDFFE U6 (clk, load4, data_in, R4); //load enable for r4 
    vDFFE U7 (clk, load5, data_in, R5); //load enable for r5 
    vDFFE U8 (clk, load6, data_in, R6); //load enable for r6 
    vDFFE U9 (clk, load7, data_in, R7); //load enable for r7 
    Dec U10 (readnum, readnum_dec); //decoder for reading the registers
    mux U11 (R0, R1, R2, R3, R4, R5, R6, R7, readnum_dec, data_out); //the multiplexer

    //to make sure load inputs to the correct register
    assign load0 = writenum_dec[0] & write; 
    assign load1 = writenum_dec[1] & write; 
    assign load2 = writenum_dec[2] & write;
    assign load3 = writenum_dec[3] & write;
    assign load4 = writenum_dec[4] & write;
    assign load5 = writenum_dec[5] & write;
    assign load6 = writenum_dec[6] & write;
    assign load7 = writenum_dec[7] & write;
endmodule

//module for Load Enable 
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

//module for the 3:8 decoder
module Dec(a,b);
  parameter n=3;
  parameter m = 8;

  input [n-1:0] a;
  output [m-1:0] b;

  wire [m-1:0] b = 1 << a;
endmodule

//module for the multiplexer 
module mux (a0, a1, a2, a3, a4, a5, a6, a7, s, b); 
  parameter k = 16; 
  input [k-1:0] a0, a1, a2, a3, a4, a5, a6, a7; //registers
  input [7:0] s; //output of readnum through 3:8 decoder 
  output reg [k-1:0] b; //data_out 

  always_comb begin 
    case(s)
      //corresponds to the registers one hot code and then their respective output value. 
      8'b00000001: b = a0; //r0 outputs value of a0 
      8'b00000010: b = a1; //r1 outputs value of a1 
      8'b00000100: b = a2; //r2 outputs value of a2 
      8'b00001000: b = a3; //r3 outputs value of a3 
      8'b00010000: b = a4; //r4 outputs value of a4 
      8'b00100000: b = a5; //r5 outputs value of a5 
      8'b01000000: b = a6; //r6 outputs value of a6 
      8'b10000000: b = a7; //r7 outputs value of a7 
      default: b = {k{1'bx}}; 
    endcase
  end 
endmodule
