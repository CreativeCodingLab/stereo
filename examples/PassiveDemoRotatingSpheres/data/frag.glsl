/*

 */

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec3 diffuseLightColor;
uniform vec3 ambientLightColor;
uniform int right;



varying vec4 vertNormal;
varying vec4 vertColor;
varying vec3 lightVector;



void main() {
  vec3 color;
  vec4 finalColor;
  float diffuseCoefficient;

  diffuseCoefficient = max(0.0,dot(vertNormal.xyz,lightVector));
  color = vec3(diffuseCoefficient, diffuseCoefficient, diffuseCoefficient)  * diffuseLightColor; 
  

//  if(right==1){
//    //color = vec3(diffuseCoefficient, diffuseCoefficient, diffuseCoefficient)  * vec3(1.0,0.0,0.0); 
//    finalColor = clamp(vec4(color,1.0) + vec4(ambientLightColor,1.0),0.0,1.0);
    //gl_FragColor = clamp(vec4(color,1.0) + vec4(ambientLightColor,1.0),0.0,1.0) * vec4(0.0,1.0,1.0,1.0);
//    gl_FragColor = vec4(0.0, finalColor.g,finalColor.b,1.0);
//    } else if (right == 0){
    //color = vec3(diffuseCoefficient, diffuseCoefficient, diffuseCoefficient)  * vec3(0.0,1.0,0.0); 
    //gl_FragColor = clamp(vec4(color,1.0) + vec4(ambientLightColor,1.0),0.0,1.0) * vec4(1.0,0.0,0.0,1.0);
//    finalColor = clamp(vec4(color,1.0) + vec4(ambientLightColor,1.0),0.0,1.0);
// 	gl_FragColor = vec4(finalColor.r, 0.0,0.0,1.0);  
//    }
  gl_FragColor = clamp(vec4(color,1.0) + vec4(ambientLightColor,1.0),0.0,1.0);

}