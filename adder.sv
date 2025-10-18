// SystemVerilog version of inverter
timeunit 1ns; timeprecision 1ps;

module inverter (
    input  logic in,
    output logic out
);
    // Combinational inversion
    assign out = ~in;
endmodule

module fullAdder(a, b, cin, s, cout);
    input wire a, b, cin;
    output wire s, cout;

    assign s = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

module fourBitAdder(
    input wire [3:0] a, b,
    input wire cin,
    output wire [3:0] s,
    output cout);
    wire c1, c2, c3;

    fullAdder fa0(a[0], b[0], cin, s[0], c1);
    fullAdder fa1(a[1], b[1], c1, s[1], c2);
    fullAdder fa2(a[2], b[2], c2, s[2], c3);
    fullAdder fa3(a[3], b[3], c3, s[3], cout);
endmodule

module thirtytwoBitAdder(
    input wire [31:0] a, b,
    input wire cin,
    output wire [31:0] s,
    output cout);

    wire [3:0] c1, c2, c3, c4, c5, c6, c7;

    fourBitAdder fa0(a[3:0], b[3:0], cin, s[3:0], c1);
    fourBitAdder fa1(a[7:4], b[7:4], c1, s[7:4], c2);
    fourBitAdder fa2(a[11:8], b[11:8], c2, s[11:8], c3);
    fourBitAdder fa3(a[15:12], b[15:12], c3, s[15:12], c4);
    fourBitAdder fa4(a[19:16], b[19:16], c4, s[19:16], c5);
    fourBitAdder fa5(a[23:20], b[23:20], c5, s[23:20], c6);
    fourBitAdder fa6(a[27:24], b[27:24], c6, s[27:24], c7);
    fourBitAdder fa7(a[31:28], b[31:28], c7, s[31:28], cout);

endmodule

module fullInverter
     (
    input  logic [31:0] in,
    output logic [31:0] out
);
    // Combinational inversion
    assign out = ~in;
endmodule