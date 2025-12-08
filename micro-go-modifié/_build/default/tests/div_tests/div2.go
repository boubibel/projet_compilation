package main;
import "fmt";

/* a, b entiers naturels, b > 0 */
func div2(a,b int) (int,int) {
    q := 0;
    for (a >= b) { q++; a=a-b };
    return q, a
};

func main() {
	fmt.Print(div2(45,6)); 
	fmt.Print("\n");
};
