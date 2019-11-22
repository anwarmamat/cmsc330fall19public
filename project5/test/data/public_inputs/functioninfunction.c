int g(int x){
 return 2*x; 
}

int h() {
  return 256;
}

int main(){
  int x;
  x = g(g(2));
  while(x<=h()){
    printf(x);
    x = g(x);
  }
}
