uniform float Test<
  string label = "Test";
  string widget_type = "slider";
  float minimum = 0.0;
  float maximum = 1.0;
  float step = 0.1;
> = 0.;

float pseudoRandom(float x) {
	return sin(x*rand_f * 4.)/2.0+0.5;
}

float4 mainImage(VertData v_in) : TARGET
{
	float time0 = min(max(elapsed_time_active/4.-1., 0.), 1.0);
	if (abs(v_in.uv.x - rand_f) < 0.04, abs(v_in.uv.y - rand_f) < 0.04) {
		v_in.uv.y += lerp(0.0, 0.05, time0);
	}
	float time = min(max(elapsed_time_active/2.-4., 0.)*1.0, 1.0)*-1+1.;
    float4 col = image.Sample(textureSampler, v_in.uv);
	col.a *= time;
    return col;
}