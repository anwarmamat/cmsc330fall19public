int foo(int x, int y) {
  int f;
  f = 41;
  return f * x - 10;
}

int loop() {
  int x;
  while (true){
    x = 1;
  }
  return 3;
}

int three() {
  printf(3);
  return 3;
}

int main() {
  int f;
  f = foo(three(), loop());
}
