import java.nio.*;
import stereo.*;
import processing.opengl.*;
import javax.media.opengl.*;
import javax.media.opengl.GL2;


PGL pgl;
PShader sh;

PShape sphere;
Stereo stereo = null;

float[] Theparams = new float[3];

void setup() {
  size(800, 600, P3D);

  Theparams[0] = 0.85; // simetry
  Theparams[1] = 0.4; // radia distortion
  Theparams[2] = 1.0; // Y scale factor

  float convPlane =10.0f;
  float eyeSep = (float) (convPlane / 30f); 
  
  /* second constructor, custom eye separation, custom convergence */
  stereo = new Stereo(
    this, eyeSep, 45f, 
    .1f, 1000f, Stereo.StereoType.ANAGLYPH_REDLEFT_CYANRIGHT, 
    convPlane);
  
  sh = loadShader("frag.glsl", "vert.glsl");
  sphere = createShape(SPHERE, 100);
  sphere.setStroke(0);
}

float cx = 0f; float cy = 0f; float cz = 10f;

void draw() {

  background(0);

  shader(sh);
  //camera(width/2.0, height/2.0, 50.0, width/2.0, height/2.0, 0.0, 0.0, 1.0, 0.0);

  //perspective(radians(60.0), width/height, 1.0, 100.0);

  translate(width/2, height/2); 


  //similar to lookat

  //pointLight(255, 0, 0, 0, height/2, 0);

  sh.set("lightPosition", new PVector(-width/2.0, 0.0, 0.0));
  //sh.set("color", new PVector(1.0,0.0,0.0));
  sh.set("diffuseLightColor", new PVector(0.0, 0.0, 1.0));
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
    shape(sphere);

    stereo.setLeftEyeView(pgl);  // left eye rendering
    shape(sphere);

    // only needed for anaglyph
    stereo.end(gl);
    
  }
  endPGL();
}











