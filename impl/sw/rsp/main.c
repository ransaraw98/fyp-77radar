/*
 * Copyright (C) 2017 - 2019 Xilinx, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 *
 */

#include <stdio.h>
#include "xparameters.h"
#include "netif/xadapter.h"
#include "platform.h"
#include "platform_config.h"
#include "lwipopts.h"
#include "xil_printf.h"
#include "sleep.h"
#include "lwip/priv/tcp_priv.h"
#include "lwip/init.h"
#include "lwip/inet.h"
#include "xil_cache.h"
///////////////////////////
#include <stdlib.h>
#include "xuartps_hw.h"
#include "fft.h"
#include "cplx_data.h"
#include "stim.h"
#include "xtime_l.h"

#if LWIP_DHCP==1
#include "lwip/dhcp.h"
extern volatile int dhcp_timoutcntr;
#endif

extern volatile int TcpFastTmrFlag;
extern volatile int TcpSlowTmrFlag;

#define DEFAULT_IP_ADDRESS	"192.168.1.10"
#define DEFAULT_IP_MASK		"255.255.255.0"
#define DEFAULT_GW_ADDRESS	"192.168.1.1"

void platform_enable_interrupts(void);
void start_application(void);
void transfer_data(char* data);
void print_app_header(void);

#if defined (__arm__) && !defined (ARMR5)
#if XPAR_GIGE_PCS_PMA_SGMII_CORE_PRESENT == 1 || \
		 XPAR_GIGE_PCS_PMA_1000BASEX_CORE_PRESENT == 1
int ProgramSi5324(void);
int ProgramSfpPhy(void);
#endif
#endif

#ifdef XPS_BOARD_ZCU102
#ifdef XPAR_XIICPS_0_DEVICE_ID
int IicPhyReset(void);
#endif
#endif

#ifndef UDP_SEND_BUFSIZE
#define UDP_SEND_BUFSIZE 512
#endif

#ifndef FINISH
#define FINISH 1
#endif
struct netif server_netif;
//
int i =0;
extern char send_buf[UDP_SEND_BUFSIZE];
char tx_buffer[UDP_SEND_BUFSIZE];
extern void udp_packet_send(u8_t finished, char *data);
// External data
extern int sig_two_sine_waves[FFT_MAX_NUM_PTS]; // FFT input data
void which_fft_param(fft_t* p_fft_inst);

//
static void print_ip(char *msg, ip_addr_t *ip)
{
	print(msg);
	xil_printf("%d.%d.%d.%d\r\n", ip4_addr1(ip), ip4_addr2(ip),
			ip4_addr3(ip), ip4_addr4(ip));
}

static void print_ip_settings(ip_addr_t *ip, ip_addr_t *mask, ip_addr_t *gw)
{
	print_ip("Board IP:       ", ip);
	print_ip("Netmask :       ", mask);
	print_ip("Gateway :       ", gw);
}

static void assign_default_ip(ip_addr_t *ip, ip_addr_t *mask, ip_addr_t *gw)
{
	int err;

	xil_printf("Configuring default IP %s \r\n", DEFAULT_IP_ADDRESS);

	err = inet_aton(DEFAULT_IP_ADDRESS, ip);
	if (!err)
		xil_printf("Invalid default IP address: %d\r\n", err);

	err = inet_aton(DEFAULT_IP_MASK, mask);
	if (!err)
		xil_printf("Invalid default IP MASK: %d\r\n", err);

	err = inet_aton(DEFAULT_GW_ADDRESS, gw);
	if (!err)
		xil_printf("Invalid default gateway address: %d\r\n", err);
}

int main(void)
{
	struct netif *netif;

	/* the mac address of the board. this should be unique per board */
	unsigned char mac_ethernet_address[] = {
		0x00, 0x0a, 0x35, 0x00, 0x01, 0x02 };

	netif = &server_netif;
#if defined (__arm__) && !defined (ARMR5)
#if XPAR_GIGE_PCS_PMA_SGMII_CORE_PRESENT == 1 || \
		XPAR_GIGE_PCS_PMA_1000BASEX_CORE_PRESENT == 1
	ProgramSi5324();
	ProgramSfpPhy();
#endif
#endif

	/* Define this board specific macro in order perform PHY reset
	 * on ZCU102
	 */
#ifdef XPS_BOARD_ZCU102
	IicPhyReset();
#endif
	// Local variables for fft
	int          status = 0;
	fft_t*       p_fft_inst;
	cplx_data_t* stim_buf;
	cplx_data_t* result_buf;
	init_platform();

	xil_printf("\r\n\r\n");
	//~~~~~~~~~~~~~~~~~~~~~~~~~~SETUP FFT~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 xil_printf("\fHello World!\n\r");

	    // Create FFT object
	    p_fft_inst = fft_create
	    (
	    	XPAR_GPIO_0_DEVICE_ID,
	    	XPAR_AXIDMA_0_DEVICE_ID,
	    	XPAR_PS7_SCUGIC_0_DEVICE_ID,
	    	XPAR_FABRIC_CTRL_AXI_DMA_0_S2MM_INTROUT_INTR,
	    	XPAR_FABRIC_CTRL_AXI_DMA_0_MM2S_INTROUT_INTR
	    );
	    if (p_fft_inst == NULL)
	    {
	    	xil_printf("ERROR! Failed to create FFT instance.\n\r");
	    	return -1;
	    }

	    // Allocate data buffers
	    stim_buf = (cplx_data_t*) malloc(sizeof(cplx_data_t)*FFT_MAX_NUM_PTS);
	    if (stim_buf == NULL)
	    {
	    	xil_printf("ERROR! Failed to allocate memory for the stimulus buffer.\n\r");
	    	return -1;
	    }

	    result_buf = (cplx_data_t*) malloc(sizeof(cplx_data_t)*FFT_MAX_NUM_PTS);
	    if (result_buf == NULL)
	    {
	    	xil_printf("ERROR! Failed to allocate memory for the result buffer.\n\r");
	    	return -1;
	    }

	    // Fill stimulus buffer with some signal
	    memcpy(stim_buf, sig_two_sine_waves, sizeof(cplx_data_t)*FFT_MAX_NUM_PTS);

	    XTime begin, end;
	    double time_spent;

	    //Set FFT length
	    fft_set_num_pts(p_fft_inst, 128);

	xil_printf("-----lwIP RAW Mode UDP Client Application-----\r\n");

	/* initialize lwIP */
	lwip_init();

	/* Add network interface to the netif_list, and set it as default */
	if (!xemac_add(netif, NULL, NULL, NULL, mac_ethernet_address,
				PLATFORM_EMAC_BASEADDR)) {
		xil_printf("Error adding N/W interface\r\n");
		return -1;
	}
	netif_set_default(netif);

	/* now enable interrupts */
	platform_enable_interrupts();

	/* specify that the network if is up */
	netif_set_up(netif);

#if (LWIP_DHCP==1)
	/* Create a new DHCP client for this interface.
	 * Note: you must call dhcp_fine_tmr() and dhcp_coarse_tmr() at
	 * the predefined regular intervals after starting the client.
	 */
	dhcp_start(netif);
	dhcp_timoutcntr = 24;
	while (((netif->ip_addr.addr) == 0) && (dhcp_timoutcntr > 0))
		xemacif_input(netif);

	if (dhcp_timoutcntr <= 0) {
		if ((netif->ip_addr.addr) == 0) {
			xil_printf("ERROR: DHCP request timed out\r\n");
			assign_default_ip(&(netif->ip_addr),
					&(netif->netmask), &(netif->gw));
		}
	}

	/* print IP address, netmask and gateway */
#else
	assign_default_ip(&(netif->ip_addr), &(netif->netmask), &(netif->gw));
#endif
	print_ip_settings(&(netif->ip_addr), &(netif->netmask), &(netif->gw));

	xil_printf("\r\n");

	/* print app header */
	print_app_header();

	/* start the ip application*/
	start_application();
	xil_printf("\r\n");

	// Process FFT one time
	xil_printf("\fAt the for loop!\n\r");
	    //XTime_GetTime(&begin);
	    int i = 0;
	    if(i<512){
	    		i++;
	        	// Run FFT

	    			// Make sure the buffer is clear before we populate it (this is generally not necessary and wastes time doing memory accesses, but for proving the DMA working, we do it anyway)
	    			memset(result_buf, 0, sizeof(cplx_data_t)*FFT_MAX_NUM_PTS);

	    			status = fft(p_fft_inst, (cplx_data_t*)stim_buf, (cplx_data_t*)result_buf);
	    			if (status != FFT_SUCCESS)
	    			{
	    				xil_printf("ERROR! FFT failed.\n\r");
	    				return -1;
	    			}
	    		}
	    else{
	    	i = 0;
	    }
		//XTime_GetTime(&end);

		//time_spent = (double)((end-begin)/COUNTS_PER_SECOND);
		//xil_printf("Time spent = %f \n\r",(float)time_spent);
		//memcpy(tx_buffer, result_buf, 128*4);
		//xil_printf("FFT %d complete!\n\r",i);

		/*if(i==1){
		fft_print_result_buf(p_fft_inst);
		}*/

	    //free(stim_buf);
	   // free(result_buf);
	   // fft_destroy(p_fft_inst);

	while (1) {
		if (TcpFastTmrFlag) {
			tcp_fasttmr();
			TcpFastTmrFlag = 0;
		}
		if (TcpSlowTmrFlag) {
			tcp_slowtmr();
			TcpSlowTmrFlag = 0;
		}
		status = fft(p_fft_inst, (cplx_data_t*)stim_buf, (cplx_data_t*)result_buf);
		if (status != FFT_SUCCESS)
		{
			xil_printf("ERROR! FFT failed.\n\r");
			return -1;
		}

		xemacif_input(netif);
		//transfer_data();
		for (i = 0; i < UDP_SEND_BUFSIZE; i++)
			send_buf[i] = (65 + i%10);
		udp_packet_send(!FINISH,result_buf);
	}

	/* never reached */
	cleanup_platform();

	return 0;
}
