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
 read_verilog pes_bupc.v
 synth -top pes_bupc
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/43986d64-10aa-44eb-bd35-c1fb8c108619)

Generate the netlist
and display the design using the following command

abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

To generate the netlist file we must type the command
type show to see the netlist
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/cf04286d-f1ed-44c3-976d-b3620865ecfb)

write_verilog -noattr pes_bupc_net.v
Now using the netlist file, we verify the waveform once more

    Now we type ./a.out to generate the .vcd file.
![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/dd904d59-9f87-48f2-b370-d76839c6b792)


    Ongoing, having a few errors generating netlist
    To see the waveform we type the command

gtkwave pes_bupc_tb.vcd

![image](https://github.com/aaronghosh/pes_bupc/assets/124378527/e3933356-efc9-4305-87b9-97670ea2ee8c)
we find that the waveforms are matching and hence the rtl snthesis is done
