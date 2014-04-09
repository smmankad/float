// very basic demonstration of the fullscreen api's capabilities
import fullscreen.*; 

FullScreen fs; 
PImage img; 

void setup(){
  // set size to 640x480
  size(640, 480);

  // 5 fps
  frameRate(5);
  img = loadImage( "test.png" ); 
  
  // Create the fullscreen object
  fs = new FullScreen(this); 
  
  // enter fullscreen mode
  fs.enter(); 
}


void draw(){
  background(0);
  fill(255, 0, 0);

  for(int i = 0; i < 10; i++){
    fill(
      random(255),
      random(255),
      random(255)
    );
    rect(
      i*10, i*10,
      width - i*20, height - i*20
    );
  }
  
  image( img, 10, 10 ); 
}
