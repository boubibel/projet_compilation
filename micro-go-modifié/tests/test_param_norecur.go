package main;
import "fmt";

func ret(a, b int) (int,int) {
    return a, b
};

func test(a, b int) (int,int) {
    x,y := ret(a, b);
    return x+a, y+b
};

func main() {
	fmt.Print(test(7, 3)); 
	fmt.Print("\n");
};
