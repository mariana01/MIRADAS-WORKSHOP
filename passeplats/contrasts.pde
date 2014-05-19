

class Contrasts {

  int c_x, c_y;
  int ftrans = 255;  //font transparency

  float vol;
  float area;
  float maxAr;
  float pan;
  float volume;

  Contrasts() {

    player.loop();
    player.setGain(-20);
    maxAr = 2000; //width * height;
    
  }
  
  void run() {
    update();
    display();
  }

  void update() {
    area = 0;
    if (blobs.length > 0) {
      Point centroid = blobs[0].centroid;

      // add the area of all the blobs
      for ( int i=0; i<blobs.length; i++ ) {
        area += blobs[i].area;
      }
      println(area);

      vol = map(area, 0, maxAr, -40.0, 14.0);
      player.setGain(vol);

      /*pan = map(centroid.x, 0, width, -1, 1);
       
       player.setPan(pan);*/

      c_x = centroid.x;
      c_y = centroid.y;
    }
  }

  void display() {
    //background(0);
    noStroke();
    fill(0, 50);
    rect(0, 0, width, height);

    // circle????
    fill(255);
    scale (scl);
    rotate(-PI/2);
    translate (-w, transl);
    ellipse(c_x, c_y, 10, 10);

    if (ftrans>0) {
      stroke(255);
      noFill();
      textFont(font, 48);
      text("Contrasts", 10, h-15);
      ftrans -= 5;
    }

    /*
    //test position
     noFill();
     stroke(255);
     rect(0, 0, w, h);
     stroke(255, 0, 0);
     line(0, 0, w, 0);
     */
  }
}

