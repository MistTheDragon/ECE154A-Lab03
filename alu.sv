module alu(input [31:0] a, b,
    input [2:0] f,
    output [31:0] result,
    output zero,
    output overflow,
    output carry,
    output negative);

    thirtytwoBitAdder adder(a,b, f[0], result, carry);
    
    always @(a, b) begin
        
    end

    always @(a, b, f) begin

        case (f)
            3'b000: 
            // AND
            3'b001: result = a | b; // OR
            3'b010: {carry, result} = a + b; // ADD
            3'b110: {carry, result} = a - b; // SUB
            3'b111: result = (a < b) ? 1 : 0; // SLT
            default: result = 32'b0; // Default case
        endcase
    end


endmodule
