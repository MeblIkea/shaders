float4 mainImage(VertData v_in) : TARGET
{
	float4 imga_val0 = image.Sample(textureSampler, v_in.uv);
	
	float factor0 = (imga_val0.r + imga_val0.g)/2-0.5;
	float factor1 = (imga_val0.g + imga_val0.b)/2-0.5;
	//factor /= 5;
	float2 move_factor = float2(factor0, factor1);
	
	float4 imga_val1 = image.Sample(textureSampler, v_in.uv+move_factor*(sin(elapsed_time_show/5)/10));
	//float4 imgb_val0 = image_b.Sample(textureSampler, v_in.uv);
	
	float4 rgba = imga_val1;
	//rgba.rgb = srgb_nonlinear_to_linear(rgba.rgb);
	return rgba;
	//return imgb_val0+(imga_val1*invertedTt);
}
	