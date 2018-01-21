/*
attribute vec3 aVertexPosition;
attribute vec2 aTextureCoord;
uniform mat4 uMVMatrix;
uniform mat4 uPMatrix;
varying vec2 vTextureCoord;
void main(void) {
    gl_Position = uMVMatrix * uPMatrix *  vec4(aVertexPosition, 1.0);
    vTextureCoord = aTextureCoord;
}
*/
attribute vec4 Position;
attribute vec4 SourceColor;

varying vec4 DestinationColor;

void main(void) {
    DestinationColor = SourceColor;
    gl_Position = Position;
}
