

class Distance {
  float volume = 1;
  float taille = 1;
  float area;
  float maxAr = 20000; //60000;
  float pan;

  Distance() {

   
    player1.loop();
    player1.setGain(-40);
  }
  void run() {
    update();
    display();
  }

  void update() {
    area = 0;
    if (blobs.length > 0) {
      //Point centroid = blobs[0].centroid;

      // add the area of all the blobs
      for ( int i=0; i<blobs.length; i++ ) {
        area += blobs[i].area;
      }
      // println(area);

      volume = map(area, 0, maxAr, -50.0, 8.0);
      taille = map(area, 0, maxAr*3, 1.0, 0.2);
      player1.setGain(volume);
    }
  }

  void display() {
    noStroke();
    fill(0, 30);
    rect(0, 0, width, height);
    scale(taille);
    //image(bar, width/2, height/2);  //0,0);
    image(myMovie[currentMovie], width/2, height/2);
  }
}

