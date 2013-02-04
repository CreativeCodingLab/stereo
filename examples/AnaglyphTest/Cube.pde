class Cube {
 int yRotateSpeed, zRotateSpeed, yRotation, zRotation, zDepth, size, xPos, yPos;

 Cube(int yRs, int zRs, int zD, int s, int x, int y) {
   yRotateSpeed = yRs;
   zRotateSpeed = zRs;
   zDepth = zD;
   yRotation = 0;
   zRotation = 0;
   size = s;
   xPos = x;
   yPos = y;
 }

 void drawConnection(int i) {
   stroke(255,0,0);
   //line(this.xPos, this.yPos, this.zDepth, cubes[i].xPos, cubes[i].yPos, cubes[i].zDepth);
   stroke(0,0,0);
 }

 void display() {
   pushMatrix();
   translate(xPos, yPos, zDepth);
   rotateY(radians(yRotation));
   rotateZ(radians(zRotation));
   box(size, size, size);
   zRotation += zRotateSpeed;
   yRotation += yRotateSpeed;
   popMatrix();
 }

}
