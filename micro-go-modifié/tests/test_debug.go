package main;
import "fmt";

func ret(a, b int) (int,int) {
    fmt.Print("ret: a="); fmt.Print(a); fmt.Print(" b="); fmt.Print(b); fmt.Print("\n");
    return a, b
};

func test(a, b int) (int,int) {
    fmt.Print("test: a="); fmt.Print(a); fmt.Print(" b="); fmt.Print(b); fmt.Print("\n");
    x,y := ret(a, b);
    fmt.Print("test: x="); fmt.Print(x); fmt.Print(" y="); fmt.Print(y); fmt.Print("\n");
    fmt.Print("test: x+a="); fmt.Print(x+a); fmt.Print(" y+b="); fmt.Print(y+b); fmt.Print("\n");
    return x+a, y+b
};

func main() {
	fmt.Print(test(7, 3)); 
	fmt.Print("\n");
};
