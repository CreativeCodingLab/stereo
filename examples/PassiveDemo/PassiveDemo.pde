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
  sphere = createShape(SPHERE, 2);
  sphere.setStroke(0);
  angle = 0;
  
  for(int i=0;i<N;i++){
    spheres[i] = createShape(SPHERE, 1);
    spheres[i].setStroke(0);
  }
}

float cx = 0f; float cy = 0f; float cz = 10f;

void draw() {

  angle += 0.05;
  background(0,0,0,255);

  shader(sh);

  sh.set("lightPosition", new PVector(10.0, 0.0, 0.0));
  sh.set("diffuseLightColor", new PVector(0.8, 0.0, 0.0));
  sh.set("ambientLightColor", new PVector(0.1, 0.1, 0.1));

  PGL pgl = beginPGL();
  GL2 gl = ((PJOGL)pgl).gl.getGL2(); {
    // only needs to be called repeatedly if you are
    // changing camera position   
    stereo.start(gl, 
        cx, cy, cz,
        0f, 0f, -1f,
        0f, 1f, 0f);
     
    // right eye rendering 
    stereo.setRightEyeView(pgl);    
    for(int i=0; i<N;i++){
      pushMatrix();
      translate(-N+i+2.0,sin(angle+2*i),-10+1.5*i);
      shape(spheres[i]);
      popMatrix();
    }    
    
    
    // left eye rendering 
    stereo.setLeftEyeView(pgl);    
    for(int i=0; i<N;i++){
      pushMatrix();
      translate(-N+i+2.0,sin(angle+2*i),-10+1.5*i);
      shape(spheres[i]);
      popMatrix();
    }  
    
    
    /*
    stereo.setRightEyeView(pgl); // right eye rendering
    translate(0.0,0.0, -10+10*sin(angle));
    //sh.set("right",1);
    shape(sphere);

    stereo.setLeftEyeView(pgl);  // left eye rendering
    //sh.set("right",0);
    translate(0.0,0.0, -10+10*sin(angle));
    shape(sphere);*/

    // only needed for anaglyph
    //stereo.end(gl);
    
  }
  endPGL();
}


public void keyPressed()
  {
    if(keyCode == LEFT) stereo.eyeSeperation -= .01;
    if(keyCode == RIGHT) stereo.eyeSeperation += .01;
  }















