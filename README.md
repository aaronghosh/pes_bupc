# pes_binary_up_counter

Using iverilog to compile all the codes

run using ./a.out
and use gtkwave
![image](https://github.com/aaronghosh/pes_uart/assets/124378527/d91a1ed8-e67c-4d56-b3c5-2e7f73ad05f2)

with gtkwave
![image](https://github.com/aaronghosh/pes_uart/assets/124378527/3f9b6e5b-ec70-487a-b879-dab94da6ad35)

# RTL Synthesis

Invoke using Yosys
![image](https://github.com/aaronghosh/pes_uart/assets/124378527/6d560e08-3871-4c47-8814-7f6a877c0539)

 read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
 read_verilog ring_counter.v
 synth -top ring_counter

Generate the netlist
and display the design using the following command

abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/23fa9c79-46d8-4e83-bc5f-463860b7be95)

To generate the netlist file we must type the command

write_verilog -noattr pes_bupc_net.v
Now using the netlist file, we verify the waveform once more
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/0102de2d-ef70-4705-acd7-e54b58c5cb18)


    Now we type ./a.out to generate the .vcd file.


    Ongoing, having a few errors generating netlist
    To see the waveform we type the command

gtkwave pes_bupc_tb.vcd

