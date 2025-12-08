package main;
import "fmt";

type res struct { quo int; rem int };

func makeRes() *res {
    r := new(res);
    r.quo = 7;
    r.rem = 3;
    return r
};

func main() {
    r := makeRes();
    fmt.Print(r.quo);
    fmt.Print(" ");
    fmt.Print(r.rem);
    fmt.Print("\n");
};
