`timescale 1ns / 1ps

module HA( input x,y, output cout,s);
    assign s = x ^ y;
    assign cout = x & y;
endmodule

module FA( input x,y,ci, output cout,s);
    wire [3:0]draft;
    HA ha0(x,y,draft[3],draft[2]);
    HA ha1(ci,draft[2],draft[1],s);
    assign cout = draft[1] | draft[3];
endmodule

module RCA( input [3:0]x,[3:0]y, input ci, output cout,[3:0]s);
    wire [2:0]draft;
    FA fa0(x[0],y[0],ci,draft[2],s[0]);
    FA fa1(x[1],y[1],draft[2],draft[1],s[1]);
    FA fa2(x[2],y[2],draft[1],draft[0],s[2]);
    FA fa3(x[3],y[3],draft[0],cout,s[3]);
endmodule

module parametric_RCA(x,y,ci,cout,s);
    parameter SIZE=4;
    input [SIZE-1:0]x;
    input [SIZE-1:0]y;
    input ci;
    output cout;
    output [SIZE-1:0]s;
    wire [SIZE:0]draft;
    assign draft[0] = ci;
    assign cout = draft[SIZE];
    genvar i;
    generate for (i=0;i<SIZE;i=i+1) begin
        FA fa4(x[i],y[i],draft[i],draft[i+1],s[i]);
    end
    endgenerate
endmodule

module CLA( input [3:0]x,[3:0]y, input ci, output cout,[3:0]s);
    //ci = ab + a^b.ci-1 ci=g+p.ci-1
    // at final, cout = ab + a^b.cout-1
    wire [2:0]tocout;
    assign tocout[0] = (x[0]&&y[0])||((x[0]^y[0])&&ci);
    assign tocout[1] = (x[1]&&y[1])||((x[1]^y[1])&&tocout[0]);
    assign tocout[2] = (x[2]&&y[2])||((x[2]^y[2])&&tocout[1]);
    assign cout = (x[3]&&y[3])||((x[3]^y[3])&&tocout[2]);
    assign s[0] = x[0]^y[0]^ci;
    assign s[1] = x[1]^y[1]^tocout[0];
    assign s[2] = x[2]^y[2]^tocout[1];
    assign s[3] = x[3]^y[3]^tocout[2];
endmodule

module Add_Sub( input [3:0]A,B, input carry, output [3:0]SUM, output Cout,V);
    wire [3:0]draft;
    wire [2:0]tocout;
    xor_gate exor1(B[0],carry,draft[0]);
    xor_gate exor2(B[1],carry,draft[1]);
    xor_gate exor3(B[2],carry,draft[2]);
    xor_gate exor4(B[3],carry,draft[3]);
    FA fa5(A[0],draft[0],carry,tocout[0],SUM[0]);
    FA fa6(A[1],draft[1],tocout[0],tocout[1],SUM[1]);
    FA fa7(A[2],draft[2],tocout[1],tocout[2],SUM[2]);
    FA fa8(A[3],draft[3],tocout[2],Cout,SUM[3]);
    xor_gate exor5(Cout,tocout[2],V);
endmodule
