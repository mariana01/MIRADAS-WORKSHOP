import hypermedia.video.*;
import java.awt.*;

import processing.video.*;

Capture video;

Movie myMovie;

OpenCV opencv;

int     w = 320;
int     h = 240;
float scl = 2.5;
int threshold = 70; //127;

PImage  imgLiveColor;
PImage  imgLiveGray;
PImage  imgBgCapture;
PImage  imgBinary;

Blob[] blobs;

boolean bCaptureBackground = true;
boolean panels = true; //false; 

int que;
int buttonX_1, buttonX_2;
int buttonY_1, buttonY_2;

float jumpCod;
boolean allowjump;
int count;
int transp;
float transl;   //(width/scl-h)/2;

// __________________________________________
void setup() {
  size(1080, 800, P2D);  //(800, 600, JAVA2D);
  background(0);
  //1080 X 800
  //to know the name of your camera device : println(Capture.list()); 
  video = new Capture(this, w, h);  //, "FaceCam 1000X-WDM", 30);
  opencv = new OpenCV( this );
  // opencv.capture(w, h);
  opencv.allocate(video.width, video.height);

  myMovie = new Movie(this, "escarpe-flip.mp4");
  //myMovie = new Movie(this, "/Users/Supergreen/Documents/Processing/Video_SafeUp_Script/data/station.mov");
  myMovie.loop();

  buttonY_1 = h/2 - 40;
  buttonY_2 = h/2 + 40;

  buttonX_1 = 0;
  buttonX_2 = 80;

  transl = (width/scl-h)/2;
  imageMode(CENTER);
  println(frameRate);
}

// __________________________________________
void movieEvent(Movie myMovie) {
  myMovie.read();
}
//------------------------------------------
public void captureEvent(Capture c) {
  c.read();
}
// __________________________________________
void draw() {

  updateTracking();

  if (panels) {  
    imageMode(CORNER);
    background(0);
    drawCVPanel();
    fill (250);
    rect(buttonX_1, buttonY_1, buttonX_2 - buttonX_1, buttonY_2 - buttonY_1);
  }

  if (!panels) {
    imageMode(CENTER);
    background(0);
    //transp = 20;
    drawSomething();
    image(myMovie, width/2, height/2 ); 
    //pushMatrix();
    //scale(scl);
    //rotate(-PI/2);
    //translate(-w, transl);
    noFill();
    strokeWeight(2);
    stroke(255, transp);
    //rect(buttonX_1, buttonY_1, buttonX_2 - buttonX_1, buttonY_2 - buttonY_1);
    rect((width/2)-80, height-170, 160, 160);
    //popMatrix();
    transp -=3;
    transp = constrain(transp, 30, 255);
  }


  println(frameRate);
}

//------------------------------------------
void keyPressed() {
  if ( key==' ' ) bCaptureBackground = true;
  if ( key=='p' ) panels = !panels;
}

void mouseDragged() {
  threshold = int( map(mouseX, 0, width, 0, 255) );
}

//-----------------------------------------------------------------------------
// Clean resources
public void stop() {
  opencv.stop();
  super.stop();
}

