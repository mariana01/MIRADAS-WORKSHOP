/**
 * talleres CCE mariana carranza
 * Example 06: motionBlur
 * by mariana carranza.   
 */
import hypermedia.video.*;        //  Imports the OpenCV library
OpenCV opencv;                    //  Creates a new OpenCV Object
PImage trailsImg;                 //  Image to hold the trails

void setup()
{

  size( 320, 240 );

  opencv = new OpenCV( this );    //  Initialises the OpenCV object
  opencv.capture( 320, 240 );     //  Opens a video capture stream
  trailsImg = createImage( 320, 240, RGB );  //  Initialises trailsImg
}

void draw()
{

  opencv.read();                  //  Grabs a frame from the camera
  opencv.absDiff();               //  Calculates the absolute difference
  opencv.convert(OpenCV.GRAY);    //  Convert to grayscale
  opencv.blur( OpenCV.BLUR, 3 );  //  Blur before taking the difference image to reduce camera noise
  opencv.threshold(50);           //  Aply threshol results binary image
  
  trailsImg.blend( opencv.image(), 0, 0, 320, 240, 0, 0, 320, 240, SCREEN );  //  Blends the movement image with the trails image
  
  image( trailsImg, 0, 0 );       //  Display the blended difference image
  
  opencv.copy( trailsImg );       //  Copies trailsImg into OpenCV buffer so we can put some effects on it
  opencv.blur( OpenCV.BLUR, 3 );  //  Blurs the trails image
  opencv.brightness( -10 );       //  Sets the brightness of the trails image to -20 so it will fade out
  trailsImg = opencv.image();     //  Puts the modified image from the buffer back into trailsImg
  
  opencv.remember(OpenCV.SOURCE); //  Remembers the current frame original (source)
}



void stop() {                      // Clean resources
  opencv.stop();
  super.stop();
}

