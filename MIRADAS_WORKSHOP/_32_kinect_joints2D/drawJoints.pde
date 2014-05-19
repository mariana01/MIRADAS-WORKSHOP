// draw the selected joints
void drawJoints(int userId)
{
  // to get the 3d joint data
  PVector joint3D = new PVector();
  // to get the 2d joint data
  PVector joint2D = new PVector();

  // to get the 3d joint data
  // store the joint data in my PVector
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, joint3D);
  // to get the 2d joint data
  // transform the 3D coordinates to 2D and sore in joint2D
  kinect.convertRealWorldToProjective(joint3D, joint2D);
  // and draw something
  ellipse(joint2D.x, joint2D.y, 40, 40);

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, joint3D);
  kinect.convertRealWorldToProjective(joint3D, joint2D);
  ellipse(joint2D.x, joint2D.y, 40, 40);

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, joint3D);
  kinect.convertRealWorldToProjective(joint3D, joint2D);
  ellipse(joint2D.x, joint2D.y, 40, 40);

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, joint3D);
  kinect.convertRealWorldToProjective(joint3D, joint2D);
  ellipse(joint2D.x, joint2D.y, 40, 40);

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_KNEE, joint3D);
  kinect.convertRealWorldToProjective(joint3D, joint2D);
  ellipse(joint2D.x, joint2D.y, 40, 40);

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, joint3D);
  kinect.convertRealWorldToProjective(joint3D, joint2D);
  ellipse(joint2D.x, joint2D.y, 40, 40);

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, joint3D);
  kinect.convertRealWorldToProjective(joint3D, joint2D);
  ellipse(joint2D.x, joint2D.y, 40, 40);

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, joint3D);
  kinect.convertRealWorldToProjective(joint3D, joint2D);
  ellipse(joint2D.x, joint2D.y, 40, 40);

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, joint3D);
  kinect.convertRealWorldToProjective(joint3D, joint2D);
  ellipse(joint2D.x, joint2D.y, 40, 40);

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, joint3D); 
  kinect.convertRealWorldToProjective(joint3D, joint2D);
  ellipse(joint2D.x, joint2D.y, 40, 40);

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, joint3D);
  kinect.convertRealWorldToProjective(joint3D, joint2D);
  ellipse(joint2D.x, joint2D.y, 40, 40);

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, joint3D);
  kinect.convertRealWorldToProjective(joint3D, joint2D);
  ellipse(joint2D.x, joint2D.y, 40, 40);
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
