`timescale 1ns / 1ps

module ha_tb;
    reg x,y;
    wire cout,s;
    HA HAtb(x,y,cout,s);
    initial begin
        $monitor(x,y,cout,s);
        for (integer i=0; i<4; i=i+1) begin
            {x,y} = i; #10;
        end
        $finish;
    end
endmodule

module fa_tb;
    reg x,y,ci;
    wire cout,s;
    FA FAtb(x,y,ci,cout,s);
    initial begin
        $monitor(x,y,,ci,cout,s);
        for (integer i=0; i<8; i=i+1) begin
            {x,y,ci} = i;
            #10;
        end
        $finish;
    end
endmodule

module rca_tb;
    reg [3:0]x;
    reg [3:0]y;
    reg ci;
    wire cout;
    wire [3:0]s;
    RCA RCAtb(x,y,ci,cout,s);
    initial begin
        $monitor(x,y,ci,cout,s);
        for (integer i=0; i<512; i=i+1)
        begin
            {x,y,ci} = i;
            #10;
        end
        $finish;
    end
endmodule

module parametric_rca_tb;
    parameter size = 4;
    reg [(size-1):0]x;
    reg [(size-1):0]y;
    reg ci;
    wire cout;
    wire [(size-1):0]s;
    parametric_RCA pRCAtb(x,y,ci,cout,s);
    initial begin
        $monitor(x,y,ci,cout,s);
        for (integer i=0; i<512; i=i+1) begin //for 4
        //for (integer i=0; i<131072; i=i+1) begin //for 8
            {x,y,ci} = i;
            #10;
        end
        $finish;
    end
endmodule

module cla_tb;
    reg [3:0]x;
    reg [3:0]y;
    reg ci;
    wire cout;
    wire [3:0]s;
    CLA CLAtb(x,y,ci,cout,s);
    initial begin
        $monitor(x,y,ci,cout,s);
        for (integer i=0; i<512; i=i+1) begin
            {x,y,ci} = i;
            #10;
        end
        $finish;
    end
endmodule

module Add_Sub_tb;
    reg [3:0]A;
    reg [3:0]B;
    reg carry;
    wire Cout;
    wire [3:0]SUM;
    wire V;
    Add_Sub astb(A,B,carry,SUM,Cout,V);
    initial begin
        $monitor(A,B,carry,Cout,SUM,V);
        for (integer i=0; i<512; i=i+1) begin
            {A,B,carry} = i;
            #2;
        end
        $finish;
    end
endmodule