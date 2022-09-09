// 1 lo necesario
// librería 

import AULib.*;
import peasy.*;
PeasyCam cam;
double angleY = 0.0; 
int startFrame = 0; 
int endFrame = 1200; 
boolean render = true;


// 2 setup
PVector camDirection, camPosition, camTarget;

void setup() {
  size(displayWidth, displayHeight, P3D);
  // creo la cámara
  cam = new PeasyCam(this, 0, 0, 0, 55);
  smooth(8);
  cam.setActive(false);
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
  
  //linear number
  float linear = norm(endFrame-frameCount%endFrame, startFrame, endFrame);
  float cubic = AULib.ease(AULib.EASE_IN_CUBIC, linear);
  //calcula un numero entre 2 a un incremento especíifico
  // se utiliza para establecer movimiento en función de un camino
  float cDist = lerp(1, 8000, cubic);
  
  
  //color bordes
  stroke(128,95,203);
  // borde del cubo
  strokeWeight(3);
  
  // rotar o no el cubo antes de dibujar
  //rotateX(-PI/6);
  //rotateY(PI/3);
  box(180);
  
  //rotar camara por 0.01 radians p frame
  cam.rotateY(0.01);
  float yPan = 0.01; //sin((frameCount/100.0)%500);
  //animación incremental de la posición original a la posisión target
  // cDist es una dsitancia calculada en base a los frames que vamos recorriendo y 0 sería un tiempo de animación en Ms
  cam.lookAt(0, 0, 0, cDist, 0);
  // mueve el punto de vista LookAt relativo a la orientación actual  (dx,dy)
  cam.pan(0, yPan); 
  
  
}
