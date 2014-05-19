
//------------------------------------------
void drawSomething() {

  for ( int i=0; i<blobs.length; i++ )
  {

    Rectangle bounding_rect = blobs[i].rectangle;
    Point centroid = blobs[i].centroid;
    Point[] points = blobs[i].points;

    /*
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
     vertex( points[j].x, points[j].y );
     }
     endShape(CLOSE);
     */

    // draw something with the blob data
    noFill();
    strokeWeight(.1);
    stroke(0, 0, 255);
    for ( int j=0; j<blobs[i].points.length; j+=7 ) {
      line( points[j].x, points[j].y, centroid.x-1, centroid.y);
    }
    fill(0, 255, 255, 20);
    noStroke();
    ellipse( centroid.x-1, centroid.y-1, bounding_rect.width/4, bounding_rect.height/4);
  }
}

