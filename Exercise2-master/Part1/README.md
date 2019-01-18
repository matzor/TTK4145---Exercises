# Mutex and Channel basics

### What is an atomic operation?
> An action with no observable intermediary state, can't be interrupted.

### What is a semaphore?
> A variable that is used to control access to a resource. Integer value, increments when it is in use, decrements when done. Allows a maximum amount of threads to access at the same time.  

### What is a mutex?
> A mutex is locking mechanism used to synchronize access to a resource. It can lock down resources such that only one process can use it at a time.

### What is the difference between a mutex and a binary semaphore?
> Mutex owns reasource, and only it can take and release it.(Toilet key.)
> Binary semaphore makes it so that one process can give a resource and another take it(chef and customer).

### What is a critical section?
> All semaphores and mutices are in these parts of the program.

### What is the difference between race conditions and data races?
> Race condition: Time constraints on a program. One thing must happen before the other.
> Data race: Two instructions from different threads access the same mem location.

### List some advantages of using message passing over lock-based synchronization primitives.
> Avoid gridlock. More intuitive software. 

### List some advantages of using lock-based synchronization primitives over message passing.
> Better at hard realtime programming; less delays. 
