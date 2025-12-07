package main;
import "fmt";

func div2(a,b int) int {
    q := 0;
    for (a >= b) { q++; a=a-b };
    return q
  };

func main() {
	fmt.Print(div2(45,6));
	fmt.Print("\n");
};
