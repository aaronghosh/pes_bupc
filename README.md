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
