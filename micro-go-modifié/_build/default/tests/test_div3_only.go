package main;
import "fmt";

type res struct { quo int; rem int };
func div3(a,b int) *res {
    r := new(res);
    r.quo = 7;
    r.rem = 3;
    return r
};

func main() {
	r:=div3(45,6); 
	fmt.Print(r.quo,r.rem); 
	fmt.Print("\n");
	fmt.Print(r); 
	fmt.Print("\n");
};
