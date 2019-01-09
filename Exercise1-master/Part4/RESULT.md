The program returns different, random values each time it is run. This is because of timing conflicts between the concurrent threads.
The threads interrupt each other at various points in the execution cycle. One thread might for instance change the value of i after 
the other thread has already fetched another value for i, making the value invalid. When the first thread saves its value to memory,
the other thread still has the old value stored and everything is just messed up. 
