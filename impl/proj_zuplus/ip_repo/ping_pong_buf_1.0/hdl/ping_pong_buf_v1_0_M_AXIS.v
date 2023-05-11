
`timescale 1 ns / 1 ps

	module ping_pong_buf_v1_0_M_AXIS #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		// Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.
		parameter integer C_M_START_COUNT	= 32,
		parameter integer RAM_ADDRW   =   9,
		parameter integer RAM_DEPTH   =   512
	)
	(
		// Users to add ports here
        input [C_M_AXIS_TDATA_WIDTH-1:0] ch1_ram_dout,      //dout from ram, input to the module
        input rx_done,
        input tx_en,
        output reg tx_done,
        output reg RAM_EN,
        output reg [RAM_ADDRW-1:0] RAM_RADDR,   
		// User ports ends
		// Do not modify the ports beyond this line

		// Global ports
		input wire  M_AXIS_ACLK,
		// 
		input wire  M_AXIS_ARESETN,
		// Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
		output wire  M_AXIS_TVALID,
		// TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
		// TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
		// TLAST indicates the boundary of a packet.
		output wire  M_AXIS_TLAST,
		// TREADY indicates that the slave can accept a transfer in the current cycle.
		input wire  M_AXIS_TREADY
	);
	
	// Add user logic here
    reg [RAM_ADDRW-1:0]read_ptr;
    reg [RAM_ADDRW-1:0]read_count;
    //reg tvalidR;
    reg tlastR;
    reg [C_M_AXIS_TDATA_WIDTH-1:0] tdataR;
    
    //assign M_AXIS_TVALID    =   tvalidR;
    assign M_AXIS_TLAST     =   tlastR;
    assign M_AXIS_TDATA     =   ch1_ram_dout;
    assign M_AXIS_TSTRB	=	{(C_M_AXIS_TDATA_WIDTH/8){1'b1}};
    
    //Reset
    always@(posedge M_AXIS_ACLK)        //shouldve been asynchronous reset actually
        if(!M_AXIS_ARESETN) begin
            read_ptr    <=  RAM_DEPTH/2;    //{RAM_ADDRW{1'b0}};
            read_count  <=  {RAM_ADDRW{1'b0}};
            //tvalidR     <=  0;
            tlastR      <=  0;
            tx_done     <=  1;
            //RAM_RADDR   <=  0;
            RAM_EN      <=  0;
            end
    
    //Ping pong circuit
    always@(posedge M_AXIS_ACLK)
        if(rx_done  &&  tx_done)begin
            read_ptr    <=  read_ptr   +    RAM_DEPTH/2 ;
            read_count  <=  0;
            tx_done     <=  0;
            end
            
    //DATA read circuit
    always@(posedge M_AXIS_ACLK)
        if(M_AXIS_TVALID    &&  M_AXIS_TREADY)begin
            RAM_RADDR   <=  read_ptr    +   read_count;
            RAM_EN      <=  1;
            tdataR      <=  ch1_ram_dout;       //dout wrt to RAM, input to the master interface
            if(read_count   ==  (RAM_DEPTH/2))
                tx_done <=  1;
            else
                begin
                tx_done <=  0;
                read_count  <=  read_count  +   1;
                end
            end
        else    
            begin
                RAM_EN      <=  0;
                RAM_RADDR   <=  RAM_RADDR;  //latch inference?
                tdataR      <=  tdataR;           
            end
            
    // TVALID circuit
//    always@(posedge M_AXIS_ACLK)
//        if(tx_en    &&  !tx_done)
//            tvalidR <=  1;
//        else
//            tvalidR <=  0;
    assign M_AXIS_TVALID    =   (tx_en  && !tx_done)?1:0;    
        
    //TLAST circuit
    always@(posedge M_AXIS_ACLK)
        if(read_count   ==  (RAM_DEPTH/2))
            tlastR  <=  1;
        else
            tlastR  <=  0;
	// User logic ends

	endmodule
