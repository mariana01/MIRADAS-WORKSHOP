
float vol;
float area;
float maxAr;
float pan;
float volume;
//------------------------------------------
void initSound() {

  minim = new Minim(this);

  // load a file, give the AudioPlayer buffers that are 1024 samples long
  // player = minim.loadFile("groove.mp3");

  // load a file, give the AudioPlayer buffers that are 2048 samples long
  player = minim.loadFile("CONTRAST3.mp3", 2048);
  // play the file
  // player.play();
  player.loop();
  player.setGain(-20);
  maxAr = 2000; //width * height;
}
//------------------------------------------
void updateSound() {
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

