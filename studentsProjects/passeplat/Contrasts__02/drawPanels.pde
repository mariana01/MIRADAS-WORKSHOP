
//------------------------------------------
void drawCVPanel()
{

  // dibija las pantallas
  image( imgLiveColor, 0, 0 );
  image( imgLiveGray, 10+w, 0 );
  image( imgBgCapture, 0, 10+h );
  image( imgBinary, 10+w, 10+h );

  // dibuja los blobs
  noFill();

  for ( int i=0; i<blobs.length; i++ )
  {

    Rectangle bounding_rect = blobs[i].rectangle;
    Point centroid = blobs[i].centroid;
    Point[] points = blobs[i].points;

    // rectangle
    strokeWeight(1);
    noFill();
    stroke(255, 0, 0 );
    rect( bounding_rect.x, bounding_rect.y, bounding_rect.width, bounding_rect.height );

    // centroid
    fill(255, 0, 0);
    ellipse( centroid.x-1, centroid.y-1, 2, 2);
    stroke(0, 255, 255);
    noFill();
    ellipse( centroid.x-1, centroid.y-1, 10, 10);

    // blob
    strokeWeight(3);
    noFill();
    beginShape();
    for ( int j=0; j<blobs[i].points.length; j++ ) {
      vertex( blobs[i].points[j].x, blobs[i].points[j].y );
    }
    endShape(CLOSE);
  }



  fill(255, 255, 255);
  text("Threshold:   " + threshold + "   |    SPACE: bg capture   |    drag mouse to change threshold", 10, height-15);
}

