# pes_binary_up_counter

![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/8825bf25-0567-4c50-a083-56a2572dc8c0)


## Introduction

A binary up counter is a fundamental digital circuit used in various applications to count upwards in binary form. It is an essential component in digital electronics, serving as a simple yet versatile tool for tasks such as clock signal generation, data sequencing, and more.

### What is a Binary Up Counter?

- **Counting in Binary**: The binary up counter represents numbers in binary format, using flip-flops or registers to store each bit of the count. For instance, in a 4-bit binary up counter, you can count from 0000 to 1111 in binary, which is equivalent to 0 to 15 in decimal.

- **Sequential Counting**: The counter increments by one with each clock pulse, making it a sequential or synchronous counter. It follows a specific counting sequence, making it suitable for tasks that require precise counting operations.

- **Parallel Outputs**: A binary up counter has parallel output lines, where each output bit corresponds to a specific count value. These outputs can be used to trigger other digital logic components or as data inputs for further processing.

- **Applications**: Binary up counters are widely used in digital systems for various purposes, such as timekeeping (e.g., digital clocks), data multiplexing, memory addressing, and more. They play a crucial role in dividing or scaling clock frequencies and generating precise timing signals.

## Understanding Binary Up Counters

Before diving into RTL synthesis and GDS generation, it's essential to have a clear understanding of how binary up counters work and their role in digital circuit design. This knowledge will guide you in designing and implementing your binary up counter efficiently.

## Start RTL to GDS flow

```
   gedit pes_bupc.v
```
This is the pes_bupc main module


```
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
```

```
gedit pes_bupc_tb.v
```

this is the pes_bupc_tb code
```
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


```
Using iverilog to compile all the codes
```iverilog pes_bupc.v pes_bupc_tb.v```
run using ```./a.out```

![image](https://github.com/aaronghosh/pes_uart/assets/124378527/d91a1ed8-e67c-4d56-b3c5-2e7f73ad05f2)

and use gtkwave to view the waveform using the command
``` gtkwave pes_bupc_tb.v ```
![image](https://github.com/aaronghosh/pes_uart/assets/124378527/3f9b6e5b-ec70-487a-b879-dab94da6ad35)

# RTL Synthesis

Invoke using Yosys
```yosys```
![image](https://github.com/aaronghosh/pes_uart/assets/124378527/6d560e08-3871-4c47-8814-7f6a877c0539)

Put the sky130 file in the same directory as your verilog codes
```
 read_liberty -lib sky130_fd_sc_hd__tt_025C_1v80.lib
 read_verilog pes_bupc.v
 synth -top pes_bupc
```
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/43986d64-10aa-44eb-bd35-c1fb8c108619)

Generate the netlist 
and display the design using the following command
```
abc -liberty sky130_fd_sc_hd__tt_025C_1v80.lib
```
Ensure your files are in the same directory
To generate the netlist file we must type the command in yosys
```
write_verilog -noattr pes_bupc_net.v
```
type ```show``` to see the netlist
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/cf04286d-f1ed-44c3-976d-b3620865ecfb)

# GLS
Now using the netlist file, we verify the waveform once more
To do this we run the following command ensuring everything is in the same directory
```iverilog primitives.v sky130_fd_sc_hd.v pes_bupc_net.v pes_bupc_tb.v
```
    Now we type ```./a.out``` to generate the .vcd file.
    
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/dd904d59-9f87-48f2-b370-d76839c6b792)

    To see the waveform we type the command

gtkwave dump.vcd

![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/e3933356-efc9-4305-87b9-97670ea2ee8c)
we find that the waveforms are matching and hence the rtl snthesis is done

# Physical Design
navigate to Openlane's design folder using ```cd Openlane/designs```.
In this directory, make another directory which will be your design directory. 
use
``` mkdir pes_bupc ```
In pes_bupc, write a config.json file. 
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/d0a9fe2b-2ead-481d-8ba2-7bc8e2281b23)


in openlane directory,
run the following commands
```make mount```
```./flow.tcl -interactive```
open openlane packages
```package require openlane 0.9```
flow.tcl

![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/43f9e50f-40b9-4fac-9498-e9774c263ee0)

# prep design
```prep -design pes_bupc```


![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/fc4cef6d-4e07-4f8e-8878-462344f4bfd8)


use the command
run_synthesis


![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/448c3cae-0e7b-4c75-90c7-ecfb7fe6d639)

the synthesis reports are given below

![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/be5afe1a-bd7d-4f1b-b012-5eaaa70abfa2)

![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/af44c73b-0615-4927-addc-4f252b4d186f)


use run_floorplan

![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/874e5a86-0ed8-4b93-82b3-b2b01ab2ef75)

Floorplan results are given below

![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/6fd9d31c-c56a-44fb-8795-af9968af78bc)

Checking in the OpenLane/designs/pes_bupc/runs/RUN_2023.11.03_12.06.52/results/floorplan directory if a .def file exists.


![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/b96c9e91-fbce-4966-b0fc-60d67fcf542b)


# placement
make sure your project is in the right directory.
then run the magic command
```magic -T /home/Desktop/Downloads/sky130A.tech lef read ../../tmp/merged.nom.lef def read pes_bupc.def &```


```run_placement```

![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/4753131f-a4b5-4bb4-95a7-77a636cd1c4d)
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/907ea2c4-2e90-4724-999d-bb9488a7e6a3)
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/7670aa48-9eb2-4608-9875-738b63bf8c5c)

# CTS
use the command ```run_cts```
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/d12e4a05-ce8f-4656-9f5e-fdfdc9e2511a)
Reports
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/d53067e1-0ff8-45fc-a371-09e6163e94b4)
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/3a18c94d-9eff-4ad2-a727-9bd818a2c3cc)

# Power Report

![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/a0deec43-2ce3-4947-ad7c-c558d6eb34ab)

# Area Report
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/f623fa37-1a79-4d44-b30a-4a7b878888fb)

# Skew Report
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/31623be2-6bed-4222-997a-cacfca2ac1bb)

# Statistics

   - Area = 947 um2
   - Internal Power = 2.04e-06 W
   - Switching Power = 5.61e-07
   - Leakage Power = 8.56e-11
   - Total Power = 2.72e-06
