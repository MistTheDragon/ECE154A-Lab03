// SystemVerilog testbench for inverter
timeunit 1ns; timeprecision 1ps;

module alu_tb;

    // 16 entries, each 1-bit wide (alternating input and expected output)
    bit test_data [0:183];

    logic[31:0] test_a, test_b;
    logic[2:0] test_f;
    logic[31:0] test_result;
    bit test_zero;
    bit test_overflow;
    bit test_carry;
    bit test_negative;

    // DUT
    alu dut (.a(test_a), 
             .b(test_b),
             .f(test_f),
             .zero(test_zero), 
             .overflow(test_overflow), 
             .carry(test_carry),
             .negative(test_negative),
             .result(test_result));

    initial begin
        // Read hex values from file (0/1), pairs of (input, expected)
        $readmemh("alu.tv", data);

        // Initialize
        test_a = '0;
        test_b = '0;
        test_f = '0;
        test_carry = 0;
        test_negative = 0;
        test_overflow = 0;
        test_result = '0;
        test_zero = 0;

        // Apply stimulus and check results
        for (i = 0; i < 23; i++) begin
            pos = i * 8;
            test_a = test_data[pos];
            test_b = test_data[pos + 1];
            test_f = test_data[pos + 2];

            desired_carry = test_data[pos + 3];
            desired_negative = test_data[pos + 4];
            desired_overflow = test_data[pos + 5];
            desired_result = test_data[pos + 6];
            desired_zero = test_data[pos + 7];

            #1;
            if ((desired_carry === test_carry) && (desired_negative === test_negative) && (desired_overflow === test_overflow) && (desired_result === test_result) && (desired_zero === test_zero)) begin
                $display("a: %0h, b: %0h, result: %0h, carry: %0h, negative: %0h, overflow: %0h, result: %0h, zero: %0h --> PASS", test_a, test_b, test_result, test_carry, test_negative, test_overflow, test_zero);
            end else begin
                $$display("a: %0h, b: %0h, result: %0h, carry: %0h, negative: %0h, overflow: %0h, result: %0h, zero: %0h --> FAIL", test_a, test_b, test_result, test_carry, test_negative, test_overflow, test_zero);
            end
        end
        $finish;
    end
endmodule

