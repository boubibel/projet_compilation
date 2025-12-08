package main;
import "fmt";

func test(a int) (int, int) {
    if (a < 5) { return 1, 2 } else { return 3, 4 }
};

func main() {
    fmt.Print(test(3));
    fmt.Print("\n");
};
