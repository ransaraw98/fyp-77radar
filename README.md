# FYP 22/23 - Scalable 77 GHz Digital Array for Autonomous Robotics

```Final demonstrated design is in the branch``` **radar3_rom_ip**.

Tool versions
- **Vivado 2019.1**
- **Xilinx SDK 2019.1**
- **Python 3.9.2**
- **MATLAB R2022b**
- **ZCU106 development kit Rev 1.0**
#### Radar signal processing chain 
![RSP_rev4_0](https://github.com/ransaraw98/fyp-77radar/assets/42471129/892d2f83-49bb-425d-94eb-fb11bd2d263c)

#### How to deploy the design
Due to a hardware upgrade in the latest ZCU 106 development kits you are required to create a FSBL project and run it before running any application projects. Details are as follows. The issue it due to the new RAM banks having a different arrangement than the previous revisions of the board.
See https://support.xilinx.com/s/article/71961?language=en_US for more details.
1. Switch to ```radar3_rom_ip```.
2. Create a vivado project in a suitable location.
3. Add user IP repository ```/impl/proj_zuplus/ip_repo``` to the project from ```Tools -> Settings```.
4. Select the design you wish to deploy from ```impl/sw```.
5. Source the block design from TCL console. 
 Example - ```source impl/chain_test/doppler_fft/doppler_fft_4channels.tcl```
 Vivado will create the block design with all the connections, you may need to create the top HDL wrapper.
 6. Generate bitstream, Vivado will generate output products for the blocks run synthesis and implementation and write bitstream.
 7. Open the implemented design.
 8. With the implemented design open, export the hardware from ```File menu -> Export -> Export Hardware```. (Choose a preferred location or use the default location) Make sure to check Include Bitstream if you wish to program the FPGA bitstream using the Xilinx SDK.
 9. Lauch Xilinx SDK. ```File Menu -> Launch SDK```. Xilinx SDK will launch and create a Hardware platform project using the hardware description file. Wait for it to finish.
 10. Create a new First Stage Bootloader project for the hardware platform, it requires its own Board Support Package BSP as well.
 11. Once created right click on the newly created FSBL project and select Run As -> Run Configurations. Create a new run configuration under Xilinx C/C++ Application (GDB).
 12. On the right pane, under target setup mark the checkboxes as follows.
  ![image](https://github.com/ransaraw98/fyp-77radar/assets/42471129/ddcc5580-9922-4272-a51c-8f95583a19a6)
 13. Apply and close the window, do not run the project yet.
 14. Next create another application project, it will require its own BSP as well. Furthermore make sure to select the UDP perf client example from the examples.
 15. Once the project has been created delete all the source files in the _src_ folder and copy the source files from the git repository path ```impl/sw/<selected project name>/src folder```.
  Some projects may have main.c included in build, make sure to exclude it by righ clicking on the main.c file from the project explorer and selecting  Resource configurations -> Exclude from Build.
  16. Make sure to increase the heap and stack sizes for the application project by right clicking on the ```project -> Generate linker script```. The designs require at least 1MB of heap and stack.
  17. Similarly for the application project create a run or debug configuration with the options selected as follows.
  ![image](https://github.com/ransaraw98/fyp-77radar/assets/42471129/4c555198-22c1-4b07-9d3e-942912ab72ad)
  Make sure to clean the project before proceeding. It will synchronize the project with the BSP.
If your creating a debug configuration, always choose Xilinx System Debugger. Do not launch the configuration yet.
  18. Run the FSBL projet previously created by right clicking on it and selecting ```Run As -> Launch on Hardware GDB```. It will reset the whole system, upload the bitstream and launch the FSBL project.
  19. Next launch the application project with the previously configured run configuration.
  20. On the host computer make sure the Gigabit Ethernet Adapter is connected and configured with the IP address ```192.168.1.100```. 
  21. Launch the correct python script to visualize the data.
  Example from the path ```impl/host/python/4ch``` run command ```python frame_continuous.py```.
  
  #### Custom IP information
  There are several AXI stream interfaced custom IP blocks in impl/proj_zuplus/ip_repo.
  
1.PingPong buffer.
  A double buffer with independent master and slave interfaces to handle rate changes. Can also be used to packetize data for DMA transfers with Xilinx AXI-DMA IP.
  ![image](https://github.com/ransaraw98/fyp-77radar/assets/42471129/32980665-a296-4657-87cf-88adb66e6d09)
  
  The AXI stream width must be of multiples of the width of I & Q sample width. For example if you choose a single channel mode with 16 bits sample width, then select 32 bits AXI stream width, 64 if 2 channels with same sample width and 128 for four channels.
  <img src="https://github.com/ransaraw98/fyp-77radar/assets/42471129/37ca8a37-370c-45a3-90c9-0874489816e1" width="200" height="400">
  ![M_AXIS_state_diagram_1](https://github.com/ransaraw98/fyp-77radar/assets/42471129/0b23e8b9-6764-43a1-a217-c7fe78b077d6)

Please refer to the tooltips in the customization parameters for more details.
  
 2. Rearrange buffer
  A double bufer used for feeding the data across the next dimension of the 2D array.
![image](https://github.com/ransaraw98/fyp-77radar/assets/42471129/ce443e1a-54b2-403d-b050-4798f0b107af)

 3.  Radar IMG ROM
  Contains MATLAB phased array toolbox generated radiator data, arranged in correct I & Q format to be fed into the FFT cores.
  
 4. SGEN_cyclic & buffer1_1.0 
  AXI stream interfaced IP blocks used to test the design. The Cyclic IP can generate samples periodically and the buffer1_1.0 can generate samples at each posedge clock. Mostly used to benchmark the system.
 
  #### MATLAB simulation scripts
  Use the script fyp-77radar\simulation\matlab\fmcw-mimo\microstrip\MIMORadarVirtualArrayExample.m to generate the source data.
  Use one of the scripts in impl/host to write the data to text files in order to be included in the ROMs. For example the final design uses the _cubeProcess.m_ script.
