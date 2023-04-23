#ifndef QUEUE_H
#define QUEUE_H
#define RANGE_FFT_SIZE 128
#include <stdlib.h>
#include "cplx_data.h"
/*
typedef struct cplx_data {
    float real;
    float imag;
} cplx_data_t;
*/

typedef struct queue {
    cplx_data_t* buffer;
    int front;
    int rear;
    int capacity;
    int size;
	int datalen;
} queue_t;

queue_t* queue_create(int capacity,unsigned int datalen);
void queue_destroy(queue_t* queue);
int queue_size(queue_t* queue);
void queue_enqueue(queue_t* queue, cplx_data_t* data);
cplx_data_t* queue_dequeue(queue_t* queue);

#endif /* QUEUE_H */
