class Bubble 
{ 
  color c; 
 
  float x;  
  float y; 
  int seedX; 
  int seedY; 
  public int diameter; 
  float noiseInput; 
  float amp; // the width of the noise  
  float move; 
  float dSeed; 
 
  Bubble() 
  { 
 
  } 
 
  Bubble( int x, int y) 
  { 
    this.x = x; 
    this.y = y; 
    seedX = (int)random(1000); 
    seedY = (int)random(1000); 
    diameter = 50; 
    noiseInput = 1.00; // initial noise 
    dSeed = .2; 
    amp = (float)diameter; 
    move = 2; 
  } 
 
  void update() 
  { 
    if(diameter>0)
    {
      diameter = diameter-1;
    }
    
    ellipse(x,y,diameter,diameter); 
    noiseInput += dSeed; 
    // increment the x 
    noiseSeed(seedX); 
    move = amp*noise(noiseInput) - (amp/2); 
    x += move; 
    // increment the y 
    noiseSeed(seedY); 
    move = amp*noise(noiseInput) - (amp/2); 
    y += move;  
  } 
 
  /* 
    xOff = xOff + .01; 
   yOff = yOff + .01; 
   noiseSeed(horizontalSeed); 
   mx = noise(xOff) * width; 
   noiseSeed(verticalSeed); 
   amountSubtracted = noise(yOff) * 10; 
   fill(c1, 10); 
   stroke(c1); 
   ellipse(mx,my,40,40); 
   my = my - amountSubtracted; 
   */ 
 
} 

