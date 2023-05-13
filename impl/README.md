The custom made IPs are in the proj_zuplus/ip_repo/.
The software are block designs for all the other important projects are located in the sw folder.
sgen_udp_zuplus -> sample generator connected to the ping pong buffer streaming to PS via DMA.
simple intr_zuplus -> axi_dma loopback and stream through UDP.

Create a Vivado project with ZCU106.
Source the block diagram tcl.
Generate bitstream and export to SDK.
Create the project with relevant libraries included (eg lwip).
Replace the source files with the files from the sw/project_name folder.
In Xilinx SDK you need to create a FSBL project first, use it to reset the whole system and program the FPGA with bitstream. Then from the application run/debug settings, exclude psu_init and reset checkboxes.

