//------------------------------------------
void updateTracking()
{
  // capture input
  opencv.copy(video);
  opencv.read();
  //opencv.flip( OpenCV.FLIP_HORIZONTAL );
  imgLiveColor = opencv.image();

  // convert to grayscale
  opencv.convert(OpenCV.GRAY);
  imgLiveGray = opencv.image();

  // capture background if needed
  if ( bCaptureBackground )
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

