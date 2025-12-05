package main;
import "fmt";
func f() (int,int) { return 7, 35 };
func main() {
  a,b := f();
  fmt.Print(a,b)
};