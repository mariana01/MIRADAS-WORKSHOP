
float vol;
float area;
float maxAr = 20000; //60000;
float pan;

//------------------------------------------
void updateSound() {
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
    player.setGain(volume);
  }
}

