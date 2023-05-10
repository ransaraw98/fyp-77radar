
`timescale 1 ns / 1 ps

	module ping_pong_buf_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Master Bus Interface M_AXIS
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M_AXIS_START_COUNT	= 32,

		// Parameters of Axi Slave Bus Interface S_AXIS
		parameter integer C_S_AXIS_TDATA_WIDTH	= 32,
		//Parameters for RAM
		parameter integer RAM_ADDRW   =   4,
		parameter integer RAM_DEPTH   =   16
	)
	(
		// Users to add ports here
		//input wire ch1_tx_done,
		output wire ch1_tx_done_temp,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Master Bus Interface M_AXIS
		input wire  m_axis_aclk,
		input wire  m_axis_aresetn,
		output wire  m_axis_tvalid,
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] m_axis_tdata,
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] m_axis_tstrb,
		output wire  m_axis_tlast,
		input wire  m_axis_tready,

		// Ports of Axi Slave Bus Interface S_AXIS
		input wire  s_axis_aclk,
		input wire  s_axis_aresetn,
		output wire  s_axis_tready,
		input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] s_axis_tdata,
		input wire [(C_S_AXIS_TDATA_WIDTH/8)-1 : 0] s_axis_tstrb,
		input wire  s_axis_tlast,
		input wire  s_axis_tvalid
	);
	
	//USER logic
        wire ch1_wen;
        wire ch1_ren;
        wire ch1_tx_en;
        wire ch1_tx_done;
        wire ch1_rx_done;
        wire [RAM_ADDRW-1:0]   ch1_ram_waddr;
        wire [RAM_ADDRW-1:0]   ch1_ram_raddr;
        wire [C_S_AXIS_TDATA_WIDTH-1 : 0]  ch1_ram_din;
        wire [C_S_AXIS_TDATA_WIDTH-1 : 0]  ch1_ram_dout;

// Instantiation of Axi Bus Interface M_AXIS
	ping_pong_buf_v1_0_M_AXIS # ( 
		.C_M_AXIS_TDATA_WIDTH(C_M_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M_AXIS_START_COUNT),
		.RAM_ADDRW(RAM_ADDRW),
		.RAM_DEPTH(RAM_DEPTH)
	) ping_pong_buf_v1_0_M_AXIS_inst (
		.M_AXIS_ACLK(m_axis_aclk),
		.M_AXIS_ARESETN(m_axis_aresetn),
		.M_AXIS_TVALID(m_axis_tvalid),
		.M_AXIS_TDATA(m_axis_tdata),
		.M_AXIS_TSTRB(m_axis_tstrb),
		.M_AXIS_TLAST(m_axis_tlast),
		.M_AXIS_TREADY(m_axis_tready),
		.RAM_EN(ch1_ren),
		.RAM_RADDR(ch1_ram_raddr),
		.tx_done(ch1_tx_done),
		.rx_done(ch1_rx_done),
		.ch1_ram_dout(ch1_ram_dout),           //Data from the ram
		.tx_en(ch1_tx_en)
		
	);

// Instantiation of Axi Bus Interface S_AXIS
	ping_pong_buf_v1_0_S_AXIS # ( 
		.C_S_AXIS_TDATA_WIDTH(C_S_AXIS_TDATA_WIDTH),
		.RAM_DEPTH(RAM_DEPTH),
		.RAM_ADDRW(RAM_ADDRW)
	) ping_pong_buf_v1_0_S_AXIS_inst (
		.S_AXIS_ACLK(s_axis_aclk),
		.S_AXIS_ARESETN(s_axis_aresetn),
		.S_AXIS_TREADY(s_axis_tready),
		.S_AXIS_TDATA(s_axis_tdata),
		.S_AXIS_TSTRB(s_axis_tstrb),
		.S_AXIS_TLAST(s_axis_tlast),
		.S_AXIS_TVALID(s_axis_tvalid),
		.RAM_WEN(ch1_wen),
		.RAM_WADDR(ch1_ram_waddr),
		.ch1_ram_din(ch1_ram_din),
		.tx_en(ch1_tx_en),
		.tx_done(ch1_tx_done),
		.rx_done(ch1_rx_done)
	);

	// Add user logic here

	
    dp_ram #(.DATA_WIDTH(C_S_AXIS_TDATA_WIDTH),
             .DEPTH(RAM_DEPTH),
             .ADDRW(RAM_ADDRW)
             ) CH1_ram(
                .clk(s_axis_aclk),
                .ena(ch1_wen),
                .enb(ch1_ren),
                .wea(ch1_wen),
                .addra(ch1_ram_waddr),
                .addrb(ch1_ram_raddr),
                .dia(ch1_ram_din),
                .dob(ch1_ram_dout)
             );
	// User logic ends

	endmodule
