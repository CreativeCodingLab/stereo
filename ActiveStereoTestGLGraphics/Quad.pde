import processing.opengl.*;
import javax.media.opengl.*; 

class Quad {
  float[] pos;
  float[] rgba;
  float speed;
  int id;
  Quad(float _speed, int _id) {
    id = _id;
  this.pos = new float[3];
  this.rgba = new float[4];
  this.speed = _speed;
  this.pos[0] = -1 + random(0,1) * 2;
  this.pos[1] = -1 + random(0,1) * 2;
  this.pos[2] = -2;
  this.rgba[0] = random(0,1);
  this.rgba[1] = random(0,1);
  this.rgba[2] = random(0,1);
   
  }
  
  void display(GLGraphics glg) {    
    this.pos[2] += this.speed;
    pushMatrix();
    glg.gl.glTranslatef(this.pos[0],this.pos[1],this.pos[2]);
    glg.gl.glColor4f(this.rgba[0],this.rgba[1],this.rgba[2],1f);
    glg.gl.glRectf(-.5f,-.5f,.5f,.5f);
    popMatrix();
    if(this.pos[2] > 5) {
      this.pos[2] = -5;
    }
  }
}
