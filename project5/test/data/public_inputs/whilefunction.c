int g(){
 return 2; 
}

int main(){
  int x;
  x = 1;
  while(x<=g()){
    printf(x);
    x = x+1;
  }
}
