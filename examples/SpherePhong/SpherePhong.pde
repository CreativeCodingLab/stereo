import java.nio.*;

PGL pgl;
PShader sh;

PShape sphere;


void setup() {
  size(640, 360, P3D);

  sh = loadShader("frag.glsl", "vert.glsl");
  sphere = createShape(SPHERE, 100);
  sphere.setStroke(0);
}


void draw() {

  background(0);

  shader(sh);
  
  translate(width/2, height/2); 
  shape(sphere);
}

