package main;
import "fmt";

func test() (int,int) {
    var x, y int;
    x = 7;
    y = 3;
    return x, y
};

func main() {
	fmt.Print(test()); 
	fmt.Print("\n");
};
