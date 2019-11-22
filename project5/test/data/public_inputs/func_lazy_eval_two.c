int foo(int x, int y) {
  int f;
  f = 41;
  return f + x;
}

int one() {
  printf(1);
  return 1;
}

int two() {
  printf(2);
  return 2;
}

int main() {
  int f;
  f = foo(one(), two());
}
