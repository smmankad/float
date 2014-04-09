/*
  flob tracking example with method track

 */
import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

Capture video;
Flob flob; 
/// video params
int tresh = 10;
int fade = 25;
int om = 0;
int videores=128;
int videotex=0;//3
boolean drawimg=true;
String info="";
float fps = 60;
PFont font = createFont("monaco",10);
ArrayList blobs;

void setup(){
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }

  size(700,500,OPENGL);
  frameRate(fps);
  rectMode(CENTER);
  video = new Capture(this, videores, videores, (int)fps);  
  flob = new Flob(this, video, width, height);
  flob.setOm(om);
  //  flob.setMirror(true,false); 
  flob.setThresh(tresh);
  flob.setSrcImage(videotex);
  textFont(font);
}



void draw(){
  if(video.available()) {
    video.read();
    blobs = flob.track(  flob.binarize(video) );    
  }
  image(flob.getSrcImage(), 0, 0, width, height);

  fill(255,100);
  stroke(255,200);
  rectMode(CENTER);

  for(int i = 0; i < blobs.size(); i++) {
    trackedBlob tb = flob.getTrackedBlob(i);
   
    String txt = "id: "+tb.id+" time: "+tb.presencetime+" ";
    float velmult = 100.0f;
    fill(220,220,255,100);
    rect(tb.cx,tb.cy,tb.dimx,tb.dimy);
    fill(0,255,0,200);
    rect(tb.cx,tb.cy, 5, 5); 
    fill(0);
    line(tb.cx, tb.cy, tb.cx + tb.velx * velmult ,tb.cy + tb.vely * velmult ); 
    text(txt,tb.cx -tb.dimx*0.10f, tb.cy + 5f);   
  }



  // stats
  fill(255,152,255);
  rectMode(CORNER);
  rect(5,5,flob.getPresencef()*width,10);
  String stats = ""+frameRate+"\nflob.numblobs: "+blobs.size()+"\nflob.thresh:"+tresh+
                 " <t/T>"+"\nflob.fade:"+fade+"   <f/F>"+"\nflob.om:"+flob.getOm()+
                 "\nflob.image:"+videotex+"\nflob.presence:"+flob.getPresencef();
  fill(0,255,0);
  text(stats,5,25);

    
}

void keyPressed(){
  if(key=='b')
    drawimg^=true;
  if (key=='S')
    video.settings();
  if (key=='s')
    saveFrame("monoflob-######.png");
  if (key=='i'){  
    videotex = (videotex+1)%4;
    flob.setImage(videotex);
  }
  if(key=='t'){
    tresh--;
    flob.setTresh(tresh);
  }
  if(key=='T'){
    tresh++;
    flob.setTresh(tresh);
  }   
  if(key=='f'){
    fade--;
    flob.setFade(fade);
  }
  if(key=='F'){
    fade++;
    flob.setFade(fade);
  }   
  if(key=='o'){
    om^=1;
    flob.setOm(om);
  }   
  if(key==' ') //space clear flob.background
    flob.setBackground(video);
 
}

