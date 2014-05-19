/**
 * talleres CCE mariana carranza
 * Example 10: Finger cursor
 * el punto mas alto del blob dibuja lineas en un nuevo lay (la capa de efectos)
 * basado en OpenCV_BlobsMovie de C.Sugrue y J. Cano TPC MedialabPrado
 * by mariana carranza.   
 */

import hypermedia.video.*;
import java.awt.*;// en Mac

OpenCV openCV;
int     threshold = 80;

PGraphics layer_0;
Point fingerCursor;
Point lastFingerCursor;

//-----------------------------------------------------------------------------
void setup() {

  size (960, 240); 

  openCV = new OpenCV (this);
  openCV.capture (320, 240);

  // Crea la capa de efectos
  layer_0 = createGraphics(320, 240, JAVA2D);

  fingerCursor = new Point (0, 0);
  lastFingerCursor = new Point (0, 0);
}

//-----------------------------------------------------------------------------
void draw() {

  // guarda el punto anterior
  lastFingerCursor = fingerCursor;

  openCV.read();
  image (openCV.image(), 0, 0);
  noStroke();
  fill (255, 80);
  rect (0, 0, 320, 240);

  // Convierte la imagen a blanco y negro
  openCV.convert(OpenCV.GRAY);
  image (openCV.image(), 320, 0);

  // Calcula la diferencia entre el fondo y la imagen actual
  openCV.absDiff();

  // Aplica threshold a la imagen
  openCV.threshold(threshold);
  image (openCV.image(), 640, 0);

  // Procesado de blobs
  int     minArea   = 100;//área mínima de blob a computar
  int     maxArea   = 320 * 240;//área máxima de blob a computar
  int     maxBlobs  = 1;//cantidad de blobs que queremos (usamos 1 para trabajar)
  boolean findHoles = false;//si computamos los blobs dentro de los blobs o no
  Blob[] blobs = openCV.blobs( minArea, maxArea, maxBlobs, findHoles );

  if (blobs.length > 0) {
    //accedemos a los blobs
    for (int i = 0; i < blobs.length; i++) {

      // Dibuja el bounding box en amarillo
      noFill();
      stroke (255, 255, 0);
      Rectangle bBox = blobs[i].rectangle; 
      rect ( bBox.x, bBox.y, bBox.width, bBox.height);


      // Almacena los puntos del contorno
      Point[] points = blobs[0].points;

      // Dibuja el contorno en verde 
      stroke(0, 255, 0);
      beginShape();

      // Recorre el contorno buscando el punto más alto o con menor coordenada y ...
      Point highPoint = new Point(0, 99999);
      for ( int j=0; j<points.length; j++ ) {

        if (highPoint.y > points[j].y) {
          highPoint = points[j];
        }
        // ... dibuja el blob
        vertex( points[j].x, points[j].y );
      }
      endShape(CLOSE);


      stroke (255, 0, 255);
      fill (200, 0, 200);
      rect (highPoint.x, highPoint.y, 10, 10);

      //actualiza el punto más alto para dibujar
      fingerCursor = highPoint;
    }
  }

  // layer_0 objeto de la clase PGraphics
  stroke (0);
  layer_0.beginDraw();
  layer_0.line(lastFingerCursor.x, lastFingerCursor.y, fingerCursor.x, fingerCursor.y);
  layer_0.endDraw();
  image (layer_0, 0, 0);
}
//-----------------------------------------------------------------------------
// Control de teclado
void keyPressed()
{
  // Captura el fondo
  if (key == ' ')  openCV.remember();  
  // Cambia el thresold
  if (key == '+')  threshold ++;
  if (key == '-')  threshold --;
}
//-----------------------------------------------------------------------------
// Clean resources
void stop() {
  openCV.stop();
  super.stop();
}

