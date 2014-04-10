/*

 flob is a flood-fill multi-blob detector, 
 tracks blobs in image streams,their centroids and bounding boxes
 http://s373.net/code/flob
 
 flob 001k is not backwards compatible. some functions were obliterated
 in favour of a simpler access scheme to the data. 
 two types of classes hold all info in desired coordinates:
 ABlob has all main fields, trackedBlob has some extra fields.
 fields are: cx, cy for current centroid coords; dimx, dimy current dims, etc
 (please check the javadocs/src code to see check all fields)
 
 trackedBlob extends ABlob, so you can always undercast as ABlob
 the tracking methods available: calc, calcsimple, track, tracksimple
 
 steps:
 0. construct a flob object with video,  width and height: 
 sets desired world coordinate return values for data
 1. configure tracker (setOm, setTresh, setFade, setMirror, setBlur, setSrcImage, ...)
 2. when new video frame arrives, pass it to binarize and the to one of the tracking 
 methods available, which returns an ArrayList with the blobs
 3. access each blob individually and plug in the values from there to your program
 
 */

import processing.opengl.*;
import processing.video.*;
import s373.flob.*;
import fullscreen.*; 

SoftFullScreen fs; 

/// audio
import ddf.minim.*;
import ddf.minim.signals.*;

AudioPlayer player;
Minim minim;
AudioOutput out;
SineWave sine;

//Bubble declarations
int maxNum = 20; 
Bubble[] array; 


/// Time Parameters

int m = 0;  // Values from 0 - 59
int im = 0;
float h=0;
int counter = 0;
/// vars
Capture video;
Flob flob; 
ArrayList blobs; // an ArrayList to hold the gathered blobs
PImage pal; //Palette
int px, py; //Random Holds for Palette color selections.
color pix; //The color var
randomShape rs; //The business logic of the graphic section.

/// video params
int tresh = 20;       //adjust treshold value here or keys t/T!!
int fade = 25;
int om = 1;
int videores=128;//64//256
boolean drawimg=false; // key 'i' toggles draw
String info="";
PFont font;
float fps = 60;
int videotex = 0; //case 0: videotex = videoimg;//case 1: videotex = videotexbin; 
//case 2: videotex = videotexmotion//case 3: videotex = videoteximgmotion;

Botao b1;

// perlin for y axis
float t = 0.0;
float inc = 0.01;


void setup(){
  //  minim = new Minim(this);
  //  player = minim.loadFile("ding.wav", 2048);
  //  out = minim.getLineOut(Minim.STEREO);
  //  // create a sine wave Oscillator, set to 440 Hz, at 0.5 amplitude, sample rate from line out
  //  sine = new SineWave(440, 0.5, out.sampleRate());
  //  // set the portamento speed on the oscillator to 200 milliseconds
  //  sine.portamento(200);
  //  // add the oscillator to the line out
  //  out.addSignal(sine);
  ////////////////////////////
  ////////////////////////////
  ////////////////////////////
  background(0);
  array = new Bubble[ maxNum ];
  //bug 882 processing 1.0.1
  try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }

  pal = loadImage("palette.jpg"); //Initialize the palette
  rs = new randomShape("drawing_"); //Initialize the randomShape object for Vector art display.  

  ////SCREEN 4:3 Aspects (Standard Definition)
  //size(640,480); 
  //size(800,600);
  //size(1024,768);
  //  size(2880,900);
  size(2047,900);

  ////SCREEN 16:9 Aspects (Wide and HD)
  //size(852,480); //480p HD
  //size(1280,720); //720p HD
  //size(1920,1080); //1080p HD
  //frame.setLocation(0,0);
  frameRate(fps);
  rectMode(CENTER);
  smooth();
  // init video data and stream
  video = new Capture(this, videores, videores, (int)fps);  
  // init blob tracker
  flob = new Flob(this, video, width,height); // new: pass world coords, get values in those ranges

  flob.setTresh(tresh); //set the new threshold to the binarize engine
  flob.setThresh(tresh); //typo
  flob.setSrcImage(videotex);
  flob.setImage(videotex); //  pimage i = flob.get(Src)Image();

  flob.setBackground(video); // zero background to contents of video
  flob.setBlur(0); //new : fastblur filter inside binarize
  flob.setMirror(true,false);
  flob.setOm(0); //flob.setOm(flob.STATIC_DIFFERENCE);
  flob.setOm(1); //flob.setOm(flob.CONTINUOUS_DIFFERENCE);
  flob.setFade(fade); //only in continuous difference

    font = createFont("monaco",9);
  textFont(font);
  im = minute();
  smooth();
  noCursor();

  //b1 = new Botao(width/2,height/2,100,70);
  // Create the fullscreen object
  fs = new SoftFullScreen(this); 

  // enter fullscreen mode
  fs.enter(); 
}



void draw(){
  //background(0);
  m = minute();
  if(abs(m-im)==1){
    background(0);
    im = minute();
  }


  if(!drawimg)
    //    background(0);

    // main image loop
    if(video.available()) {
      video.read();

      //  flob.calc(  flob.binarize(video) );    
      //  blobs = flob.track(  flob.binarize(video) );    // blobs is now 
      // arraylist of <trackedBlob> type
      // and method is track, so getnumtrackedblobs + flob.getTrackedBlob(i)

      // flob.calc calcs current blobs and returns an arraylist with the data
      blobs = flob.calc(flob.binarize(video));    

    }

  //write test image to frame
  if(drawimg)
    image(flob.getSrcImage(), 0, 0, width, height);

  rectMode(CENTER);

  //get and use the data
  int numblobs = blobs.size();//flob.getNumBlobs();  
  px = int(random(pal.width));
  py = int(random(pal.height));
  pix = pal.get(px,py);

  // no need
  //  float center[] = new float[2];
  //  float dim[] = new float[2];

  for (int i = 0; i < maxNum; i++ ) 
  {   
    if( array[i] != null ) 
    { 
      array[i].update(); 
    } 
  } 
  for(int i = 0; i < numblobs; i++) {

    ABlob ab = (ABlob)flob.getABlob(i); 
    //     trackedBlob tb = (trackedBlob)flob.getTrackedBlob(i); 
    //now access all blobs fields.. float tb.cx, tb.cy, tb.dimx, tb.dimy...

    // inserir teste espacial aqui
    // b1 é testado para todas as blobs detectadas
    //b1.test(ab.cx,ab.cy, ab.dimx, ab.dimy);

    //box
    ////////////////////RECT MAPS FOR FLOBS////////////////
    //    fill(0,0,255,100);
    //    rect(ab.cx,ab.cy,ab.dimx,ab.dimy);
    //    //centroid
    //    fill(0,255,0,200);
    //    rect(ab.cx,ab.cy, 5, 5);
    //    info = ""+ab.id+" "+ab.cx+" "+ab.cy;
    //    println(ab.cx+" "+ab.cy);
    //    text(info,ab.cx,ab.cy+20);
    ////////////////////RECT MAPS FOR FLOBS////////////////
    //Vector Forms Fire function.
    //rs.fire(ab.cx,ab.cy,pix);
    counter++;
    //    delay(100);
    noStroke();
    fill(pix);
    //ellipse(mouseX,mouseY,50,50); 

    //float pix2 = color(pix);


    //h=0; //reset transparency
    array[(int)random(maxNum-1)] = new Bubble(int(ab.cx),height/2);
    //filter(ERODE);
    //filter(DILATE);
    //    if(counter%1==0)
    //    {
    //      println(counter);
    //      player.play();
    //      player.rewind();
    //      float freq = map(ab.cy, 0, height, 1500, 60);
    //      sine.setFreq(freq);
    //      //pan always changes smoothly to avoid crackles getting into the signal
    //      //      // note that we could call setPan on out, instead of on sine
    //      //      // this would sound the same, but the waveforms in out would not reflect the panning
    //      float pan = map(ab.cx, 0, width, -1, 1);
    //      sine.setPan(pan);
    //    }

    /////// extra stuff
    //    int di = int(random(1,80));
    //    //colorMode(HSB);
    //    noStroke();
    //    fill(pix);
    //    ellipse(ab.cx,ab.cy,di,di);
    //    noStroke();
    //    fill(255,240);
    //    int di2 = int(random(80,200));
    //    ellipse(ab.cx,ab.cy,di2,di2);

    //    // doesnt work accurately
    //        if( h == 255){ 
    //          h=0;
    //        }
    //        fill(255,h);
    //        rectMode(CORNER);
    //        rect(0,0,screen.width,screen.height);
    //        h = h+.1;



    //b1.render();
    //report presence graphically
    //  fill(255,152,255);
    //  rectMode(CORNER);
    //  rect(5,5,flob.getPresencef()*width,10);
    String stats = ""+frameRate+"\nflob.numblobs: "+numblobs+"\nflob.thresh:"+tresh+
      " <t/T>"+"\nflob.fade:"+fade+"   <f/F>"+"\nflob.om:"+flob.getOm()+
      "\nflob.image:"+videotex+"\nflob.presence:"+flob.getPresencef();
    //  fill(0,255,0);
    //text(stats,5,25); ///for HUD on screen



  }

}
void keyPressed(){
  if(key=='b')
    background(0);
  if (key=='S')
    video.settings(); 
  if (key=='s')
    saveFrame("flob001k-######.png");
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
void stop()
{
  //  out.close();
  //  minim.stop();

  super.stop();
}








