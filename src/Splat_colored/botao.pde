class Botao {
  float x, y, w, h,w2,h2;
  int coroff,coron;
  int gain; 
  boolean on = false;
  boolean touch = false;

  Botao( float _x, float _y, float _w , int _h  ) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    w2 = w*0.5f;
    h2 = h*0.5f;    
    coroff = color(50);
    coron = color(0,150,0);
  } 


  void test(float _x, float _y, float dimx, float dimy) {
    float dx = x - _x;
    float dy = y - _y;
    if(abs(dx) <= (w2+dimx*0.25) || abs(dy) <= (h2+dimy*0.25)){
      gain++;  
      touch = true;
    }
  }

  void state(){    
    if(touch)
      touch=false;
    else
      gain--;
      
    if(gain>100){
      gain = 100;
      on = true; 
    }
    if(gain<50)
      on = false;
    if(gain<0)
      gain=0;
  }

  void render(){
    state();
    int c0 = on ? coron : coroff;
  //  int c1 = on ? coroff : coron;
    fill(c0,250);    
    rect(x,y,w,h);
    fill(255);
    text(""+gain,x,y+5);
  }

}


