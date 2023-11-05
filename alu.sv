module ALU(Ain,Bin,ALUop,out,Z);
    input [15:0] Ain, Bin;
    input [1:0] ALUop;
    output reg [15:0] out;
    output reg Z;
    // fill out the rest

    always_comb begin 
        // depending on ALUop, out gets the result of a certain operation 
        case(ALUop)
            2'b00: out = Ain + Bin; //addition
            2'b01: out = Ain -Bin; //subtraction
            2'b10: out = Ain & Bin;   //AND
            2'b11: out = ~Bin;        //NOT
            default: out = 16'bxxxxxxxxxxxxxxxx;
        endcase

        if (out == 16'd0) begin // when out is 0, Z is 1; else Z is 0
            Z = 1'b1;
        end else begin
            Z = 1'b0;
        end

    end


endmodule
