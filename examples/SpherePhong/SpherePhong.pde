import java.nio.*;

PGL pgl;
PShader sh;

PShape sphere;


void setup() {
  size(800, 600, P3D);

  sh = loadShader("frag.glsl", "vert.glsl");
  sphere = createShape(SPHERE, 5);
  sphere.setStroke(0);
}


void draw() {

  background(0);

  shader(sh);
  camera(width/2.0, height/2.0, 50.0, width/2.0, height/2.0, 0.0, 0.0, 1.0, 0.0);

  perspective(radians(60.0), width/height, 1.0, 100.0);

  translate(width/2, height/2); 


  //similar to lookat

  //pointLight(255, 0, 0, 0, height/2, 0);

  sh.set("lightPosition", new PVector(-width/15.0, 0.0, 0.0));
  //sh.set("color", new PVector(1.0,0.0,0.0));
  sh.set("diffuseLightColor", new PVector(0.0, 0.0, 1.0));
  sh.set("ambientLightColor", new PVector(0.1, 0.1, 0.1));

  shape(sphere);
}

