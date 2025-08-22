/*uniform float Test<
  string label = "Test";
  string widget_type = "slider";
  float minimum = 0.0;
  float maximum = 360.0;
  float step = 0.1;
> = 0.;*/

float2 rotate2D(float2 p, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    float2x2 rot = float2x2(c, -s,
                            s,  c);
    return mul(p, rot);
}

float4 mainImage(VertData v_in) : TARGET
{
	float angle = radians(min(max(elapsed_time_active/2.-2., 0.)*360, 360.));
    float2 uv = v_in.uv;
    float2 rotatedUV = rotate2D(uv - 0.5, angle) + 0.5;
    float4 col = image.Sample(textureSampler, rotatedUV);
    return col;
}