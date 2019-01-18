#include <pthread.h>
#include <stdio.h>

int i = 0;
pthread_mutex_t i_tex;
// Note the return type: void*
void* incrementingThreadFunction(){
    for (int j = 0; j < 1000000; j++) {
	pthread_mutex_lock(&i_tex);
	i++;
	pthread_mutex_unlock(&i_tex);
    }
    return NULL;
}

void* decrementingThreadFunction(){
    for (int j = 0; j < 1000001; j++) {
    	pthread_mutex_lock(&i_tex);
	i--;
	pthread_mutex_unlock(&i_tex);

    }
    return NULL;
}


int main(){
    pthread_t incrementingThread, decrementingThread;
    
    pthread_mutex_init(&i_tex, NULL);
    pthread_create(&incrementingThread, NULL, incrementingThreadFunction, NULL);
    pthread_create(&decrementingThread, NULL, decrementingThreadFunction, NULL);
    
    pthread_join(incrementingThread, NULL);
    pthread_join(decrementingThread, NULL);
    
    printf("The magic number is: %d\n", i);
    return 0;
}
