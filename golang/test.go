package main

import (
	"log"
	"time"
)

func main() {
	for {
		time.Sleep(2 * time.Second)
		log.Println("hello world!")
	}
}
