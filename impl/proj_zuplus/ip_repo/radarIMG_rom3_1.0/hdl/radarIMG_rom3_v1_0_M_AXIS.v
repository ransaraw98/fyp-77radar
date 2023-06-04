
`timescale 1 ns / 1 ps

	module radarIMG_rom3_v1_0_M_AXIS #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		// Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.
		parameter integer C_M_AXIS_START_COUNT	= 32,
		parameter integer ADDRW = 14
	)
	(
		// Users to add ports here

		// User ports ends
		output reg rom_en_out,
		input [C_M_AXIS_TDATA_WIDTH-1:0] data_in,
		output wire [ADDRW-1:0]addr_out,
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

reg [ADDRW-1:0] countR1;
reg [ADDRW-1:0] countR2;
//reg [6:0] countR2;
reg tvalidR;
assign M_AXIS_TDATA = data_in;
assign M_AXIS_TSTRB = {(C_M_AXIS_TDATA_WIDTH/8){1'b1}};

always@(posedge M_AXIS_ACLK)begin           //ASYNC RESET
    if(!M_AXIS_ARESETN)
        countR1 <= {ADDRW{1'b0}};
    else
        countR1 <= countR1 + 1;
end
 
always@(posedge M_AXIS_ACLK)
    if(!M_AXIS_ARESETN) begin
        tvalidR <= 0;
        rom_en_out <= 0;
        //countR2 <= 0;
        end
    else if(countR1 == C_M_AXIS_START_COUNT)
        begin
        tvalidR <= 1;
        rom_en_out <= 1;
        //countR2    <=countR2 + 1;
        end     
 
 reg tvalidRdel;
 
 always@(negedge M_AXIS_ACLK)
    if(!M_AXIS_ARESETN)
        tvalidRdel <= 0;
    else
        tvalidRdel <= tvalidR;
 
 assign M_AXIS_TVALID = tvalidRdel;
 reg [C_M_AXIS_TDATA_WIDTH-1:0] transferCount;
 
 always@(posedge M_AXIS_ACLK)
    if(!M_AXIS_ARESETN)begin
        countR2 <= 0;
        transferCount <= 0;
        end
    else if((tvalidR == 1) && (M_AXIS_TREADY == 1))begin
        countR2    <=   countR2 + 1;
        if(transferCount == 63)
            transferCount <= 0;
        else
            transferCount <= transferCount + 1;
        end
    else 
        countR2     <= countR2;     // LATCH!
            
    
 assign addr_out = countR2;
 assign M_AXIS_TLAST = (transferCount == 63)?1:0;


	endmodule
