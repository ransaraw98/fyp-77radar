
`timescale 1 ns / 1 ps

	module fft_config_v1_0_M_AXIS #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		// Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.
		parameter integer C_M_START_COUNT	= 32,
		parameter [C_M_AXIS_TDATA_WIDTH-1:0] CONFIG_DATA = 8'd87
	)
	(
		// Users to add ports here

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
		// TREADY indicates that the slave can accept a transfer in the current cycle.
		input wire  M_AXIS_TREADY
	);
reg [C_M_AXIS_TDATA_WIDTH-1:0] tdataR = 0;
reg tvalidR = 0;
reg tf_done = 0;
reg tvalidRdel = 0;

assign M_AXIS_TVALID = (tvalidRdel && !tf_done);
assign M_AXIS_TDATA =   tdataR;


always@(negedge M_AXIS_ACLK)
    tvalidRdel <= tvalidR;
    
//wait C_M_START_COUNT                                              
reg [7:0] start_count = 0; //max 255

always@(posedge M_AXIS_ACLK)begin
    start_count <= start_count + 1;
    if(start_count == (C_M_START_COUNT-1))begin
        tvalidR <= 1;
        tdataR <= CONFIG_DATA;
        end
    else if (tf_done == 1)
        tvalidR <=  0;
    
end

always@(negedge M_AXIS_ACLK)begin
    if(M_AXIS_TVALID && M_AXIS_TREADY)begin
        tf_done <= 1;
    end
end
	endmodule
