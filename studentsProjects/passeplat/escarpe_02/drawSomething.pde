//------------------------------------------
void drawSomething() {

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


//------------------------------------------
void testTrigger(int xx, int yy) {


  if (xx < buttonX_2 && xx > buttonX_1) {

    if (yy < buttonY_2 && yy > buttonY_1) {

      if (allowjump) {

        myMovie.jump(jumpCod);
        que ++;
        count = 0;
        allowjump = false;
        transp = 255;
      }
    }
  }
}

