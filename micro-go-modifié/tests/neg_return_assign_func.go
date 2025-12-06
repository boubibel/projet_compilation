package main;
func g() (int,int) { return 1,2 };
func main() {
  a := g(); // erreur attendue : multiple values in assignment
};