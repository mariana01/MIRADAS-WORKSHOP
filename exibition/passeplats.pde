import hypermedia.video.*;
import java.awt.*;
import ddf.minim.*;
import processing.video.*;

Capture video;

OpenCV opencv;

int     w = 320;
int     h = 240;
float scl = 2.5;
float transl;   //(width/scl-h)/2;
int threshold = 70; //127;

PFont font;

PImage  imgLiveColor;
PImage  imgLiveGray;
PImage  imgBgCapture;
PImage  imgBinary;

Blob[] blobs;

boolean bCaptureBackground = true;
boolean panels = true; //false; 
boolean contrasts, escarpe, distance, produire, reconcil;
boolean newmov;

float time;

Movie [] myMovie;
int movieCount = 4;
int switchCount = 0;

int currentMovie = 0;
String [] movieList = { 
  "escarpe-flip.mp4", //"station2.mov";
  "bar-flip.mp4", //"station1.mov";
  "fire-flip.mp4", //"station3.mov";
  "reconsiliation-flip.mp4", //"station4.mov";
};
Minim minim;
AudioPlayer player, player1;
Contrasts ctr;
Escarpe escap;
Distance dis;
Produ pr;
Recon re;
// __________________________________________
void setup() {
  size(1080, 800, P2D); //P2D);  //(800, 600, JAVA2D);  // text con JAVA2D o quitar
  smooth();
  background(0);
  //1080 X 800
  //to know the name of your camera device : println(Capture.list()); 
  video = new Capture(this, w, h);  //, "FaceCam 1000X-WDM", 30);
  opencv = new OpenCV( this );
  // opencv.capture(w, h);
  opencv.allocate(video.width, video.height);

  // load text font
  font = createFont("Georgia", 48);
  textFont(font, 12);

  imgLiveColor    = createImage(w, h, RGB);
  imgLiveGray     = createImage(w, h, ALPHA);
  imgBgCapture    = createImage(w, h, ALPHA);
  imgBinary       = createImage(w, h, ALPHA);

  myMovie = new Movie[movieCount];

  for ( int i = 0; i < movieCount; i++ ) {
    myMovie[i] = new Movie(this, movieList[i]);
   // myMovie[i].loop();
    myMovie[i].stop();
  }

  // at the center
  transl = (width/scl-h)/2;

  minim = new Minim(this);
  player = minim.loadFile("CONTRAST3.mp3", 2048);
  player1 = minim.loadFile("bar.mp3", 2048);
  ctr = new Contrasts();
  contrasts = true;
  escap = new Escarpe();
  dis = new Distance();
  pr = new Produ();
  re = new Recon();
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
  }

  if (!panels) {
    imageMode(CENTER);
    //background(0);

    if (contrasts) {
      if (newmov == false) {
        time = millis()/1000;
        newmov = true;
      }

      // run Contrasts
      ctr.run();

      float count = (millis()/1000) - time; 
      if (count > 15) { // 246  : 5 min? ::: 300
        player.setGain(-40);
        contrasts = false;
        newmov = false;
        escarpe = true;
        currentMovie = 3;
        myMovie[currentMovie].play(); //to trick switch
      }
    }

    if (escarpe) {
      if (newmov == false) {
        switchMovie();
        newmov = true;
        time = millis()/1000;
      }
      //runEscarpe();
      escap.run();

      float count = (millis()/1000) - time; 
      if (count > 60) {   //  :: 495
        escarpe = false;
        newmov = false;
        distance = true;
      }
    }

    if (distance) {
      if (newmov == false) {
        switchMovie();
        newmov = true;
        time = millis()/1000;
       
      }
      //runDistance();
      dis.run();

      float count = (millis()/1000) - time; 
      if (count > 60) {  // 2 times 172  ::: 344
        
        distance = false;
        newmov = false;
        produire = true;
      }
    }

    if (produire) {
      if (newmov == false) {
        switchMovie();
        newmov = true;
        time = millis()/1000;
      }
      //runProduire();
      pr.run();

      float count = (millis()/1000) - time; 
      if (count > 60) {   //  ::::  302
        produire = false;
        newmov = false;
        reconcil = true;
      }
    }

    if (reconcil) {
      if (newmov == false) {
        switchMovie();
        newmov = true;
        time = millis()/1000;
      }
      //runReconcil();
      re.run();

      float count = (millis()/1000) - time; 
      if (count > 60) {  // :::  346
        reconcil = false;
        newmov = false;
        contrasts = true;
      }
    }
  }


  println(frameRate);
}

//_____________________________________________
void switchMovie() {
  myMovie[currentMovie].stop();

  currentMovie++;
  if ( currentMovie > movieList.length-1 )
    currentMovie = 0;
myMovie[currentMovie].jump(0);
  myMovie[currentMovie].play();
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
  // always close Minim audio classes when you are done with them
  player.close();
  player1.close();
  minim.stop();
  opencv.stop();
  super.stop();
}

