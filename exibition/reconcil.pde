

class Recon {


  Recon() {
  }
  void run() {
    update();
    display();
  }

  void update() {
  }

  void display() {
    noStroke();
    fill(0);
    rect(0, 0, width, height);
    image(myMovie[currentMovie], width/2, height/2);
  }
}

