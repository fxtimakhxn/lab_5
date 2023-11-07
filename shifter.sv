module shifter (in,shift,sout);
    input [15:0] in; 
    input [1:0] shift; 
    output reg [15:0] sout; 

    //describes the shifter 
    always_comb begin 
        case(shift) 
            2'b00: sout = in; //if the shift = 00, then output = input
            2'b01: begin //shift = 01
                sout = in << 1; //shift left by 1
                sout[0] = 1'b0; //LSB = 0 
            end
            2'b10: begin //shift = 10
                sout = in >> 1; //shift right by 1
                sout[15] = 1'b0; //MSB = 0
            end 
            2'b11: begin //shift = 11
                sout = in >> 1; //shift right by 1
                sout[15] = in[15]; //MSB = in[15]
            end
            default: sout = 16'bxxxxxxxxxxxxxxxx;  
        endcase 
    end 
endmodule
