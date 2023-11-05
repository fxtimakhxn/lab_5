`define r0 8'b00000001
`define r1 8'b00000010
`define r2 8'b00000100
`define r3 8'b00001000
`define r4 8'b00010000
`define r5 8'b00100000
`define r6 8'b01000000
`define r7 8'b10000000

module regfile(data_in,writenum,write,readnum,clk,data_out);
  input [15:0] data_in;
  input [2:0] writenum, readnum;
  input write, clk;
  output [15:0] data_out;
  wire [7:0] writenum_dec, readnum_dec;
  wire load;
  wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
  //vDFFR U? (clk, load ,data_in, R); //load is the writenum ANDed with write and register is what the load enable writes to 

  always_comb begin
    Dec U0 (writenum, writenum_dec);
    AND_GATE U1 (writenum_dec, write);
    assign 
  end

  always_ff(@posedge clk) begin
    case(writenum_dec) 
      `r0: begin
        vDFFE U2 (clk, load, data_in, R0);
      end
      `r1:begin
        vDFFE U3 (clk, load, data_in, R1);
      end
      `r2:begin
        vDFFE U4 (clk, load, data_in, R2);
      end
      `r3:begin
        vDFFE U5 (clk, load, data_in, R3);
      end
      `r4:begin
        vDFFE U6 (clk, load, data_in, R4);
      end
      `r5:begin
        vDFFE U7 (clk, load, data_in, R5);
      end
      `r6:begin
        vDFFE U8 (clk, load, data_in, R6);
      end
      `r7:begin
        vDFFE U9 (clk, load, data_in, R7);
      end
      default: //?
    endcase
  end

  always_comb begin
    Dec U10 (readnum, readnum_dec);
    mux U11 (R0, R1, R2, R3, R4, R5, R6, R7, readnum_dec, data_out);
  end

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

//module for the AND gates 
module AND_GATE (a, b, c);
  input a, b;
  output c;
  assign c = a & b; //load = write & writenum
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
      8'b00000001: b = a0; 
      8'b00000010: b = a1; 
      8'b00000100: b = a2; 
      8'b00001000: b = a3; 
      8'b00010000: b = a4; 
      8'b00100000: b = a5; 
      8'b01000000: b = a6; 
      8'b10000000: b = a7;  
      default: b = {k{1'bx}}; 
    endcase
  end 
endmodule
