module pes_bupc_tb;

    reg Clock;
    reg Reset;
    wire [3:0] Count_out;

    // Instantiate the Binary Up Counter module
    pes_bupc dut (
        .Clock(Clock),
        .Reset(Reset),
        .Count_out(Count_out)
    );

    // VCD configuration
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

    // Clock generation
    always begin
        #5 Clock = ~Clock; // Generate a 10ns clock signal
    end

    initial begin
        Clock = 0;
        Reset = 0;

        // Reset the counter initially
        Reset = 1;
        #20 Reset = 0;

        // Monitor the Count_out and display the count
        $display("Time = %0t, Count_out = %b", $time, Count_out);

        // Toggle Reset and observe the counter
        #20 Reset = 1;
        $display("Time = %0t, Count_out = %b", $time, Count_out);

        #20 Reset = 0;

        // Count for a few clock cycles
        repeat (10) begin
            $display("Time = %0t, Count_out = %b", $time, Count_out);
            #10;
        end

        // Finish the simulation
        $finish;
    end

endmodule
