float4 render(float2 uv)
{
	float time = builtin_elapsed_time;
	
	uv.x = ((uv.x*3.)%0.7 + cos(time))%1;
	uv.y = ((uv.y*3.)%0.7 + sin(time)/2.)%1;
	float4 nImage = image.Sample(builtin_texture_sampler, uv);
	nImage.a = (cos(time)+1.)/2.;
	return nImage;
}