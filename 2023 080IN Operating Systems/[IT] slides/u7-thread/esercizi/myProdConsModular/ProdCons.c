#include <semaphore.h>
#include <pthread.h>
#include <stdlib.h>

typedef struct{
    int counter, size, insert_pos, extract_pos;
    pthread_mutex_t mutex;
    sem_t empty, full;
    void ** buffer;   
} Queue;

Queue * Queue_init(int N){
    Queue * q = malloc (sizeof(Queue) );
    q->counter = q->insert_pos = q->extract_pos = 0;
    q->size = N;
    q->buffer = malloc( N * sizeof(void*) );
    pthread_mutex_init(&q->mutex, NULL);
    sem_init(&q->empty, 0, N);
    sem_init(&q->full, 0, 0);
    
    return q;
}

void Queue_destroy(Queue * q){
    free ( (*q).buffer);
}

void Queue_insert(Queue * q, void * item){
    sem_wait(&(q->empty));
    pthread_mutex_lock(&(q->mutex));
    q->buffer[q->insert_pos] = item;
    q->insert_pos =  (q->insert_pos + 1) % q->size;
    q->counter++;
    pthread_mutex_unlock(&(q->mutex));
    sem_post(&(q->full));
}

void * Queue_extract(Queue * q){
    void * item;
    sem_wait(&(q->full));
    pthread_mutex_lock(&(q->mutex));
    item = q->buffer[q->extract_pos];
    q->extract_pos =  (q->extract_pos + 1) % q->size;
    q->counter++;
    pthread_mutex_unlock(&(q->mutex));
    sem_post(&(q->empty));
    return item;
}
