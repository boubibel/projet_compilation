package main;
import "fmt";
func sideEffect() int { fmt.Print(9); return 1 };
func main() {
  if (0 != 0 && sideEffect() != 0) { fmt.Print(1) } else { fmt.Print(0) };
  // si && fait court-circuit, sideEffect ne doit pas imprimer, donc doit renvoyer 0
};