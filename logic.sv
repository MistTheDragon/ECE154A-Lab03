timeunit 1ns; timeprecision 1ps;

module andGate (
    input  logic [31:0] a,
    input  logic [31:0] b,
    output logic [31:0] result
);
    // Combinational AND
    assign result = a & b;

endmodule

module orGate (
    input  logic [31:0] a,
    input  logic [31:0] b,
    output logic [31:0] result
);
    // Combinational OR
    assign result = a | b;

endmodule

module compliment
     ( input wire active,
    input  logic [31:0] in,
    output logic [31:0] out
);
    // Combinational inversion
    assign out = active ? (~in + 1'b1) : in;
endmodule