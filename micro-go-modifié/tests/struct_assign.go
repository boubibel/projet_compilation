package main;
import "fmt";
type P struct { x, y int };
func main() {
  p := new(P);
  p.x = 1;
  p.y = 2;
  fmt.Print(p.x + p.y)
};