#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "queue.h"
#include <xil_printf.h>
#include "cplx_data.h"
//#include "signal_data.h"


#define QUEUE_ITEM_LENGTH 128

//extern const int signal_data[512][128];
/*
typedef struct queue {
    cplx_data_t* buffer;
    int front;
    int rear;
    int capacity;
    int size;
	int datalen;
} queue_t;
*/
/* capacity: number of arrays you wish to store, datalen: length of each array */
queue_t* queue_create(int capacity,unsigned int datalen) {
    queue_t* queue = (queue_t*) malloc(sizeof(queue_t));
    queue->buffer = (cplx_data_t*) malloc(capacity * sizeof(cplx_data_t) * datalen);
    queue->front = 0;
    queue->rear = -datalen;
    queue->capacity = capacity*datalen;
    queue->size = 0;
	queue ->datalen = datalen;
    return queue;
}

void queue_destroy(queue_t* queue) {
    free(queue->buffer);
    free(queue);
}

void queue_enqueue(queue_t* queue, cplx_data_t* data) {
    if (queue->size == queue->capacity) {
      xil_printf("Queue is full \n\r");
//	  printf("Queue is full \n");
        return;
    }
    queue->rear = (queue->rear + 1*queue->datalen) % queue->capacity;
    memcpy(&(queue->buffer[queue->rear]), data, sizeof(cplx_data_t)*queue->datalen);
    queue->size++;
}

cplx_data_t* queue_dequeue(queue_t* queue) {
    if (queue->size == 0) {
   	xil_printf("Queue is empty\n\r");
	//printf("Queue is empty \n");
    return NULL;
    }
    cplx_data_t* data = &(queue->buffer[queue->front]);
    queue->front = (queue->front + 1*queue->datalen) % queue->capacity;
    queue->size--;
    return data;
}

int queue_size(queue_t* queue) {
    return queue->size;
}
/*
int main() {
    int capacity = 1000;
	cplx_data_t *dequeued_data;
    cplx_data_t* result_buf = (cplx_data_t*) malloc(sizeof(cplx_data_t)*RANGE_FFT_SIZE);
    // Initialize and use result_buf...
    queue_t* queue = queue_create(capacity,RANGE_FFT_SIZE);

	for (int i =0; i<512;i++){
			memcpy(result_buf, signal_data[i], sizeof(cplx_data_t)*RANGE_FFT_SIZE);
			queue_enqueue(queue, result_buf);
    			// Modify data in queue...
    			//cplx_data_t* data = queue_dequeue(queue);
    			// Use and/or modify data...

		}
*/

	/* Data check*/
/*	for(int i=0; i <1; i++){
		dequeued_data = queue_dequeue(queue);
		for(int j=0;j<RANGE_FFT_SIZE;j++){
			if((dequeued_data[j].data_re != (short)(signal_data[i][j] & 0x0000FFFF)) || (dequeued_data[0].data_im != (short)((signal_data[0][0]>>16) & 0x0000FFFF))){
				printf("Data mismatch at signal %d sample %d\n",i,j);
			}

		}
	}
	queue_destroy(queue);

    free(result_buf);

    return 0;

}*/

