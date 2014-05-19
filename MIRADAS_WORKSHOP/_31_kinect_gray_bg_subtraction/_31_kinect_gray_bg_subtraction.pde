/* --------------------------------------------------------------------------
 * SimpleOpenNI Images Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * --------------------------------------------------------------------------
 * workshop MIRADS _ may 2014 _ Bagnols-sur-Cèze
 * Example 31 gray
 * mariana carranza 
 * --------------------------------------------------------------------------
 */

import SimpleOpenNI.*;
SimpleOpenNI  kinect;

int numpix;

int kw = 640;
int kh = 480;
PImage img1, img2;

// -----------------------------------------------------------------
void setup() {

  size(kw, kh); //(1280, 960);   // (kw*scl, kh*scl);  //, OPENGL);  //P2D);
  background(0);
  //frameRate(10);  //(24);

  kinect = new SimpleOpenNI(this);
  //kinect.setMirror(true);
  kinect.enableRGB();
  kinect.enableDepth();
  
  numpix = kinect.depthWidth() * kinect.depthHeight();

  // align depth data to image data
  kinect.alternativeViewPointDepthToImage();  // solo si se necesita...

  img1 = loadImage("salvador.JPG");
  img1.resize(kinect.depthWidth(), kinect.depthHeight());
  img2 = createImage(kinect.depthWidth(), kinect.depthHeight(), RGB);
  img1.loadPixels();
  img2.loadPixels();
}

// -----------------------------------------------------------------
void draw() {

  background(0);

  kinect.update();
  //image(kinect.rgbImage(), 0, 0);
  //image(kinect.depthImage(), 0, 0);
  //image(kinect.userImage(),0,0);


  for (int i = 0; i < numpix; i++) {
    
    float gry = brightness(kinect.depthImage().pixels[i]);

    // if is users pixels 
    if ( gry > 200) {
      img2.pixels[i] = kinect.rgbImage().pixels[i];
    }
    else {
      img2.pixels[i] =img1.pixels[i];
    }
  }

  img2.updatePixels();

  image(img2, 0, 0);
}

