// You can use the fullscreen api to find out which 
// resolutions are available on your computer
import fullscreen.*; 

void setup(){
  // set size to 640x480
  size(640, 480);

  // list available resolutions
  println( "Resolution for screen 0: " ); 
  println( FullScreen.getResolutions( 0 ) ); 
  
  exit(); 
}
