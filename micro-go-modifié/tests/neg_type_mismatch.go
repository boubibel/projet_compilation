package main;
func f(x int) int { return x+1 };
func main() {
  f("hello"); // erreur attendue : string != int
};