// SystemVerilog testbench for inverter
timeunit 1ns; timeprecision 1ps;

module inverter_tb;

    // 16 entries, each 1-bit wide (alternating input and expected output)
    bit data [0:15];

    logic in;
    logic out;
    bit   check;
    int   i;

    // DUT
    inverter dut (.in(in), .out(out));

    initial begin
        // Read hex values from file (0/1), pairs of (input, expected)
        $readmemh("inverter.tv", data);

        // Initialize
        in    = '0;
        check = '0;

        // Apply stimulus and check results
        for (i = 0; i < 15; i += 2) begin
            in    = data[i];
            check = data[i+1];
            #1;
            if (out === check) begin
                $display("in: %0d, out: %0h, expect: %0h --> PASS", in, out, check);
            end else begin
                $display("in: %0d, out: %0h, expect: %0h --> FAIL", in, out, check);
            end
        end
        $finish;
    end
endmodule

