// Demonstrates the SoftFullScreen mode. 
// softfullscreen is just a giant window on top of all the other windows
// (that is a big difference to the normal fullscreen, where the fullscreen
// window get's exclusive access to the system resources). 
// that also means you can't change resolution etc. 
// why would you use it at all then? 
// look at the dualscreen example! 
import fullscreen.*; 

SoftFullScreen fs; 

void setup(){
  // set size to 640x480
  size(640, 480);

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
