package main;
import "fmt";

/* Version avec retour d'une structure */
type res struct { quo int; rem int };
func div3(a,b int) *res {
    r := new(res);
    r.quo = 0;
    for (a >= b) { 
        r.quo++; 
        fmt.Print(a);
        fmt.Print(" ");
        a=a-b;
        fmt.Print(a);
        fmt.Print("\n");
    };
    r.rem = a;
    return r
};

func main() {
	r:=div3(45,6); 
	fmt.Print(r.quo); 
	fmt.Print("\n");
	fmt.Print(r.rem); 
	fmt.Print("\n");
};
