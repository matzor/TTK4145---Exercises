// Use `go run foo.go` to run your program

package main

import (
    . "fmt"
    "runtime"
)

// Control signals
const (
	GetNumber = iota
	Exit
)

func number_server(add_number <-chan int, control <-chan int, number chan<- int) {
	i := 0
	increment := 0

	// This for-select pattern is one you will become familiar with if you're using go "correctly".
	for {
		select {
			// receive different messages and handle them correctly
			// You will at least need to update the number and handle control signals.
		case increment = <-add_number:
			i += increment
		case ctrl := <-control:
			switch ctrl {
			case GetNumber:
				number <- i
			case Exit:
				return
			}
		}
	}
}

func incrementing(add_number chan<-int, finished chan<- bool) {
	for j := 0; j<1000000; j++ {
		add_number <- 1
	}
	//signal that the goroutine is finished
	finished <- true
}

func decrementing(add_number chan<- int, finished chan<- bool) {
	for j := 0; j<1000001; j++ {
		add_number <- -1
	}
	//signal that the goroutine is finished
	finished <- true
}

func main() {
	runtime.GOMAXPROCS(runtime.NumCPU())
	println("Number of cores: ", runtime.NumCPU())
	// Construct the required channels
	// Think about wether the receptions of the number should be unbuffered, or buffered with a fixed queue size.
	finished := make(chan bool)
	add_number := make(chan int)
	control := make(chan int)
	number := make(chan int)

	// Spawn the required goroutines
	go number_server(add_number, control, number)
	go incrementing(add_number, finished)
	go decrementing(add_number, finished)

	//block on finished from both "worker" goroutines
	_, _ = <-finished, <-finished

	control<-GetNumber
	Println("The magic number is:", <-number)
	control<-Exit
}
