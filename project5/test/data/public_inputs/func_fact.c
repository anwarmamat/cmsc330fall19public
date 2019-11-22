int fact(int x) {
  if(x == 0) {
    return 1;
  }
  else {
    return fact(x - 1) * x;
  }
}

int main() {
  int f;
  f = fact(10);
}
