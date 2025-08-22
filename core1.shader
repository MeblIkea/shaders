
float4 mainImage(VertData v_in) : TARGET
{
	float4 argb = image.Sample(textureSampler, v_in.uv);
	if (argb.a == 0.0) {
		argb.a = 1.;
		argb.r = sin(elapsed_time - v_in.uv.x) / 2.;
		argb.r /= v_in.uv.y % 0.1;
		argb.g = cos(elapsed_time - v_in.uv.y) / 2.;
		argb.g /= v_in.uv.x % 0.1;
		argb.b = max(argb.r, argb.g);
	}
	return argb;
}
