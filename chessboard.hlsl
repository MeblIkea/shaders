float4 mainImage(VertData v_in) : TARGET
{
	float2 uv = v_in.uv;
	float time = elapsed_time_show + 10000.;
	uv.x += time/50.;
	uv.y = time/50. - uv.y;
	uv.x %= .2;
	uv.y %= .2;
	float4 imga_val0 = image.Sample(textureSampler, uv);

    return imga_val0;
}
