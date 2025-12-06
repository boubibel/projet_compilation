package main;
import "fmt";
type T struct { v int };
func main() {
  var p *T;
  p = new(T);
  if (p == nil) { fmt.Print(0) } else { fmt.Print(1) };
};