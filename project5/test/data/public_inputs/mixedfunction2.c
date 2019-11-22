int f(int a, int b, int c, int d, bool e) {
  if(b>a) {
    return f(b,a,c,d,!e);
  }
  else {
    if(c>a) {
      return f(c,b,a,d,!e);
    }
    else {
      if(d>a) {
        return f(d,b,c,a,!e);
      }
      else {
        if(c>b){
          return f(a,c,b,d,!e);
        }
        else {
          if(d>b){
            return f(a,d,c,b,!e);
          }
          else {
            if(d>c) {
              return f(a,b,d,c,!e);
            }  
            else {
              if(e == true) {
                return (a-b)*(c-d);
              }
              else {
                return a*a+b*b+c*c+d*d;
              }
            }
          }
        }
      }
    }
  }
}

int main(){
  for (k from 1 to 5) {
    printf(f(1,1,1,k,true));
    printf(f(1,1,1,k,false));
  }
}
