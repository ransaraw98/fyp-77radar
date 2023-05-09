`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2023 07:05:57 PM
// Design Name: 
// Module Name: sample_gen_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sample_gen_tb();


wire	[127:0] 	M_AXIS_tdata;
wire			M_AXIS_tlast;
reg			M_AXIS_tready;
wire	[15:0]		M_AXIS_tstrb;
wire			M_AXIS_tvalid;
reg     [10:0]  PACKET_SIZE;

reg 			clk;
reg 			resetn;

initial begin
    PACKET_SIZE = 16;
end

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	resetn 		= 	0;
	#100 resetn	=	1;
end

initial begin
	M_AXIS_tready		=	0;
	#200	M_AXIS_tready	=	1;
	#6000	M_AXIS_tready	=	0;
	#200	M_AXIS_tready	=	1;
end

design_1_wrapper dut
   (.M_AXIS_tdata(M_AXIS_tdata),
    .M_AXIS_tlast(M_AXIS_tlast),
    .M_AXIS_tready(M_AXIS_tready),
    .M_AXIS_tstrb(M_AXIS_tstrb),
    .M_AXIS_tvalid(M_AXIS_tvalid),
    .m_axis_aclk(clk),
    .m_axis_aresetn(resetn),
    .PACKET_SIZE(PACKET_SIZE));
		
		
		
		



endmodule
