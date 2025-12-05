package main;
import "fmt";
func f() (int,int) { return 7, 35 };
func main() {
  a,b := f();  // assignation multiple
  fmt.Print(a,b)
};