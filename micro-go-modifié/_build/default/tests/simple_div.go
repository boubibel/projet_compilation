package main;
import "fmt";

func test(a, b int) int {
    q := 0;
    for (a >= b) { 
        q++; 
        a = a - b 
    };
    return q
};

func main() {
    fmt.Print(test(10, 3));
    fmt.Print("\n");
};
