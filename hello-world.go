package main
import "fmt"
import "runtime"

func main() {
    fmt.Printf("GOOS: %v\nGOARCH: %v\n", runtime.GOOS, runtime.GOARCH)
}
