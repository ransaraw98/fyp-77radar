
`timescale 1 ns / 1 ps

	module radarIMG_rom4_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Master Bus Interface M_AXIS
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M_AXIS_START_COUNT	= 32,
		parameter integer ADDRW   =   14,
		parameter RAM_TYPE = "block"
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Master Bus Interface M_AXIS
		input wire  m_axis_aclk,
		input wire  m_axis_aresetn,
		output wire  m_axis_tvalid,
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] m_axis_tdata,
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] m_axis_tstrb,
		output wire  m_axis_tlast,
		input wire  m_axis_tready
	);
	wire [C_M_AXIS_TDATA_WIDTH-1:0] rom_dout;
	wire [ADDRW-1:0]   rom_addr_in;
	wire rom_en;
// Instantiation of Axi Bus Interface M_AXIS
	radarIMG_rom4_v1_0_M_AXIS # ( 
		.C_M_AXIS_TDATA_WIDTH(C_M_AXIS_TDATA_WIDTH),
		.C_M_AXIS_START_COUNT(C_M_AXIS_START_COUNT),
		.ADDRW(ADDRW)
	) radarIMG_rom4_v1_0_M_AXIS_inst (
		.M_AXIS_ACLK(m_axis_aclk),
		.M_AXIS_ARESETN(m_axis_aresetn),
		.M_AXIS_TVALID(m_axis_tvalid),
		.M_AXIS_TDATA(m_axis_tdata),
		.M_AXIS_TSTRB(m_axis_tstrb),
		.M_AXIS_TLAST(m_axis_tlast),
		.M_AXIS_TREADY(m_axis_tready),
		.data_in(rom_dout),
		.addr_out(rom_addr_in),
		.rom_en_out(rom_en)
	);

	// Add user logic here
    sp_rom #(.DATA_WIDTH(C_M_AXIS_TDATA_WIDTH),
            .ADDRW(ADDRW),
            .RAM_TYPE(RAM_TYPE)
            ) 
          rom1  (
            .clk(m_axis_aclk),
            .en(rom_en),
            .addr(rom_addr_in),
            .dout(rom_dout)
            
    );
	// User logic ends

	endmodule
