/**
 * talleres CCE mariana carranza
 * Example 03: Motion detection with frame differencing
 * Motion aumont by access pixels
 * basado en TPC medialab-prado
 * by mariana carranza.   
 */
 
import hypermedia.video.*;

// opencv object
OpenCV   opencv;

// camera input size
int w = 320;
int h = 240;

// threshold for differencing
int threshold = 80;

// array to hold pixels
color [] cv_pixels;

// font for display
PFont font;

//-----------------------------------------------------------------------------
// Initialization
void setup()
{
  size(w*3,h + 20);

  opencv = new OpenCV( this );       // create opencv object
  opencv.capture(w,h);               // create opencv capture

  font = createFont("Georgia",12);   // load text font
  textFont(font, 12);
}
//-----------------------------------------------------------------------------
// Main loop
void draw()
{
  background(0);
  
  opencv.read();                      // Capture image from camera

  image( opencv.image(), 0, 0 );      // Draw color input image from camera
  text("Color imput image", 10, h+15);

  opencv.convert(OpenCV.GRAY);        // Convert input image to grayscale and draw
  image( opencv.image(), 320, 0 );    // Draw grayscale input image
  text("Gray scale image", 320 + 10, h+15);

  opencv.absDiff();                   // Absolute differencing between frames

  opencv.threshold(threshold);        // Apply threshold and draw result
  image( opencv.image(), 640, 0 );    // Draw result . sin threshol no hay pix blancos para calcular el "movimiento"

  
  cv_pixels = opencv.pixels();        // Accede a los pixels

  int whitePixels = 0;
  for (int i = 0; i < w*h; i++)
  {
    if ( brightness( cv_pixels[i]) == 255 )  //Count number of white pixels (with motion)
      whitePixels++;
  }
  text("Frame differencing | Motion amount: " + whitePixels, 640 + 10, h+15);

  opencv.remember(OpenCV.SOURCE);       // Store previous frame in memory
}
//-----------------------------------------------------------------------------
// Control mouse

void mouseDragged() {
  threshold = int( map(mouseX,0,width,0,255) );
}
//-----------------------------------------------------------------------------
// Clean resources
void stop() {
  opencv.stop();
  super.stop();
}

