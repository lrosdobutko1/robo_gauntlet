////
//// Simple passthrough fragment shader
////
//varying vec2 v_vTexcoord;
//varying vec4 v_vColour; 

//uniform vec2 uUv;
//uniform float uOffset;

//void main()
//{
//    float ynorm = (v_vTexcoord.y - uUv[0]) / (uUv[1] - uUv[0]);
//    float gray = clamp(ynorm - uOffset, 0.0, 1.0);
//	gray *= 0.5;

//    float alpha = texture2D(gm_BaseTexture, v_vTexcoord).a;
//    gl_FragColor = vec4(vec3(gray), alpha);
//}

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2  uUv;
uniform float uOffset;

uniform vec3 uColorTop;
uniform vec3 uColorBottom;

void main()
{
    float ynorm = (v_vTexcoord.y - uUv.x) / (uUv.y - uUv.x);
    float t = clamp(ynorm - uOffset, 0.0, 1.0);

    vec3 gradColor = mix(uColorTop, uColorBottom, t);

    float alpha = texture2D(gm_BaseTexture, v_vTexcoord).a;

    gl_FragColor = vec4(gradColor, alpha) * v_vColour;
}