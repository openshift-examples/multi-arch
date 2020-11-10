package main

import "os/exec"
import "fmt"

func main() {
    cmd := exec.Command("uname", "-m")
    stdout, err := cmd.Output()

    if err != nil {
        fmt.Println(err.Error())
        return
    }
    fmt.Print("hello world from architecture: ")
    fmt.Print(string(stdout))
}
