// demonstrates the use of a sketch that spans over two screens. 
// you need to manually set the resolution of each screen to 
// 1024x768 (both screens need to be the same!)
// then run this sketch. 

import fullscreen.*; 

SoftFullScreen fs; 

void setup(){
  // set size to 640x480
  size(2048, 768);

  // 5 fps
  frameRate(5);

  // Create the fullscreen object
  fs = new SoftFullScreen(this); 
  
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
}
