`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2023 06:02:48 PM
// Design Name: 
// Module Name: design2_tb
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


module design2_tb();

parameter integer C_S_AXIS_TDATA_WIDTH = 32;

wire [C_S_AXIS_TDATA_WIDTH-1:0]  M_AXIS_tdata;
wire M_AXIS_tlast;
reg M_AXIS_tready;
wire [C_S_AXIS_TDATA_WIDTH/8-1:0]    M_AXIS_tstrb;
wire M_AXIS_tvalid;
reg [C_S_AXIS_TDATA_WIDTH-1:0] S_AXIS_tdata;
reg S_AXIS_tlast;
wire S_AXIS_tready;
reg [C_S_AXIS_TDATA_WIDTH/8-1:0]S_AXIS_tstrb;
reg S_AXIS_tvalid;
reg m_axis_aclk;
reg m_axis_aresetn;
reg s_axis_aclk;
reg s_axis_aresetn;
reg tx_done;

reg clk;
reg resetn;

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end



initial begin
//	M_AXIS_tready		    =	0;
//	#200	M_AXIS_tready	=	1;
//	#6000	M_AXIS_tready	=	0;
//	#200	M_AXIS_tready	=	1;
    resetn 		= 	0;
	#100 resetn	=	1;
    tx_done = 0;
    S_AXIS_tdata    =   32'habcdef01;
    S_AXIS_tvalid   =   1;
    #6000;
    tx_done = 1;
end




design_2_wrapper dut
   (.M_AXIS_tdata(M_AXIS_tdata),
    .M_AXIS_tlast(M_AXIS_tlast),
    .M_AXIS_tready(M_AXIS_tready),
    .M_AXIS_tstrb(M_AXIS_tstrb),
    .M_AXIS_tvalid(M_AXIS_tvalid),
    .S_AXIS_tdata(S_AXIS_tdata),
    .S_AXIS_tlast(S_AXIS_tlast),
    .S_AXIS_tready(S_AXIS_tready),
    .S_AXIS_tstrb(S_AXIS_tstrb),
    .S_AXIS_tvalid(S_AXIS_tvalid),
    .m_axis_aclk(clk),
    .m_axis_aresetn(resetn),
    .s_axis_aclk(clk),
    .s_axis_aresetn(resetn),
    .ch1_tx_done(tx_done)
    );
    
    
endmodule
