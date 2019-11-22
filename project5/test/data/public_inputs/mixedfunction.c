int g(int x, bool b){
  if(b) {
    return x;
  }
  else {
    return 2*x;
  }
}

bool xor(bool a, bool b) {
  return a&&!b || b&&!a;
}

int main(){
  int x;
  bool b;
  b = xor(false,false);
  x = g(12,b);
  printf(x);
}
