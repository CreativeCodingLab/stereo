/* ActiveStereoTest.pde
** 
** DO NOT RUN THIS IF YOU DO NOT HAVE A STEREO CARD!!!
** IT MAY CRASH YOUR SYSTEM!!!
**
** Test for Stereo library for Processing by
** Angus Forbes and Charlie Roberts. Displays
** quads moving along z axis in stereo. Experiment
** with eye separation using right and left arrow
** keys.
**
** created 4/23/2010
*/

import processing.opengl.*;
import javax.media.opengl.*; 
import stereo.*;
Stereo stereo = null;

Quad[] quads;
void setup() 
{
  size(640, 480, "stereo.ActiveStereoView");
  frame.setResizable(true);
  quads = new Quad[20];
  for(int i = 0; i<20; i++) {
    quads[i] = new Quad(.01, i);
  }
  background(0);
  float eyeSep = (float) (999.999 / 30f); //?????
  eyeSep = .1f;
  frameRate(60);
  
  // set last parameter according to type of stereo
  // ACTIVE, PASSIVE, ANAGLYPH_REDLEFT_CYANRIGHT, ANAGLYPH_CYANLEFT_REDRIGHT etc.
  stereo = new Stereo(this, eyeSep, 45f, .1f, 1000f, Stereo.StereoType.ACTIVE);
}

//these are test variables....
float cx = 0f; float cy = 0f; float cz = 10f;

void draw() 
{
  background(0,0,0,255);
  
  ActiveStereoView pgl = (ActiveStereoView) g;

  GL gl = pgl.beginGL();  
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
  pgl.endGL();
}

void render(GL gl)
{
  gl.glColor4f(1f,0f,1f,1f);
  
  gl.glTranslatef(0f,0f,-10f);
  for(int i = 0; i<20; i++) {
    quads[i].display(gl);
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
   
   if(keyCode == LEFT) stereo.eyeSeperation -= .01;
   if(keyCode == RIGHT) stereo.eyeSeperation += .01;
}
