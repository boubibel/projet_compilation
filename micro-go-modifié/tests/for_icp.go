package main;
import "fmt";
func main() {
  sum := 0;
  i := 0;
  for (i < 5) { sum = sum + i; i = i + 1 };
  fmt.Print(sum)
};