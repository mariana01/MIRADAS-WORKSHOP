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
 * Example 30
 * mariana carranza 
 * --------------------------------------------------------------------------
 */

import SimpleOpenNI.*;

SimpleOpenNI  kinect;
// the kinekt size 640 x 480

boolean visibleUser;

//--------------------------------------------------------------------------
void setup()
{
  size(645, 485);  //(640*2+10, 480*2+10);
  smooth();

  kinect = new SimpleOpenNI(this);

  // mirror is by default enabled
  // kinect.setMirror(false);

  // enable depthMap generation 
  // depth image is calculated using the IR camera and the shadow of IR points projected onto the scene
  kinect.enableDepth();

  // enable RGB generation
  // RGB camera is a standard webcam | note that it cannot be used when the IR image is enabled
  kinect.enableRGB();

  // enable ir generation
  // IR image is what the IR camera sees | cannot be used when the RGB image is enabled
  // kinect.enableIR();

  // enable scene analysis
  // distinguishes multiple objects in the scene | only works when the depth is enabled
  // users skeleton - joints -
  kinect.enableUser();
}

//--------------------------------------------------------------------------
void draw()
{
  // update the cam
  kinect.update();

  background(0);

  scale(.5);

  // draw depthImageMap
  image(kinect.depthImage(), 0, 0);

  // draw rgbImage
  image(kinect.rgbImage(), kinect.depthWidth() + 10, 0);

  // draw irImageMap
  // in ths place rgbImage OR irImage ⁄⁄ NO both together
  // image(kinect.irImage(), kinect.depthWidth() + 10, 0);

  // draw users
  image(kinect.userImage(), 0, kinect.depthHeight() + 10);



  if (visibleUser) {
    fill(0, 255, 0);
  }
  if (!visibleUser) {
    fill(255, 0, 0);
  }
  ellipse(3*kinect.depthWidth()/2, 3*kinect.depthHeight()/2, 40, 40);
}
//--------------------------------------------------------------------------

// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  //println("\tstart tracking skeleton");
  //curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
  visibleUser = false;
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  println("onVisibleUser - userId: " + userId);
  visibleUser = true;
}

