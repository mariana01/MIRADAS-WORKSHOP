/**
 * talleres CCE mariana carranza
 * Example 11: Blobs Follower
 * una cortina virtual se deja subir con la mano.
 * basado en OpenCV_BlobsMovie de C.Sugrue y J. Cano TPC MedialabPrado
 * by mariana carranza.   
 */
import hypermedia.video.*;
import java.awt.*;// en Mac

OpenCV opencv;

int     w = 320; //430;
int     h = 180; //240;
int     threshold = 80;

PImage  imgLiveColor;
PImage  imgLiveGray;
PImage  imgBgCapture;
PImage  imgBinary;

Blob[] blobs;

boolean bCaptureBackground = true;
int     displayMode = 0;
float   followerY = 0;

PFont font;

//------------------------------------------
void setup(){

  size( w*2+30, h*2+60 );

  opencv = new OpenCV( this );
  opencv.capture(w,h);

  // load text font
  font = createFont("Georgia",12);
  textFont(font, 12);

  imgLiveColor    = createImage(w,h,RGB);
  imgLiveGray     = createImage(w,h,ALPHA);
  imgBgCapture    = createImage(w,h,ALPHA);
  imgBinary       = createImage(w,h,ALPHA);
}


//------------------------------------------
void draw(){

  background(0);

  updateTracking();

  if( displayMode == 0 )
  { 
    drawCVPanel();
  }
  else if( displayMode == 1 )
  {
    drawCurtain();     
  }

}

//------------------------------------------
void updateTracking()
{
  // capture input
  opencv.read();
  opencv.flip( OpenCV.FLIP_HORIZONTAL );
  imgLiveColor = opencv.image();

  // convert to grayscale
  opencv.convert(OpenCV.GRAY);
  imgLiveGray = opencv.image();

  // capture background if needed
  if( bCaptureBackground )
  {
    bCaptureBackground = false;
    imgBgCapture = imgLiveGray;
    opencv.remember(OpenCV.BUFFER);
  }

  // difference and threshold    
  opencv.absDiff();
  opencv.threshold(threshold);
  imgBinary = opencv.image();

  // find blobs
  blobs = opencv.blobs( 100, w*h/3, 20, false );

}
//------------------------------------------

void drawCurtain()
{
  // calculate value to scale by because image and screen sizes are different
  float imageToScreen     = width / float(w);

  // draw video input large
  image( imgLiveColor, 0, 0, w*imageToScreen, h*imageToScreen );

  // draw a curtain that slides to the top of the largest blob
  if( blobs.length > 0 )
  {

    Rectangle bounding_rect = blobs[0].rectangle;

    followerY = 0.9*followerY + 0.1*(bounding_rect.y*imageToScreen); // aumenta 1/10 de la distancia Y al blob[0]
    fill(255,255,255);
    //rect( bounding_rect.x*imageToScreen, bounding_rect.y*imageToScreen, bounding_rect.width*imageToScreen, bounding_rect.height*imageToScreen );
    rect( 0,0,width,followerY);
  }

}
//------------------------------------------

void drawCVPanel()
{

  image( imgLiveColor, 10, 10 );
  image( imgLiveGray, 20+w, 10 );
  image( imgBgCapture, 10, 20+h );
  image( imgBinary, 20+w, 20+h );

  noFill();
  pushMatrix();

  translate(20+w,20+h);

  for( int i=0; i<blobs.length; i++ )
  {

    Rectangle bounding_rect	= blobs[i].rectangle;
    Point centroid = blobs[i].centroid;
    Point[] points = blobs[i].points;

    // rectangle
    noFill();
    stroke(255,0,0 );
    rect( bounding_rect.x, bounding_rect.y, bounding_rect.width, bounding_rect.height );

    // centroid
    fill(255,0,0);
    rect( centroid.x-1, centroid.y-1, 2,2);
  }

  popMatrix();


  fill(255,255,255);
  text("Threshold:   " + threshold + "   |    SPACE: bg capture   |    1: cv panel   |    2: animation   |    drag mouse to change threshold", 10, height-15);

}
//------------------------------------------

void keyPressed(){
  if ( key==' ' ) bCaptureBackground = true;
  if( key == '1') displayMode = 0;
  if( key == '2') displayMode = 1;

}
//------------------------------------------

void mouseDragged(){
  threshold = int( map(mouseX,0,width,0,255) );
}
//------------------------------------------

public void stop(){
  opencv.stop();
  super.stop();
}

