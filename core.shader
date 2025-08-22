
float4 mainImage(VertData v_in) : TARGET
{
	float4 argb = image.Sample(textureSampler, v_in.uv);
	if (argb.r < 0.5 || argb.g < 0.5 || argb.b < 0.5) {
		argb.a = 0.0;
	}
	return argb;
}
