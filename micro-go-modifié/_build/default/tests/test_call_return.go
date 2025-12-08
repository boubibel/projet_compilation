package main;
import "fmt";

func ret() (int,int) {
    return 7, 3
};

func test() (int,int) {
    x,y := ret();
    return x, y
};

func main() {
	fmt.Print(test()); 
	fmt.Print("\n");
};
