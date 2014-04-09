
class Monoflob{
  Botao b[];
  int gx,gy,num;
  float dimx,dimy;
  float sizex,sizey;//1.0 max
  
  Monoflob(int _gx, int _gy){
    gx = _gx;
    gy = _gy;
    sizex = 0.75;
    sizey = 0.55;
    float stridex = (float)width / (float)gx;
    float stridey = (float)height / (float)gy;
    dimx = stridex * sizex ;
    dimy = stridey * sizey ;
    
    num = gx * gy;    
    b = new Botao[num];

    for(int i=0; i<num;i++){
       float x =  ((float)(i % gx) +0.5) * stridex  ;
       float y = ((float)(i / gx) +0.5) *stridey ;
       b[i] = new Botao(i, x,y,dimx,dimy);      
    }        
        
  }
  
  void touch(float x, float y,float w, float h){    
    for(int i=0; i<num; i++)
      b[i].test(x,y,w,h);    
  }

  void render(){
    for(int i=0; i<num; i++)
      b[i].render();   
  }


}

