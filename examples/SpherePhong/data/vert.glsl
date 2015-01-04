/*
 
 */

uniform mat4 transform;
uniform mat4 modelview;
uniform mat3 normalMatrix;
uniform vec3 lightPosition;


attribute vec4 vertex;
attribute vec3 normal;
attribute vec4 color;

varying vec4 vertNormal;
varying vec4 vertColor;
varying vec3 lightVector;



void main() {
  vec4 position;
  vec4 light;
  position = transform * vertex; 

  vec3 ecVertex = vec3(modelview * vertex);  
  
  light = modelview * vec4(lightPosition,1.0);


  lightVector = normalize(lightPosition - ecVertex);
  vertNormal = vec4(normalize(normalMatrix * normal),1.0);

  vertColor = color;
  gl_Position = position;  
}