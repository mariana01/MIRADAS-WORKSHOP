/* --------------------------------------------------------------------------
 * SimpleOpenNI User skeleton
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 * workshop MIRADS _ may 2014 _ Bagnols-sur-Cèze
 * Example 33 - users
 * mariana carranza 
 * --------------------------------------------------------------------------
 */

import SimpleOpenNI.*;

SimpleOpenNI  kinect;

// -----------------------------------------------------------------
void setup()
{
  size(640, 480);

  kinect = new SimpleOpenNI(this);

  if (kinect.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  // enable depthMap generation 
  kinect.enableDepth();

  // enable skeleton generation for all joints
  kinect.enableUser();

  // align depth data to image data
  kinect.alternativeViewPointDepthToImage();  // solo si se necesita...


  stroke(0, 0, 255);
  strokeWeight(3);
  smooth();
}

// -----------------------------------------------------------------
void draw()
{
  // update the cam
  kinect.update();

  background(0);

  // draw depthImageMap  | you can use a image in the background
  tint(255, 100);
  image(kinect.depthImage(), 0, 0);
  //image(kinect.userImage(), 0, 0);


  // draw the skeleton if it's available
  int[] userList = kinect.getUsers();
  for (int i=0;i<userList.length;i++)
  {
    if (kinect.isTrackingSkeleton(userList[i]))
    {
      stroke(255, 0, 0);
      fill(0, 255, 255);
      drawJoints(userList[i]);
    }
  }
}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curkinect, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");

  curkinect.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curkinect, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curkinect, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}

