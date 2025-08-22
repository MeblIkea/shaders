/*uniform int Time<
  string label = "Time";
  string widget_type = "slider";
  int minimum = 0;
  int maximum = 5000;
  int step = 1;
> = 1000;*/

float y_in(float x) {
	return abs(sin(x*10-0.6))*(sin(x/2.)*-1.+1.);
}

float4 mainImage(VertData v_in) : TARGET
{
	float time = min(elapsed_time_active/2., 1.);
	v_in.uv.x -= -1.+time;
	v_in.uv.y += y_in(time);
	float4 col = image.Sample(textureSampler, v_in.uv);
	return col;
}
