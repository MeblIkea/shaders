float4 mainImage(VertData v_in) : TARGET
{
	float4 imga_val0 = image.Sample(textureSampler, v_in.uv);
	
	float time = elapsed_time_show / 4;

	float4 rgba = imga_val0;
	rgba.r = lerp(imga_val0.r, imga_val0.g, sin(time));
	rgba.g = lerp(imga_val0.g, imga_val0.b*(cos(time))+abs(sin(time)), sin(time));
	rgba.b = lerp(imga_val0.b, imga_val0.r*((cos(time)+sin(time))*-0.5), sin(time));
	
	return rgba;
}
