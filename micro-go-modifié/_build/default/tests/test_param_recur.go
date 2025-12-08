package main;
import "fmt";

func test(a, b int) (int,int) {
    if (a == 0) { return 0, 0 };
    x,y := test(a-1, b-1);
    return x+a, y+b
};

func main() {
	fmt.Print(test(2, 3)); 
	fmt.Print("\n");
};
