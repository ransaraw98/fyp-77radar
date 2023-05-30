`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2023 04:31:29 PM
// Design Name: 
// Module Name: tb
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


module tb(

    );
    parameter integer M_AXIS_TDATA_WIDTH = 32;
    parameter integer ADDRW = 14;
    
 wire [M_AXIS_TDATA_WIDTH-1:0] M_AXIS_tdata;
 wire M_AXIS_tlast;
 reg M_AXIS_tready; 
 wire [M_AXIS_TDATA_WIDTH/8 - 1 : 0] M_AXIS_tstrb;
 wire M_AXIS_tvalid;
 reg clk;
 reg aresetn;
 
 initial begin
 clk = 0;
    forever #5 clk = ~clk;
 end
 
 initial begin
 aresetn = 1;
 M_AXIS_tready = 0;
 #5;
 aresetn    = 0;
 #20
 aresetn = 1;
 M_AXIS_tready = 1;
 #481
 M_AXIS_tready = 0;
 #10
 M_AXIS_tready = 1;
 
 end
 design_1_wrapper dut
   (
    .M_AXIS_tdata(M_AXIS_tdata),
    .M_AXIS_tlast(M_AXIS_tlast),
    .M_AXIS_tready(M_AXIS_tready),
    .M_AXIS_tstrb(M_AXIS_tstrb),
    .M_AXIS_tvalid(M_AXIS_tvalid),
    .m_axis_aclk(clk),
    .m_axis_aresetn(aresetn)
    );
endmodule
