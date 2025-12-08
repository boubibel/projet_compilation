package main;
import "fmt";

/* a, b entiers naturels, b > 0 */
func div1(a,b int) (int,int) {
    if (a < b) { return 0, a } else 
    { x,y := div1(a-b,b); return x+1,y }
};

func main() {
	fmt.Print(div1(45,6)); 
	fmt.Print("\n");
};
