
//varying vec2 v_vTexcoord;
//varying vec4 v_vColour;

//uniform vec2  uUv;
//uniform float uOffset;

//uniform vec3 uColorTop;
//uniform vec3 uColorBottom;

//void main()
//{
//    float ynorm = (v_vTexcoord.y - uUv.x) / (uUv.y - uUv.x);
//    float t = clamp(ynorm - uOffset, 0.0, 1.0);

//    vec3 gradColor = mix(uColorTop, uColorBottom, t);

//    float alpha = texture2D(gm_BaseTexture, v_vTexcoord).a;

//    gl_FragColor = vec4(gradColor, alpha) * v_vColour;
//}


varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2  uUv;
uniform float uOffset;

uniform vec3 uColorTop;
uniform vec3 uColorBottom;

uniform float uHorizontal; // 0 = vertical, 1 = horizontal

void main()
{
    float axis = mix(v_vTexcoord.y, v_vTexcoord.x, uHorizontal);

    float norm = (axis - uUv.x) / (uUv.y - uUv.x);
    float t = clamp(norm - uOffset, 0.0, 1.0);

    vec3 gradColor = mix(uColorTop, uColorBottom, t);

    float alpha = texture2D(gm_BaseTexture, v_vTexcoord).a;
    gl_FragColor = vec4(gradColor, alpha) * v_vColour;
}