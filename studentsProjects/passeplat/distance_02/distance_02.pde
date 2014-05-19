/**
 * Chartreuse de Valbonne, may 2014
 * Distance
 * Sophia / Isa / Tiphaine / Arthur
 * WORKSHOP MIRADAS by mariana carranza.   
 */
import hypermedia.video.*;
import java.awt.*;
import processing.video.*;

import ddf.minim.*;
float volume = 1;

AudioPlayer player;

OpenCV opencv;
Capture video;
Minim minim;
//AudioOutput out;

float taille = 1;

int     w = 320;
int     h = 240;
int c_x, c_y;

PImage  imgLiveColor;
PImage  imgLiveGray;
PImage  imgBgCapture;
PImage  imgBinary;

Blob[] blobs;

boolean bCaptureBackground = true;
boolean panels = false;

int threshold = 80;
Movie bar;
PFont font;

//------------------------------------------
void setup() {

  size(1080, 800, JAVA2D);  // 720, 576, P2D
  smooth();
  
  //to know the name of your camera device : println(Capture.list()); 
  video = new Capture(this, w, h);  //, "FaceCam 1000X-WDM", 30);
  opencv = new OpenCV( this );
  //opencv.capture(640, 480);
  opencv.allocate(video.width, video.height);
  //opencv.movie("blobs-small.mov", w, h);//capture(w,h);
  bar = new Movie(this, "bar-flip.mp4");
  bar.loop();

  imgLiveColor    = createImage(w, h, RGB);
  imgLiveGray     = createImage(w, h, ALPHA);
  imgBgCapture    = createImage(w, h, ALPHA);
  imgBinary       = createImage(w, h, ALPHA);

  minim = new Minim(this);
  player = minim.loadFile("bar.mp3", 2048);

  player.play();
  player.loop();
}
//------------------------------------------
void movieEvent(Movie bar) {
  bar.read();
}
//------------------------------------------
public void captureEvent(Capture c) {
  c.read();
}
//------------------------------------------
void draw() {
  updateTracking();
  updateSound();

  if (panels) { 
    imageMode(CORNER);
    background(0);
    drawCVPanel();
  }

  if (!panels) {
    imageMode(CENTER);
    //background(0);
    noStroke();
    fill(0, 30);
    rect(0, 0, width, height);
    scale(taille);
    image(bar, width/2, height/2);  //0,0);
  }
 // println(frameRate);
}
//------------------------------------------
void keyPressed() {
  if ( key==' ' ) bCaptureBackground = true;
  if ( key=='p' ) panels = !panels;
}

void mouseDragged() {
  threshold = int( map(mouseX, 0, width, 0, 255) );
}

//------------------------------------------
public void stop() {

  // always close Minim audio classes when you are done with them
  player.close();
  minim.stop();

  opencv.stop();
  super.stop();
}

