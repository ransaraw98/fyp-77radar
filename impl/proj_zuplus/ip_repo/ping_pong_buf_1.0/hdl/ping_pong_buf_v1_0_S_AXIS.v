
`timescale 1 ns / 1 ps

	module ping_pong_buf_v1_0_S_AXIS #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// AXI4Stream sink: Data Width
		parameter integer C_S_AXIS_TDATA_WIDTH	= 32,
		parameter integer NUM_SIGNALS	= 32,
		parameter integer NUM_SAMPLES	= 8,
		
		parameter integer RAM_ADDRW   =   4,
		parameter integer RAM_DEPTH   =   16
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line

		// AXI4Stream sink: Clock
		input wire  S_AXIS_ACLK,
		// AXI4Stream sink: Reset
		input wire  S_AXIS_ARESETN,
		// Ready to accept data in
		output wire  S_AXIS_TREADY,
		// Data in
		input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] S_AXIS_TDATA,
		// Byte qualifier
		input wire [(C_S_AXIS_TDATA_WIDTH/8)-1 : 0] S_AXIS_TSTRB,
		// Indicates boundary of last packet
		input wire  S_AXIS_TLAST,
		// Data is in valid
		input wire  S_AXIS_TVALID,
		//interface for the ram
        output     reg  RAM_WEN,
		output     reg  [RAM_ADDRW-1:0] RAM_WADDR,
		output     reg  [C_S_AXIS_TDATA_WIDTH-1:0] ch1_ram_din,
	    //interface for the MAXIS
	    output     reg  tx_en,
	    input      wire tx_done
	);
	
	reg    rx_done;
	reg    [RAM_ADDRW-1:0] write_ptr;
	reg    [RAM_ADDRW-1:0] write_count;
	// RESET
	always@(posedge    S_AXIS_ACLK)
	   if(!S_AXIS_ARESETN) begin
	       write_ptr   <=  {RAM_ADDRW{1'b0}};   //WRITE STARTS AT 0, MAXIS WAITS FOR THE FIRST FILL TO BE DONE
	       rx_done     <=  0;
	       write_count <=  0;
	       end
	
	// PING PONG CIRCUIT
	always@(posedge    S_AXIS_ACLK)
        if(rx_done  &&  tx_done)begin
            write_ptr   <=  write_ptr + RAM_DEPTH/2;
            write_count <=  0;
            rx_done     <=  0;
            end
//        else                                  //LATCH INFERENCE?
//            write_ptr   <=  write_ptr;
            
    // S_AXIS_TREADY circuit
    assign S_AXIS_TREADY    =   rx_done ? 0:1;
    
    //Data write circuit
    always@(posedge    S_AXIS_ACLK)
        if(S_AXIS_TREADY    && S_AXIS_TVALID) begin
                RAM_WEN     <=  1;
                RAM_WADDR   <=  write_ptr + write_count;
                ch1_ram_din <=  S_AXIS_TDATA;
                if(write_count == (RAM_DEPTH/2)-1)
                    rx_done <=  1;
                else    
                    begin
                    rx_done <=  0;
                    write_count <=   write_count + 1;  
                    end
                end
         else   
            begin
                RAM_WEN <=  0;
                RAM_WADDR   <=  RAM_WADDR;
                ch1_ram_din <=  ch1_ram_din;             
            end
 
    // tx_enable logic
    always@(posedge S_AXIS_ACLK)
        if((write_count  <   (RAM_DEPTH/2)-1)   &&  (tx_en == 0))
            tx_en   <=  1;
        else                        //once set will never trigger
            tx_en   <=  0;
	endmodule
