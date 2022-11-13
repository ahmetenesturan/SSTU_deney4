`timescale 1ns / 1ps
module and_gate(input in0, input in1, output out);

    assign out = in0 & in1;

endmodule

module or_gate(input in0, input in1, output out);

    assign out = in0 | in1;
    
endmodule
 
module not_gate(input in, output out);

    assign out = ~in;
    
endmodule

module nand_gate(input in0, input in1, output reg out);
    always @ (in0 or in1) begin
        if(in0 == 1 && in1 == 1) begin
            out = 0;
        end
        else begin
            out = 1;
        end
     end
endmodule

module nor_gate(input in0, input in1, output reg out);
    always @ (in0 or in1) begin
        if(in0 == 0 && in1 == 0) begin
            out = 1;
        end
        else begin
            out = 0;
        end
     end
endmodule

module xor_gate(input in0, input in1, output out);
    LUT2 #(
    .INIT ( 4'b0110 ) 
	) XOR_GATE
	(
    .I0( in0 ),
    .I1( in1 ),
    .O ( out )
 );  
endmodule

module xnor_gate(input in0, input in1, output out);
    LUT2 #(
    .INIT ( 4'b1001 ) 
	) XOR_GATE
	(
    .I0( in0 ),
    .I1( in1 ),
    .O ( out )
 );  
endmodule

module TRI(input i, input e, output o);
    assign o = e ? i : 1'bZ;
endmodule