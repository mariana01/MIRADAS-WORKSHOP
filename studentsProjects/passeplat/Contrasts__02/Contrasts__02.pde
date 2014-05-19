/**
 * Chartreuse de Valbonne, may 2014
 * Contrasts
 * Eunice Labor / Victor Modin / Elinor Larsson
 * WORKSHOP MIRADAS by mariana carranza.   
 */
import hypermedia.video.*;
import java.awt.*;
import ddf.minim.*;
import processing.video.*;

Capture video;

OpenCV opencv;

Minim minim;
AudioPlayer player;
//AudioOutput out;


int     w = 320;
int     h = 240;
int c_x, c_y;

float scl = 2.5;  //height/video.width = 800/w
float transl;   //(width/scl-h)/2;

PImage  imgLiveColor;
PImage  imgLiveGray;
PImage  imgBgCapture;
PImage  imgBinary;

Blob[] blobs;

boolean bCaptureBackground = true;
boolean panels = true;

int threshold = 80;

PFont font;
int ftrans = 255;  //font transparency

//------------------------------------------
void setup() {

  size(1080, 800, JAVA2D);  //( w*2+10, h*2+20, JAVA2D);  // P2D
  smooth();
  

  //to know the name of your camera device : println(Capture.list()); 
  video = new Capture(this, w, h);  //, "FaceCam 1000X-WDM", 30);
  opencv = new OpenCV( this );
  //opencv.capture(w, h);
  opencv.allocate(video.width, video.height);
  //opencv.movie("blobs-small.mov", w, h);//capture(w,h);

  // load text font
  font = createFont("Georgia", 12);
  textFont(font, 12);

  imgLiveColor    = createImage(w, h, RGB);
  imgLiveGray     = createImage(w, h, ALPHA);
  imgBgCapture    = createImage(w, h, ALPHA);
  imgBinary       = createImage(w, h, ALPHA);

  initSound();

  // at the center
  transl = (width/scl-h)/2;
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
    background(0);
    drawCVPanel();
  }

  if (!panels) {
    //background(0);
    noStroke();
    fill(0, 50);
    rect(0, 0, width, height);

    // circle????
    fill(255);
    scale (scl);
    rotate(-PI/2);
    translate (-w, transl);
    ellipse(c_x, c_y, 10, 10);

    if(ftrans>0){
    stroke(255, ftrans);
    noFill();
    textFont(font, 48);
    text("Contrasts", 10, h-15);
    ftrans -= 5;
    }

    /*
    //test position
     noFill();
     stroke(255);
     rect(0, 0, w, h);
     stroke(255, 0, 0);
     line(0, 0, w, 0);
     */
  }
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

