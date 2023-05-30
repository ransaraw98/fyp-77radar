`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2023 10:20:37 PM
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


module tb();

 
    wire [31:0] M_AXIS_tdata;
    wire M_AXIS_tlast;
    reg M_AXIS_tready;
    wire M_AXIS_tstrb;
    wire M_AXIS_tvalid;
    
    wire [31:0] s_axis_tdata;
    reg s_axis_tlast;
    wire s_axis_tready;
    reg s_axis_tvalid;
    reg tx_en_temp;
    reg rx_done_temp;
    reg aresetn;
    reg clk;
    reg mclk;
    reg maresetn;
initial begin
	mclk = 0;
	forever #8 mclk = ~mclk;
end


    
initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

//reg [31:0] countR;
//assign s_axis_tdata = countR;

//always@(posedge clk, negedge aresetn)begin
//    if(!aresetn) begin
//        countR  <= 0;
//        end
//    if(s_axis_tready && s_axis_tvalid == 1)begin
//        countR <= countR + 1;
//        end
//        end
initial begin
    aresetn =   0;
    maresetn    =   0;
    M_AXIS_tready   =   0;
    s_axis_tvalid   =   0;
   // rx_done_temp    =   0;
   // tx_en_temp      =   1;
    #10
    aresetn =   1;
    maresetn    =   1;
    M_AXIS_tready   =   1;
    //s_axis_tvalid = 1;
    //rx_done_temp    =   0;
    //tx_en_temp  =1;
    //#745
    #1585
  //  tx_en_temp      =   1;
  //  rx_done_temp    =   0;
    M_AXIS_tready   =   0;
    //#795
    #200
    M_AXIS_tready   =   1;
    
end
    
design_1_wrapper dut
   (.m_axis_aclk(clk),
    .m_axis_aresetn(aresetn),
    .m_axis_tdata(M_AXIS_tdata),
    .m_axis_tlast(M_AXIS_tlast),
    .m_axis_tready(M_AXIS_tready),
    .m_axis_tstrb(M_AXIS_tstrb),
    .m_axis_tvalid(M_AXIS_tvalid),
    .s_axis_aclk(clk),
    .s_axis_aresetn(aresetn));

endmodule
