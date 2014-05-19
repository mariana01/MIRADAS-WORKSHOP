// El Punto ...

int xpos;


void setup(){
  size(500, 500);
  smooth();
}


void draw(){
  //background(0, 94, 252);
  fill(0, 94, 252, 10);
  noStroke();
  rect(0, 0, width, height);
  
  strokeWeight(8);
  stroke(255);
  
  point(xpos , height*.7);  
  line(xpos , height*.5, xpos, 0);
  ellipse(width*.5, height*.5, xpos*.5, xpos*.5);
  
  xpos = xpos + 1;
  if (xpos > width) {
    xpos = 0;
  }
}



