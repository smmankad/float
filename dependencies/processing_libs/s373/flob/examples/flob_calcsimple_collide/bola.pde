class Bola
{

  float x,y,vx,vy;
  float g = 0.025, rad= random(5,25);
  boolean toca=false;
  Bola(){ 
    init();  
  }
  void init(){
    vx = random(-1.1,1.1);
    vy = random(1.5); 
    x = random(width);
    y = random(-100,-50);       
  }
  void update(){
    // vy+=g;
    // vx+=g;
    x+=vx;
    y+=vy;

    if(abs(vx)>3)
      vx*=0.9;
    if(abs(vy)>3)
      vy*=0.9;

    if(x<-rad){
      x=-rad;
      vx = -vx;
    }
    if(x>width+rad){
      x=width+rad;
      vx = -vx;
    }
    if(y<-100){
      y=-100;
      vy = -vy;
    }
    if(y>height-rad){
      y=height-rad;
      vy = -vy;
    }


  }
  void draw(){
    if(!toca)
      fill(0,255,0);
    else
      fill(255,0,0);
    ellipse(x,y,rad*2,rad*2); 
  }
  void run(){
    update(); 
    draw(); 
  }
}



