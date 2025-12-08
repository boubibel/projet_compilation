package main;
import "fmt";

func countdown(n int) (int,int) {
    if (n == 0) { return 0, 0 } else 
    { x,y := countdown(n-1); return x+1,y+1 }
};

func main() {
	fmt.Print(countdown(3)); 
	fmt.Print("\n");
};
