`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2023 03:33:03 PM
// Design Name: 
// Module Name: dp_ram
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2023 03:22:41 PM
// Design Name: 
// Module Name: dp_ram
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


// Simple Dual-Port Block RAM with One Clock

// File: simple_dual_one_clock.v

module dp_ram #( parameter integer DATA_WIDTH = 32,
                 parameter integer DEPTH      = 64,
                 parameter integer ADDRW      = 6,
		          parameter RAM_TYPE = "block"
    )(

input clk,
input ena,
input enb,
input wea,
input [ADDRW-1:0] addra,addrb,
input [DATA_WIDTH-1:0] dia,
output reg [DATA_WIDTH-1:0] dob
);


(*ram_style = RAM_TYPE*)reg [DATA_WIDTH-1:0] ram [DEPTH-1:0];
//reg [DATA_WIDTH-1:0] doa,dob;
//integer i = 0;
//initial begin
//for (i=0; i < DEPTH; i= i+1)
//    ram[i] <= i;
//end

always @(posedge clk) begin
    if (ena) begin
        if (wea)
        ram[addra] <= dia;
    end
end

always @(negedge clk) begin
    if (enb)
        dob = ram[addrb];
    else
        dob = 0;
    end
        
endmodule

