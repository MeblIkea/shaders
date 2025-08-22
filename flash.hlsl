float4 mainImage(VertData v_in) : TARGET
{
	float time = elapsed_time_show * -5 + 1;
	
	return image.Sample(textureSampler, v_in.uv) + max(time, 0);
}
