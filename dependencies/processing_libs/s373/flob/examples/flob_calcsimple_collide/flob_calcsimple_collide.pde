/*
  flob calc simple collide // andré sier // 20090310
  http://s373.net
  
 puts the om to continuous difference and uses that image
 to calc the blobs. blobs are detected for collision,
 and if true, some nice ellastic collision is applied
 
 teclas: espaço, o, i, v
 
 */
import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

Capture video;
Flob flob; 


int videores=128;
int fps = 60;
PFont font = createFont("arial",10);

Bola bolas[];

boolean showcamera=true;
boolean om=true,omset=false;
float velmult = 10000.0f;
int vtex=0;


void setup(){
  //bug 882 processing 1.0.1
  try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }

  size(640,480,OPENGL);
  frameRate(fps);

  String[] devices = Capture.list();
  println(devices);

  video = new Capture(this, videores, videores,  devices[6], fps);  
  flob = new Flob(this, video, width, height);
  flob.setMirror(true,false);
  flob.setThresh(12);//25);//16);
  flob.setFade(25);//2);//10);
  flob.setMinNumPixels(10);
  flob.setImage( vtex );

  bolas = new Bola[10];
  for(int i=0;i<bolas.length;i++){
    bolas[i] = new Bola(); 
  }

  textFont(font);
}


void draw(){
  if(video.available()) {   
    if(!omset){
      if(om)
        flob.setOm(flob.CONTINUOUS_DIFFERENCE);
      else
        flob.setOm(flob.STATIC_DIFFERENCE);
      omset=true;
    }
    video.read();

    // aqui é que se define o método calc, calcsimple, ou tracksimple
    // o tracksimple é mais preciso mas mais pesado que o calcsimple

    //    flob.tracksimple(  flob.binarize(video) ); 
    flob.calcsimple(  flob.binarize(video) ); 
  }

  image(flob.getSrcImage(), 0, 0, width, height);

  //report presence graphically
  fill(255,152,255);
  rect(0,0,flob.getPresencef()*width,10);

  fill(255,100);
  stroke(255,200);
  //get and use the data
  // int numblobs = flob.getNumBlobs(); 
  int numtrackedblobs = flob.getNumTrackedBlobs();

  text("numblobs> "+numtrackedblobs,5,height-10);

  fill(255,10);
  rectMode(CENTER);
  stroke(127,200);

  trackedBlob tb;

  for(int i = 0; i < numtrackedblobs; i++) {
    tb = flob.getTrackedBlob(i);
    rect(tb.cx, tb.cy, tb.dimx, tb.dimy );
    line(tb.cx, tb.cy, tb.cx + tb.velx * velmult ,tb.cy + tb.vely * velmult );    
    String txt = ""+tb.id+" "+tb.cx+" "+tb.cy;
    text(txt,tb.cx, tb.cy);
  }

  // colisão

  float cdata[] = new float[5];
  for(int i=0;i<bolas.length;i++){
    float x = bolas[i].x / (float) width;
    float y = bolas[i].y / (float) height;
    cdata = flob.imageblobs.postcollidetrackedblobs(x,y,bolas[i].rad/(float)width); 
    if(cdata[0] > 0) {
      bolas[i].toca=true;
      bolas[i].vx +=cdata[1]*width*0.015;
      bolas[i].vy +=cdata[2]*height*0.015;
    } 
    else {
      bolas[i].toca=false; 
    }
    bolas[i].run(); 
  }

  if(showcamera){
    tint(255,150);
    image(flob.videoimg,width-videores,height-videores);
    image(flob.videotexbin,width-2*videores,height-videores);
    image(flob.videotexmotion,width-3*videores,height-videores);
  }

}

void keyPressed(){
  if(key==' ')
    flob.setBackground(video); 
  if(key=='o'){
    om^=true; 
    omset=false;
  }
  if(key=='i')
    showcamera^=true;
  if(key=='v'){
    vtex = (vtex + 1) % 4;
    flob.setVideoTex(  vtex  );
  }
}
