import processing.opengl.*;
import javax.media.opengl.*; 
import javax.media.opengl.GL2;
import stereo.*;
      
Stereo stereo = null;
float[] Theparams = new float[3];
Quad[] quads;

void setup() {
       
  //size(displayWidth, displayHeight, OPENGL);
        size(640*2, 480, OPENGL);
        frame.setResizable(true);
        quads = new Quad[20];
        for(int i = 0; i<20; i++) {
          quads[i] = new Quad(.01, i);
        }
        
        Theparams[0] = 0.85; // simetry
        Theparams[1] = 0.4; // radia distortion
        Theparams[2] = 1.0; // Y scale factor
        
        background(0);
        float convPlane = 10.0f;
        float eyeSep = (float) (convPlane / 30f); 
        frameRate(60);
        
        // set last parameter according to type of stereo
        // ACTIVE, PASSIVE, ANAGLYPH_REDLEFT_CYANRIGHT, ANAGLYPH_CYANLEFT_REDRIGHT etc.
        
        /* first constructor, custom eye separation, default convergence */
        // stereo = new Stereo(this, eyeSep, 45f, .1f, 1000f, Stereo.StereoType.PASSIVE);
        
        /* second constructor, custom eye separation, custom convergence */
        stereo = new Stereo(this, eyeSep, 45f, .1f, 1000f, Stereo.StereoType.PASSIVE, convPlane);
        
        /* third constructor, default eye separation, custom convergence */
        //stereo = new Stereo(this, 45f, .1f, 1000f, Stereo.StereoType.PASSIVE,convPlane);
        
        /* fourth constructor, default eye separation, default convergence */
        //  stereo = new Stereo(this, 45f, .1f, 1000f, Stereo.StereoType.PASSIVE);
        
      }
      
      float cx = 0f; float cy = 0f; float cz = 10f;
      
      void draw() {
        background(0,0,0,255);
        
          //PGraphicsOpenGL pgl = (PGraphicsOpenGL) g;
        //GL2  gl = pgl.beginPGL().gl.getGL2();
        PGL pgl = beginPGL();
        GL2 gl = ((PJOGL)pgl).gl.getGL2();
        {   
          // only needs to be called repeatedly if you are
          // changing camera position   
          stereo.start(gl, 
            cx, cy, cz,
            0f, 0f, -1f,
            0f, 1f, 0f);
      
          stereo.right(gl); // right eye rendering
          render(gl);
      
          stereo.left(gl);  // left eye rendering
          render(gl);
      
          // only needed for anaglyph
          stereo.end(gl);
        }
        endPGL();//pgl.endPGL();
      }
      
      void render(GL2 gl)
      {
        gl.glColor4f(1f,0f,1f,1f);
        
        for(int i = 0; i<20; i++) {
          quads[i].display(gl,Theparams);
        } 
      }
      
      public void keyPressed()
      {
         if (key == 'a')
         {
           cz += .1f;
         }
        
         if (key == 'z')
         {
           cz -= .1f;
         }
            if (key == 's')
         {
           Theparams[0] += .01f;
         }
        
         if (key == 'x')
         {
           Theparams[0] -= .01f;
         }
      
         if (key == 'd')
         {
           Theparams[1] += .01f;
         }
        
         if (key == 'c')
         {
           Theparams[1] -= .01f;
         }   
            if (key == 'f')
         {
           Theparams[2] += .01f;
         }
        
         if (key == 'v')
         {
           Theparams[2] -= .01f;
         }
         if(keyCode == LEFT) stereo.eyeSeperation -= .01;
         if(keyCode == RIGHT) stereo.eyeSeperation += .01;
      }
