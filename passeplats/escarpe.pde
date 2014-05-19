

class Escarpe {
  int que;
  int buttonX_1, buttonX_2;
  int buttonY_1, buttonY_2;

  float jumpCod;
  boolean allowjump;
  int count;
  int transp;
  float transl;   //(width/scl-h)/2;


  Escarpe() {

    buttonY_1 = h/2 - 40;
    buttonY_2 = h/2 + 40;

    buttonX_1 = 0;
    buttonX_2 = 80;

    transl = (width/scl-h)/2;
  }

  void run() {
    update();
    display();
  }

  void update() {
    for ( int i=0; i<blobs.length; i++ )
    {

      Point centroid = blobs[i].centroid;

      if (que>8) {
        que = 0;
      }

      //14, 49, 145, 169, 206, 239, 325
      switch(que) {

      case 0:
        jumpCod = 13;
        break;

      case 1:
        jumpCod = 28;
        break; 

      case 2:
        jumpCod = 60;
        break;

      case 3:
        jumpCod = 109;
        break;

      case 4:
        jumpCod = 129;
        break;

      case 5:
        jumpCod = 161;
        break;

      case 6:
        jumpCod = 173;
        break;

      case 7:
        jumpCod = 220;
        break;

      case 8:
        jumpCod = 5;
        break;
      }

      testTrigger(centroid.x, centroid.y);
    }

    count ++;
    if (count > 90) { 
      allowjump = true;
    }
  }

  void display() {
    noStroke();
    fill(0);
    rect(0, 0, width, height);

    image(myMovie[currentMovie], width/2, height/2);
    
    noFill();
    strokeWeight(2);
    stroke(255, transp);
    //rect(buttonX_1, buttonY_1, buttonX_2 - buttonX_1, buttonY_2 - buttonY_1);
    rect((width/2)-80, height-170, 160, 160);
    //popMatrix();
    transp -=3;
    transp = constrain(transp, 30, 255);
  }


  //------------------------------------------
  void testTrigger(int xx, int yy) {


    if (xx < buttonX_2 && xx > buttonX_1) {

      if (yy < buttonY_2 && yy > buttonY_1) {

        if (allowjump) {

          myMovie[currentMovie].jump(jumpCod);
          que ++;
          count = 0;
          allowjump = false;
          transp = 255;
        }
      }
    }
  }
}

