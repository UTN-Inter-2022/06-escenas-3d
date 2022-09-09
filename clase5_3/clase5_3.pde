// 1 lo necesario
// librería 

import AULib.*;
import peasy.*;
PeasyCam cam;
double angleY = 0.0; 
int startPos = 0; 
int endPos = 1200; 
boolean render = true;



// 2 setup
float[] getCamRotation, getCamPosition, getCamTarget;
PVector camDirection, camPosition, camTarget;
float camTranslateX, camTranslateY, camTranslateZ, camTranslateXLerp, camTranslateYLerp, camTranslateZLerp;
float camRotateX, camRotateY, camRotateZ, camRotateXLerp, camRotateYLerp, camRotateZLerp;
float lerpSpeed = 0.1;
float tranSen = 1;
float rotSen = 1;

void setup() {
  size(displayWidth, displayHeight, P3D);
  // creo la cámara
  cam = new PeasyCam(this, 0, 0, 0, 55);
 camDirection = new PVector();
  camPosition = new PVector();
  camTarget = new PVector();
  //Ajustar el "field of view" (FOV) // ver de cambiar los parámetros
  //fovy  (float)  field-of-view angle (in radians) for vertical direction 
  //aspect  (float)  ratio of width to height
  //zNear  (float)  z-position of nearest clipping plane
  //zFar  (float)  z-position of farthest clipping plane 
  //
  //
  
  
  
  
  perspective(PI/3.0, width/height, 1, 100000);
}

void draw() {
  background(0);
  
  //tomo los datos de posición de la cámara
  getCamPosition = cam.getLookAt();
  camPosition.x = getCamPosition[0];
  camPosition.y = getCamPosition[1];
  camPosition.z = getCamPosition[2];
  getCamTarget = cam.getPosition();
  camTarget.x = getCamTarget[0];
  camTarget.y = getCamTarget[1];
  camTarget.z = getCamTarget[2];
  
  // update translation and rotate values with certain keys
  if (keyPressed) {
    if (key == 'w') camTranslateZ += 1 * tranSen;
    if (key == 's') camTranslateZ -= 1 * tranSen;
    if (key == 'd') camTranslateX += 1 * tranSen;
    if (key == 'a') camTranslateX -= 1 * tranSen;
    if (key == 'q') camTranslateY += 1 * tranSen;
    if (key == 'e') camTranslateY -= 1 * tranSen;
    if (keyCode == UP) camRotateX = -1 * rotSen;
    if (keyCode == DOWN) camRotateX = 1 * rotSen;
    if (keyCode == RIGHT) camRotateY = -1 * rotSen;
    if (keyCode == LEFT) camRotateY = 1 * rotSen;
    if (key == 'z') camRotateZ = -1 * rotSen;
    if (key == 'x') camRotateZ = 1 * rotSen;
  }
  
  
  
  //color bordes
  stroke(128,95,203);
  // borde del cubo
  strokeWeight(3);
  
  // rotar o no el cubo antes de dibujar
  //rotateX(-PI/6);
  //rotateY(PI/3);
  box(180);
  
  // interpolate values for smoother easing motion
  camTranslateXLerp = lerp(camTranslateXLerp, camTranslateX, lerpSpeed);
  camTranslateYLerp = lerp(camTranslateYLerp, camTranslateY, lerpSpeed);
  camTranslateZLerp = lerp(camTranslateZLerp, camTranslateZ, lerpSpeed);
  camRotateXLerp = lerp(camRotateXLerp, camRotateX, lerpSpeed);
  camRotateYLerp = lerp(camRotateYLerp, camRotateY, lerpSpeed);
  camRotateZLerp = lerp(camRotateZLerp, camRotateZ, lerpSpeed);

  // set camera position
  camDirection = PVector.sub(camPosition, camTarget);
  camDirection.normalize();
  camDirection.mult((camTranslateZLerp));
  camPosition.add(camDirection);
  cam.lookAt(camPosition.x, camPosition.y, camPosition.z, 0);
  cam.pan(camTranslateXLerp, camTranslateYLerp);

  // set camera rotations
  cam.rotateX(radians(camRotateXLerp));
  cam.rotateY(radians(camRotateYLerp));
  cam.rotateZ(radians(camRotateZLerp));
  
  
}


// para evitar acumulaciones
void keyReleased() {
  if (key == 'w') camTranslateZ = 0;
  if (key == 's') camTranslateZ = 0;
  if (key == 'd') camTranslateX = 0;
  if (key == 'a') camTranslateX = 0;
  if (key == 'q') camTranslateY = 0;
  if (key == 'e') camTranslateY = 0;
  if (keyCode == UP) camRotateX = 0;
  if (keyCode == DOWN) camRotateX = 0;
  if (keyCode == RIGHT) camRotateY = 0;
  if (keyCode == LEFT) camRotateY = 0;
  if (key == 'z') camRotateZ = 0;
  if (key == 'x') camRotateZ = 0;
}
