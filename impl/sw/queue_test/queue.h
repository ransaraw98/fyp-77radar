#ifndef QUEUE_H
#define QUEUE_H

#include <stdlib.h>

typedef struct cplx_data {
    float real;
    float imag;
} cplx_data_t;

typedef struct queue {
    cplx_data_t* buffer;
    int front;
    int rear;
    int capacity;
    int size;
} queue_t;

queue_t* create_queue(int capacity, int itemlength);
void delete_queue(queue_t* q);
int is_full(queue_t* q);
int is_empty(queue_t* q);
int enqueue(queue_t* q, cplx_data_t* data, unsigned int datalen);
int dequeue(queue_t* q, cplx_data_t* data);

#endif /* QUEUE_H */
