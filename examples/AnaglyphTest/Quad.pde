import processing.opengl.*;
import javax.media.opengl.*; 

class Quad {
  float Qrad;
  float Qangle;
  float y;
  float[] rgba;
  float speed;
  int id;
  Quad(float _speed, int _id) {
    id = _id;
    float Rmax = 5.0;
    float Ymax = 3; 
  this.rgba = new float[4];
  this.speed = _speed;
  
  this.Qangle = random(0,2*PI);
  this.Qrad = random(0.01,Rmax); 
  this.y = random(-Ymax*(1.0-this.Qrad/Rmax),Ymax*(1.0-this.Qrad/Rmax));
  this.rgba[0] = random(0,1);
  this.rgba[1] = random(0,1);
  this.rgba[2] = random(0,1);
   
  }
  
  void display(GL2 gl, float[] TheParams) { 
    float Rmax = 5.0;
    float r =this.Qrad;
    this.Qangle += this.speed;
    float a = Qangle;  
    float x = r*sin(a);
    float z = r*(TheParams[0])*cos(a);
    float b = r*(TheParams[1]);
    float s = sin(b);
    float c = cos(b);
  
 
    gl.glPushMatrix();
    gl.glTranslatef(s*x+c*z,TheParams[2]*this.y,c*x-s*z);
     gl.glColor4f(this.rgba[0],this.rgba[1],this.rgba[2],1f);
    gl.glRectf(-.1f,-.1f,.1f,.1f);
    gl.glPopMatrix();
  }
}
