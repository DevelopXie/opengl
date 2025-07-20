#version 330 core
layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec2 TexCoords;

out vec2 outTexCoord;
out vec3 outNormal;
out vec3 outFragPos;  // 片段着色器的位置

uniform float factor;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main() {

  gl_Position = projection * view * model * vec4(Position, 1.0f);

  outFragPos = vec3(model * vec4(Position, 1.0));  // 片段着色器的位置

  outTexCoord = TexCoords;
  // 解决不等比缩放，对法向量产生的影响,影响效率，最好的方法是用CPU计算法线矩阵，然后通过uniform把值传递给着色器
  outNormal = mat3(transpose(inverse(model))) * Normal;
}