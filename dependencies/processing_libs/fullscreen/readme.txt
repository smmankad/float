Fullscreen API for Processing, Version 0.98
-------------------------------------------

  Thanks for download the Fullscreen API for Processing, this is still 
experimental software, especially if you are considering to use it in 
combination with opengl. For examples, documentation and the latest version
see http://www.superduper.org/processing/fullscreen_api/

  To install this drag the whole fullscreen folder into sketches/libraries/. 
If you have <sketches>/libraries/fullscreen/library/fullscreen.jar in place
after copying the folder over you did everything right. After relaunching 
processing check if sketch > import has an item labeled fullscreen. That means
everything is perfectly fine. Now copy and paste this code into processing 
to get started: 

import fullscreen.*; 

FullScreen fs; 

void setup(){
  // set size to 640x480
  size(640, 480);

  // 5 fps
  frameRate(5);

  // Create the fullscreen object
  fs = new FullScreen(this); 
  
  // enter fullscreen mode
  fs.enter(); 
}


void draw(){
  background(0);
  fill(255, 0, 0);

  for(int i = 0; i &lt; 10; i++){
    fill( random(255), random(255), random(255) );
    rect(
      i*10, i*10,
      width - i*20, height - i*20
    );
  }
}


  If you have any questions, suggestions or other trouble you can email me
to it-didnt-work@superduper.org, contact me in the processing discourse 
section or start hanging out in the channel #processing on irc.freenode.net 
(my username is hansi). 


  This software is released under the GPLv3, you should have received a copy of
it with this document, if you didn't, see http://www.gnu.org/licenses/gpl-3.0.txt

 