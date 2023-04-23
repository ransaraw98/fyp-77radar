/* start_application: function to set up UDP listener */
int start_application()
{

	/* Declare some structures and variables */
	err_t err;
	struct udp_pcb* pcb;
	unsigned port = FF_UDP_PORT;

	/* Create new udp PCB structure */
	pcb = udp_new();
	if (!pcb) {
		xil_printf("Error creating PCB. Out of Memory\n\r");
		return -1;
	}

	/* Bind to specified @port */
	err = udp_bind(pcb, IP_ADDR_ANY, port);
	if (err != ERR_OK) {
		xil_printf("Unable to bind to port %d: err = %d\n\r", port, err);
		return -2;
	}

	/* set the receive callback for this connection */
	udp_recv(pcb, recv_callback, NULL);

	/* Print out information about the connection */
	xil_printf("udp echo server started @ port %d\n\r", port);

    /* Print out a request for an index array */
    xil_printf("\nAlgorithm is prepared to receive index array (256 32-bit fixed point values)\n\r\n\r");

	/* Return success */
	return 0;

}

