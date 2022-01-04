attribute vec3 aVertexPosition;
attribute vec3 aNormalPosition;
attribute mat3 aPrecomputeLT;

uniform mat4 uModelMatrix;
uniform mat4 uViewMatrix;
uniform mat4 uProjectionMatrix;
uniform vec3 uPrecomputeL[9];

varying highp vec3 vColor;
varying highp vec3 vFragPos;
varying highp vec3 vNormal;

vec3 computeSH(const mat3 precomputeLT, const vec3 precomputeL[9]){
  vec3 result = vec3(0, 0, 0);
  for(int i = 0; i < 3; i++)
    for(int j = 0; j < 3; j++)
      result += precomputeLT[i][j] * precomputeL[i * 3 + j];
  return result;
}

void main(void) {

  vFragPos = (uModelMatrix * vec4(aVertexPosition, 1.0)).xyz;
  vNormal = (uModelMatrix * vec4(aNormalPosition, 0.0)).xyz;

  gl_Position = uProjectionMatrix * uViewMatrix * uModelMatrix *
                vec4(aVertexPosition, 1.0);

  vColor = computeSH(aPrecomputeLT, uPrecomputeL);
}