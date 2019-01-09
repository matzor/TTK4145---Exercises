# Reasons for concurrency and parallelism


To complete this exercise you will have to use git. Create one or several commits that adds answers to the following questions and push it to your groups repository to complete the task.

When answering the questions, remember to use all the resources at your disposal. Asking the internet isn't a form of "cheating", it's a way of learning.

 ### What is concurrency? What is parallelism? What's the difference?
 > Concurrency: Things happening at the same time in overlapping time periods, but not necessarily independent of each other.
 > Parallelism: Two (or more) processes running at the same time, independend of each other, not affecting each other.
 
 ### Why have machines become increasingly multicore in the past decade?
 > To increase parallelism. More cores => more independent processes.
 > Also to increase processing power, which historically has been done by increasing the frequency of the processor. Increasing the frequancy further more is not a viable tactic, as the power requirements and heat dissipation of high-frequency processors rises exponentially.
 
 ### What kinds of problems motivates the need for concurrent execution?
 (Or phrased differently: What problems do concurrency help in solving?)
 > Concurrency lets us run more procecess at the same time, i.e. multitasking. Without it we would only be able to run one task at a time.
 
 ### Does creating concurrent programs make the programmer's life easier? Harder? Maybe both?
 (Come back to this after you have worked on part 4 of this exercise)
 > Both. If you're not careful, you can get conflicts between the threads. For instance, one thread can interrupt another thread during a task, potentially changing the outcome of the task in some way. 
 
 ### What are the differences between processes, threads, green threads, and coroutines?
 > Process: OS-managed (possibly) truly concurrent, at least in the presence of suitable hardware support. Exist within their own address space.
 > Thread: OS-managed, within the same address space as the parent and all its other threads. Possibly truly concurrent, and multi-tasking is pre-emptive.
 > Green Thread: These are user-space projections of the same concept as threads, but are not OS-managed. Probably not truly concurrent, except in the sense that there may be multiple worker threads or processes giving them CPU time concurrently, so probably best to consider this as interleaved or multiplexed.
 > Coroutines: Not OS-managed. Exactly threads, except co-operatively multitasking, and hence not truly concurrent.
 
 > Source: https://stackoverflow.com/questions/3324643/processes-threads-green-threads-protothreads-fibers-coroutines-whats-the
 
 ### Which one of these do `pthread_create()` (C/POSIX), `threading.Thread()` (Python), `go` (Go) create?
 > Thread
 
 ### How does pythons Global Interpreter Lock (GIL) influence the way a python Thread behaves?
 > The Python Global Interpreter Lock or GIL, in simple words, is a mutex (or a lock) that allows only one thread to hold the control of the Python interpreter. This means that only one thread can be in a state of execution at any point in time. It can be a performance bottleneck in CPU-bound and multi-threaded code.
 
 ### With this in mind: What is the workaround for the GIL (Hint: it's another module)?
 > Python has a multiprocessing module which lets us create processes. Each Python process gets its own Python interpreter and memory space so the GIL won’t be a problem.
 
 ### What does `func GOMAXPROCS(n int) int` change? 
 > GOMAXPROCS sets the maximum number of CPUs that can be executing simultaneously and returns the previous setting.
