import java.nio.*;
import stereo.*;
import processing.opengl.*;
import javax.media.opengl.*;
import javax.media.opengl.GL2;


PGL pgl;
PShader sh;
float angle;

PShape sphere;
Stereo stereo = null;

PShape[] spheres;
final int N = 8;

void setup() {
  
  size(800, 600, P3D);
  
  
  float convPlane =20.0f;
  float eyeSep = (float) (convPlane / 30f); 
  
  frameRate(60);
  
  spheres = new PShape[N];
  /* second constructor, custom eye separation, custom convergence */
  stereo = new Stereo(
    this, eyeSep, 45f, 
    .1f, 1000f, Stereo.StereoType.PASSIVE, 
    convPlane);
  
  sh = loadShader("frag.glsl", "vert.glsl");
  sphere = createShape(SPHERE, 0.5);
  sphere.setStroke(0);
  angle = 0;
  
  for(int i=0;i<N;i++){
    spheres[i] = createShape(SPHERE, 1);
    spheres[i].setStroke(0);
  }
}

float cx = 0f; float cy = 0f; float cz = 10f;

void draw() {

  angle += 0.03;
  background(0,0,0,255);

  shader(sh);

  sh.set("lightPosition", new PVector(10.0, -10.0, 10.0));
  sh.set("diffuseLightColor", new PVector(0.0, 0.8, 0.0));
  sh.set("ambientLightColor", new PVector(0.1, 0.1, 0.1));

  PGL pgl = beginPGL();
  GL2 gl = ((PJOGL)pgl).gl.getGL2(); {
    // only needs to be called repeatedly if you are
    // changing camera position   
    stereo.start(gl, 
        cx, cy, cz,
        0f, 0f, -1f,
        0f, 1f, 0f);
     

    stereo.setRightEyeView(pgl); // right eye rendering
    
    //First sphere
    pushMatrix();
    rotateY(angle);
    translate(1.0,0.0, 0.0);
    shape(sphere);
    popMatrix();
    
    
    //Second Sphere
    sh.set("diffuseLightColor", new PVector(0.0, 0.0, 0.8));
    pushMatrix();
    rotate(angle, -1.0,1.0,0.0);
    translate(2.0,2.0, 0.0);
    shape(sphere);
    popMatrix();
    
    //Third Sphere
    //Setting color
    //Picton Blue: 89, 171, 227
    sh.set("diffuseLightColor", new PVector(89.0f/255.0f, 171.0f/255.0f, 227.0f/255.0f));
    
    //Setting position
    pushMatrix();
    rotate(angle, 1.0,1.0,0.0);
    translate(-2.5,2.5, 0.0);
    shape(sphere);
    popMatrix();

    
    
    stereo.setLeftEyeView(pgl);  // left eye rendering
    
    //First sphere
    sh.set("diffuseLightColor", new PVector(0.0, 0.8, 0.0));
    
    pushMatrix();
    rotateY(angle);
    translate(1.0,0.0, 0.0);
    shape(sphere);
    popMatrix();
    
    //Second Sphere
    sh.set("diffuseLightColor", new PVector(0.0, 0.0, 0.8));
    pushMatrix();
    rotate(angle, -1.0,1.0,0.0);
    translate(2.0,2.0, 0.0);
    shape(sphere);
    popMatrix();
    
    //Third Sphere
    //Setting color
    sh.set("diffuseLightColor", new PVector(0.8, 0.0, 0.0));
    
    //Setting position
    pushMatrix();
    rotate(angle, 1.0,1.0,0.0);
    translate(-2.5,2.5, 0.0);
    shape(sphere);
    popMatrix();
   
    
  }
  endPGL();
}















