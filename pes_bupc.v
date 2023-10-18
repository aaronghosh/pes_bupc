module pes_bupc(
    Clock,
    Reset,
    Count_out
    );

    input Clock;      // Clock input
    input Reset;      // Reset input
    output [3:0] Count_out;  // 4-bit binary count output

    reg [3:0] Count_temp; // Internal 4-bit counter variable

    always @(posedge Clock or posedge Reset) begin
        if (Reset == 1'b1) begin
            // When Reset is high, reset the count to "0000".
            Count_temp <= 4'b0000;
        end else if (Clock == 1'b1) begin
            // When the Clock is high, increment the count.
            Count_temp <= Count_temp + 1;
        end
    end

    // The Count value is assigned to the final output port.
    assign Count_out = Count_temp;

endmodule
