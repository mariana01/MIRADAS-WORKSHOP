// draw the selected joints
void drawJoints(int userId)
{
  // to get the 3d joint data
  PVector joint3D = new PVector();

  // to get the 3d joint data
  // store the joint data in my PVector
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, joint3D);
  // and draw something
  pushMatrix();
  translate(joint3D.x, joint3D.y, joint3D.z);
  sphere(40);
  popMatrix();

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, joint3D);
  pushMatrix();
  translate(joint3D.x, joint3D.y, joint3D.z);
  sphere(80);
  popMatrix();

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, joint3D);
  pushMatrix();
  translate(joint3D.x, joint3D.y, joint3D.z);
  sphere(80);
  popMatrix();

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, joint3D);
  pushMatrix();
  translate(joint3D.x, joint3D.y, joint3D.z);
  sphere(80);
  popMatrix();

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, joint3D); 
  pushMatrix();
  translate(joint3D.x, joint3D.y, joint3D.z);
  sphere(80);
  popMatrix();
}

/* all the joints:
 * SKEL_HEAD
 * SKEL_LEFT_ELBOW
 * SKEL_LEFT_FINGERTIP
 * SKEL_LEFT_FOOT
 * SKEL_LEFT_HAND
 * SKEL_LEFT_HIP
 * SKEL_LEFT_KNEE
 * SKEL_LEFT_SHOULDER
 * SKEL_NECK
 * SKEL_RIGHT_ELBOW
 * SKEL_RIGHT_FINGERTIP
 * SKEL_RIGHT_FOOT
 * SKEL_RIGHT_HAND
 * SKEL_RIGHT_HIP
 * SKEL_RIGHT_KNEE
 * SKEL_RIGHT_SHOULDER
 * SKEL_TORSO
 */
