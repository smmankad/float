class Botao {
  int id;
  float x, y, w, h,w2,h2;
  int coroff,coron;
  int gain; 
  boolean on = false;
  boolean touch = false;

  Botao(int i,  float _x, float _y, float _w , float _h  ) {
    id = i;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    w2 = w*0.5f;
    h2 = h*0.5f;    
    coroff = color(50);
    coron = color(0,250,0);
  } 


  void test(float _x, float _y, float dimx, float dimy) {
    float dx = x - _x;
    float dy = y - _y;
    if(abs(dx) <= (w2+dimx*0.5) && abs(dy) <= (h2+dimy*0.5)){
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
    fill(on ? coron : coroff,map(gain,0,100,10,255));    
    rect(x,y,w,h);
    fill(255);
    text(""+gain,x,y);
    text(""+id,x,y+h2-2);
  }

}


