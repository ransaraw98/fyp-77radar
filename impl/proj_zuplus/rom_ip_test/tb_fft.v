`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2023 03:36:52 PM
// Design Name: 
// Module Name: tb_fft
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


module tb_fft(

    );
    
 reg m_axis_aclk;
 reg m_axis_aresetn;   
 reg M_AXIS_DATA_tready;
    
    
initial begin
m_axis_aclk = 0;
forever #5 m_axis_aclk= ~m_axis_aclk;
end    
    
initial begin
m_axis_aresetn = 0;
M_AXIS_DATA_tready = 0;
#20
m_axis_aresetn = 1;
M_AXIS_DATA_tready = 1;    
#1875
m_axis_aresetn = 0;
M_AXIS_DATA_tready = 0;
#30
m_axis_aresetn = 1;
M_AXIS_DATA_tready = 1;
end
    
design_2_wrapper
   dut(
   .m_axis_aclk(m_axis_aclk),
    .m_axis_aresetn(m_axis_aresetn),
    .M_AXIS_DATA_tready(M_AXIS_DATA_tready)
    );
endmodule
