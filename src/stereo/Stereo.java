package stereo;

import com.sun.opengl.util.GLUT;
import javax.media.opengl.GL;
import javax.media.opengl.GLCapabilities;
import javax.media.opengl.glu.GLU;
import processing.core.PApplet;
import processing.core.PVector;

/**
 *
 * @author Angus Forbes & Charlie Roberts, based on code by Paul Bourke
 */
public class Stereo
{

  public enum StereoType
  {

    ACTIVE,
    PASSIVE,
    ANAGLYPH_REDLEFT_BLUERIGHT,
    ANAGLYPH_REDLEFT_CYANRIGHT,
    ANAGLYPH_CYANLEFT_REDRIGHT,
    ANAGLYPH_BLUELEFT_REDRIGHT
  }

  public StereoType stereoType = null;
  PApplet app = null;
  public float eyeSeperation;
  double aspectRatio, nearPlane, farPlane, widthdiv2, cameraFO;
  int w, h;
  GLCapabilities cap;
  GLU glu = null;
  GLUT glut = null;
  double fovy = 45;
  float posx, posy, posz;
  float dirx, diry, dirz;
  float upx, upy, upz;
  float rightx, righty, rightz;

  public Stereo(PApplet app, float eyeSeperation, float fovy, float nearPlane, float farPlane, StereoType stereoType)
  {
    this.app = app;
    this.glu = new GLU();
    this.glut = new GLUT();
    this.cap = new GLCapabilities();
    this.cap.setStereo(true);
    this.cap.setDoubleBuffered(true);
    this.nearPlane = nearPlane;
    this.farPlane = farPlane;
    this.fovy = fovy;
    this.eyeSeperation = eyeSeperation;
    this.stereoType = stereoType;

    // TODO: if stereoType == PASSIVE should we double the window size for the user or assume they will double it themselves?
  }

  public void end(GL gl)
  {
    gl.glColorMask(true, true, true, true);
  }

  public void start(GL gl,
    float posx, float posy, float posz,
    float dirx, float diry, float dirz,
    float upx, float upy, float upz)
  {
    this.w = app.getWidth();
    this.h = app.getHeight();

    this.aspectRatio = (double) w / (double) h;
    this.widthdiv2 = nearPlane * Math.tan(this.fovy / 2); // aperture in radians
    this.cameraFO = farPlane - nearPlane;

    this.posx = posx;
    this.posy = posy;
    this.posz = posz;

    this.dirx = dirx;
    this.diry = diry;
    this.dirz = dirz;

    this.upx = upx;
    this.upy = upy;
    this.upz = upz;

    PVector cdir = new PVector(this.dirx, this.diry, this.dirz);
    PVector cup = new PVector(this.upx, this.upy, this.upz);
    PVector cright = cdir.cross(cup);

    this.rightx = cright.x * eyeSeperation / 2.0f;
    this.righty = cright.y * eyeSeperation / 2.0f;
    this.rightz = cright.z * eyeSeperation / 2.0f;
  }

  public void left(GL gl)
  {

    switch (this.stereoType)
    {
      case ACTIVE:
        gl.glDrawBuffer(gl.GL_BACK_LEFT);
        gl.glClear(gl.GL_COLOR_BUFFER_BIT | gl.GL_DEPTH_BUFFER_BIT);
        break;
      case ANAGLYPH_REDLEFT_CYANRIGHT:
        gl.glColorMask(true, false, false, true);
        gl.glViewport(0, 0, this.w, this.h);
        break;
      case ANAGLYPH_CYANLEFT_REDRIGHT:
        gl.glColorMask(false, true, true, true);
        gl.glViewport(0, 0, this.w, this.h);
        break;
      case ANAGLYPH_REDLEFT_BLUERIGHT:
        gl.glColorMask(true, false, false, true);
        gl.glViewport(0, 0, this.w, this.h);
        break;
      case ANAGLYPH_BLUELEFT_REDRIGHT:
        gl.glColorMask(false, false, true, true);
        gl.glViewport(0, 0, this.w, this.h);
        break;
      case PASSIVE:
        gl.glViewport(0, 0, this.w / 2, this.h);
        break;
      default:
        gl.glViewport(0, 0, this.w, this.h);
    }

    // TODO: do we need to clear depth and color buffers here for active stereo?

    gl.glMatrixMode(gl.GL_PROJECTION);
    gl.glLoadIdentity();
    gl.glViewport(0, 0, this.w, this.h);
    double top = widthdiv2;
    double bottom = -widthdiv2;
    double left = -aspectRatio * widthdiv2 + 0.5 * eyeSeperation * nearPlane / cameraFO;
    double right = aspectRatio * widthdiv2 + 0.5 * eyeSeperation * nearPlane / cameraFO;
    gl.glFrustum(left, right, bottom, top, nearPlane, farPlane);

    gl.glMatrixMode(gl.GL_MODELVIEW);
    gl.glLoadIdentity();
    glu.gluLookAt(
      posx - rightx, posy - righty, posz - rightz,
      posx - rightx + dirx, posy - righty + diry, posz - rightz + dirz,
      upx, upy, upz);
  }

  public void right(GL gl)
  {

    switch (this.stereoType)
    {
      case ACTIVE:
        gl.glDrawBuffer(gl.GL_BACK_LEFT);
        gl.glClear(gl.GL_COLOR_BUFFER_BIT | gl.GL_DEPTH_BUFFER_BIT);
        break;
      case ANAGLYPH_REDLEFT_CYANRIGHT:
        gl.glColorMask(false, true, true, true);
    //    gl.glColorMask(true, false, false, true);
        gl.glViewport(0, 0, this.w, this.h);
        break;
      case ANAGLYPH_CYANLEFT_REDRIGHT:
        gl.glColorMask(true, false, false, true);
      //  gl.glColorMask(false, true, true, true);
        gl.glViewport(0, 0, this.w, this.h);
        break;
      case ANAGLYPH_REDLEFT_BLUERIGHT:
        gl.glColorMask(false, false, true, true);
        //gl.glColorMask(true, false, false, true);
        gl.glViewport(0, 0, this.w, this.h);
        break;
      case ANAGLYPH_BLUELEFT_REDRIGHT:
        gl.glColorMask(true, false, false, true);
       // gl.glColorMask(false, false, true, true);
        gl.glViewport(0, 0, this.w, this.h);
        break;
      case PASSIVE:
        gl.glViewport(0, 0, this.w / 2, this.h);
        break;
      default:
        gl.glViewport(0, 0, this.w, this.h);
    }

    /*
    switch (this.stereoType)
    {
      case ANAGLYPH_REDLEFT_CYANRIGHT:
        gl.glColorMask(false, true, true, true);
        break;
      case ANAGLYPH_CYANLEFT_REDRIGHT:
        gl.glColorMask(true, false, false, true);
        break;
      case ANAGLYPH_REDLEFT_BLUERIGHT:
        gl.glColorMask(false, false, true, true);
        break;
      case ANAGLYPH_BLUELEFT_REDRIGHT:
        gl.glColorMask(true, false, false, true);
        break;
    }
    */
//    gl.glMatrixMode(gl.GL_PROJECTION);
//    gl.glLoadIdentity();

//    switch (this.stereoType)
//    {
//      case PASSIVE:
//        gl.glViewport(this.w / 2, 0, this.w, this.h);
//        break;
//      default:
//        gl.glViewport(0, 0, this.w, this.h);
//    }

    // TODO: do we need to clear depth and color buffers here for active stereo?

    double top = widthdiv2;
    double bottom = -widthdiv2;
    double left = -aspectRatio * widthdiv2 - 0.5 * eyeSeperation * nearPlane / cameraFO;
    double right = aspectRatio * widthdiv2 - 0.5 * eyeSeperation * nearPlane / cameraFO;
    gl.glFrustum(left, right, bottom, top, nearPlane, farPlane);

    gl.glMatrixMode(gl.GL_MODELVIEW);
    gl.glLoadIdentity();
    glu.gluLookAt(
      posx + rightx, posy + righty, posz + rightz,
      posx + rightx + dirx, posy + righty + diry, posz + rightz + dirz,
      upx, upy, upz);
  }
}
