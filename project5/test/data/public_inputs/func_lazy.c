int foo(int x, int y, int z) {
  int f;
  f = 41;
  return f * x - 10;
}

int three() {
  printf(3);
  return 3;
}

int four() {
  printf(4);
  return 4;
}

int thousand() {
  printf(1000);
  return 1000;
}

int main() {
  int f;
  f = foo(three(), four(), thousand());
}
