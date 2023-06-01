Make sure to use the correct byte alignments in the software project.

For 32 bit AXI bus width (Single processing channel) UDP packet length is 1024 + 4 bytes, the AXI DMA receive buffer is (RxBufferPtr + 1) leave the first word for the index. For the transfer size always put in 1024.
Similarly increase the RX pointer while keeping DMA packet size at 1024.
Second third and fourth words contain unwanted garbage data, however they should be skipped in DMA transfer to align the transfers, maybe at a later stage can be used to contain chirp index, RX channel , RX profile, etc.
