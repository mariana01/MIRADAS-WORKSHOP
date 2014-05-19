/**
 * Chartreuse de Valbonne, may 2014
 * Reconciliation
 * WORKSHOP MIRADAS by mariana carranza.   
 */
import processing.video.*;

Movie myMovie;

// __________________________________________
void setup() {
  size(1080, 800, P2D);  //(800, 600, P2D);
  
  // Load and play the video in a loop
  myMovie = new Movie(this, "reconsiliation-flip.mp4");
  myMovie.loop();
  imageMode(CENTER);
}

void movieEvent(Movie myMovie) {
  myMovie.read();
}

void draw() {
  background(0);
  //scale(-1);
  image(myMovie, width/2,height/2);
  println(frameRate);
}

