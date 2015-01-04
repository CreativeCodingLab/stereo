/*

 */

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec3 diffuseLightColor;
uniform vec3 ambientLightColor;



varying vec4 vertNormal;
varying vec4 vertColor;
varying vec3 lightVector;



void main() {
  vec3 color;
  float diffuseCoefficient;

  diffuseCoefficient = max(0.0,dot(vertNormal.xyz,lightVector));
  color = vec3(diffuseCoefficient, diffuseCoefficient, diffuseCoefficient)  * diffuseLightColor; 
  


  gl_FragColor = clamp(vec4(color,1.0) + vec4(ambientLightColor,1.0),0.0,1.0);

}