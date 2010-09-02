package stereo;

import javax.media.opengl.GLCapabilities;
import javax.media.opengl.GLDrawableFactory;
import processing.opengl.PGraphicsOpenGL;

/*
 *
 * @author Angus Forbes & Charlie Roberts,
 * (but basically is just the same function as allocate() in PGraphicsOpenGL)
 */

///testing fugitive.vim
//tttt
//dfdkfjk
//jkjkj
public class ActiveStereoView extends PGraphicsOpenGL
{
  kjkjk
  @Override
  protected void allocate()
  {
    if (context == null)
    {
      // If OpenGL 2X or 4X smoothing is enabled, setup caps object for them
      GLCapabilities capabilities = new GLCapabilities();
      // Starting in release 0158, OpenGL smoothing is always enabled
      if (!hints[DISABLE_OPENGL_2X_SMOOTH])
      {
        capabilities.setSampleBuffers(true);
        capabilities.setNumSamples(2);
      }
      else if (hints[ENABLE_OPENGL_4X_SMOOTH])
      {
        capabilities.setSampleBuffers(true);
        capabilities.setNumSamples(4);
      }

      capabilities.setDoubleBuffered(true);
      capabilities.setStereo(true);

      // get a rendering surface and a context for this canvas
      GLDrawableFactory factory = GLDrawableFactory.getFactory();

      drawable = factory.getGLDrawable(parent, capabilities, null);
      context = drawable.createContext(null);

      // need to get proper opengl context since will be needed below
      gl = context.getGL();
      // Flag defaults to be reset on the next trip into beginDraw().
      settingsInited = false;

    }
    else
    {
      // The following three lines are a fix for Bug #1176
      // http://dev.processing.org/bugs/show_bug.cgi?id=1176
      context.destroy();
      context = drawable.createContext(null);
      gl = context.getGL();
      reapplySettings();
    }
  }
}
