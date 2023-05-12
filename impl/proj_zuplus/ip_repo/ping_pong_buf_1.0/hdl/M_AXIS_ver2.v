`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2023 10:43:18 AM
// Design Name: 
// Module Name: M_AXIS_ver2
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
(* DONT_TOUCH = "yes" *)
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
//State encoding
localparam  STATE_Initial = 3'd0,
            STATE_pingPong =   3'd1,
            STATE_read  =   3'd2,
            STATE_incRptr    =   3'd3,
            STATE_waitRxDone    =   3'd4;
            

reg [2:0] CurrentState;
reg [2:0] NextState;

reg tvalidR;
reg [RAM_ADDRW-1:0] readPtr;
reg [RAM_ADDRW-1:0] readCount;   

//assign  RAM_RADDR       =   readPtr + readCount;
assign  M_AXIS_TDATA    =   ch1_ram_dout;
assign  M_AXIS_TVALID   =   tvalidR;
assign  M_AXIS_TLAST    =   (readCount  ==  (RAM_DEPTH/2-1)) ? 1:0;

always @ (readPtr, readCount)
begin
    RAM_RADDR = readPtr + readCount;
end

always@(posedge M_AXIS_ACLK, negedge M_AXIS_ARESETN)begin
    if(!M_AXIS_ARESETN)begin
        CurrentState    <=  STATE_Initial;
        //tx_done         <=  0;
        //tvalidR         <=  0;
        readCount       <=  0;
        readPtr         <=  RAM_DEPTH/2;
        end
    else if(NextState ==  STATE_incRptr)begin
        CurrentState    <=  NextState;
        readCount <= readCount + 1;
        end
    else if(CurrentState ==  STATE_pingPong) begin
        readPtr <=   readPtr + RAM_DEPTH/2;
        readCount <=    {RAM_ADDRW{1'b0}};
        CurrentState    <=  NextState;
        end
    //A latch would infer
    else begin
    CurrentState    <=  NextState;
        readCount   <=  readCount;
        readPtr     <=  readPtr;
        end   
    end
        
always@(*)begin
    NextState   =   CurrentState;
    case    (CurrentState)
        STATE_Initial: begin
            tx_done =   1;
            RAM_EN  =   0;
            tvalidR =   0;
            if (tx_en == 1)
                NextState = STATE_pingPong; 
            else
                NextState = STATE_Initial;       
        end
        STATE_pingPong: begin
            //readPtr         =   readPtr + RAM_DEPTH/2;
            //readCount       =   {RAM_ADDRW{1'b0}};
            RAM_EN          =   1;
            tvalidR         =   0;                      //Correct data will only be available in the next cycle
            tx_done         =   0;
            NextState       =   STATE_read;        
        end
        STATE_read:begin
            RAM_EN          =   1;
            tx_done         =   0;
            tvalidR         =   1;
            if(M_AXIS_TREADY    ==   0)
                NextState   =   STATE_read;
            else
                NextState   =   STATE_incRptr;
            end
        STATE_incRptr:begin
            tvalidR         =   1;
            RAM_EN          =   1;
            tx_done         =   0;
            if(readCount    ==  (RAM_DEPTH/2-1))
                NextState   =   STATE_waitRxDone;
            else if(M_AXIS_TREADY == 0)
                NextState   = STATE_read;
            else
                NextState   =   STATE_incRptr;   
        end
        STATE_waitRxDone:begin
            tvalidR         =   0;
            RAM_EN          =   0;
            tx_done         =   1;
            if(rx_done  ==  1)
                NextState   =   STATE_pingPong;
            else
                NextState   =   STATE_waitRxDone;
        end
        default:    begin
            //NextState   =   CurrentState;    
            tx_done     =   1;
            RAM_EN      =   0;
            tvalidR     =   0;
        end
        endcase
    end




endmodule