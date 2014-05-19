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

float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float        rotY = radians(0);

// -----------------------------------------------------------------
void setup()
{
  size(640, 480, P3D);
  smooth();

  kinect = new SimpleOpenNI(this);

  if (kinect.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  // enable mirror
  kinect.setMirror(true);

  // enable depthMap generation 
  kinect.enableDepth();

  // enable skeleton generation for all joints
  kinect.enableUser();

  sphereDetail(10);
}

// -----------------------------------------------------------------
void draw() {
  // update the cam
  kinect.update();

  background(0);
  lights();

  // set the scene pos
  translate(width/2, height/2, -200);
  rotateX(rotX);
  rotateY(rotY);

  int[]   depthMap = kinect.depthMap();
  int[]   userMap = kinect.userMap();
  int     steps   = 4;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;


  int nump = kinect.depthWidth()*kinect.depthHeight();
  // draw the pointcloud
  beginShape(POINTS);
  for (int y=0;y < kinect.depthHeight();y+=steps) {
    for (int x=0;x < kinect.depthWidth();x+=steps) {

      index = x + y * kinect.depthWidth();

      if (depthMap[index] > 0) { 

        // draw the projected point
        realWorldPoint = kinect.depthMapRealWorld()[index];
        stroke(255);      
        point(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
      }
    }
  } 
  endShape();


  // draw the skeleton if it's available
  int[] userList = kinect.getUsers();
  for (int i=0;i<userList.length;i++) {
    if (kinect.isTrackingSkeleton(userList[i])) {
      noStroke();
      fill(255, 0, 0);
      drawJoints(userList[i]);
    }
  }

  // Rotate
  //rotY += 0.015f;
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

