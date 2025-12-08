package main;
import "fmt";

func test(a, b int) int {
    fmt.Print(a);
    fmt.Print(" ");
    fmt.Print(b);
    fmt.Print("\n");
    q := 0;
    for (a >= b) { 
        q++; 
        a = a - b 
    };
    return q
};

func main() {
    fmt.Print("BEGIN ");
    fmt.Print(test(10, 3));
    fmt.Print("\n");
};
