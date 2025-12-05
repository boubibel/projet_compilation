package main;
import "fmt";
func main() {
  x := 1;
  if (true) {
    x := 2; // shadowing local
    fmt.Print(x); // doit imprimer 2
  };
  fmt.Print(x); // doit imprimer 1
};