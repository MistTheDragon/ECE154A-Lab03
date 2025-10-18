timeunit 1ns; timeprecision 1ps;

module alu(input wire [31:0] a, b,
    input wire [2:0] f,
    output wire [31:0] result,
    output wire zero,
    output wire overflow,
    output wire carry,
    output wire negative);

    wire [31:0] b_signed, and_out, or_out, add_out, sub_out, slt_out;
    wire carry_result, overflow_result;
    compliment comb(.active(f[0]), .in(b), .out(b_signed));
    thirtytwoBitAdder adder(a,b_signed, f[0], add_out, carry_result);
    andGate andg(a, b, and_out);
    orGate org(a, b, or_out);
    assign zero = (result == 32'b0);
    assign negative = result[31];

    always @(a, b) begin
        // Update the zero, overflow, and negative flags
        overflow_result = ((add_out[31] ^ a[31]) & ((a[31] ^ b[31]) ^ ~f[0]));
    end

    always @(f) begin
        case (f[1])
           1'b0: begin 
                carry = carry_result;
                overflow = overflow_result;
           end
           1'b1: begin 
                carry = 0;
                overflow = 0;
           end
        endcase

        case (f)
            3'b010: begin // AND
                result = and_out;
            end
            
            3'b011: begin // OR
                result = or_out;
            end
            3'b000: begin
                result = add_out; // ADD
            end
            3'b001: begin // SUB
                result = add_out; 
            end
            3'b101: begin // SLT
                result[31:1] = 31'b0; 
                result[0] = (add_out[31] ^ overflow);
            end
            default: result = 32'b0; // Default case
        endcase
    end


endmodule
