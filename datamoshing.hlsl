uniform texture2d image_a;
uniform texture2d image_b;
uniform float transition_time = 0.0;

float distance(float3 a, float3 b) {
	return math.sqrt(math.pow(b.x - a.x, 2) + math.pow(b.y - a.y, 2) + math.pow(b.z - a.z, 2));
}

float2 blockArtifact(float2 uv, float blockSize) {
	uv.xy = floor(uv.xy / blockSize);
	uv.xy *= blockSize;
	return uv;
}

float4 chromaSubsampling420(VertData v_in, texture2d image, int blockSizePara) {
    float2 blockSize = uv_pixel_interval * blockSizePara;
    float2 blockUV = floor(v_in.uv / blockSize) * blockSize + blockSize * 0.5;

    float4 rgba = image.Sample(textureSampler, v_in.uv);

    float4 chromaSample = image.Sample(textureSampler, blockUV);

    float y = 0.299 * rgba.r + 0.587 * rgba.g + 0.114 * rgba.b;

    float u = (chromaSample.b - y) * 0.493;
    float v = (chromaSample.r - y) * 0.877;

    rgba.r = y + 1.140 * v;
    rgba.g = y - 0.394 * u - 0.581 * v;
    rgba.b = y + 2.032 * u;

    return rgba;
}

float4 quantization(float4 col, int quant_lvl) {
	//levels  = exp2(bitsPerChannel)							//0-BIT
	//col.rgb = round(col.rgb * (quant_lvl)) / (quant_lvl-1);	//1-REDUCTION
	
	col.rgb = round(col.rgb * (quant_lvl-1)) / (quant_lvl-1);
	return col;
}

float4 mainImage(VertData v_in) : TARGET
{
	if (transition_time >= 0.96) {
		float4 rgba = image_b.Sample(textureSampler, v_in.uv);
		rgba.rgb = srgb_nonlinear_to_linear(rgba.rgb);
		return rgba;
	} else if (transition_time <= 0.02) {
		float4 rgba = image_a.Sample(textureSampler, v_in.uv);
		rgba.rgb = srgb_nonlinear_to_linear(rgba.rgb);
		return rgba;
	}
	float invertedTt = (transition_time*-1)+1;
	float xTriangle = max(abs(transition_time-.5)*-2.+1., 0.);
	
	v_in.uv = blockArtifact(v_in.uv, xTriangle*0.002);
	float4 imga_val0 = chromaSubsampling420(v_in, image_b, xTriangle*32.);
	
	float factor0 = (imga_val0.r + imga_val0.g)/2-0.5;
	float factor1 = (imga_val0.g + imga_val0.b)/2-0.5;
	float2 move_factor = float2(factor0, factor1);
	
	float4 rgba = imga_val0;
	v_in.uv += move_factor*transition_time;
	v_in.uv.x %= 1.;
	v_in.uv.y %= 1.;
	float4 imga_val1 = chromaSubsampling420(v_in, image_a, xTriangle*32.);
	
	rgba = lerp(imga_val1, imga_val0, max(2*transition_time-1, 0));
	rgba = quantization(rgba, (xTriangle * -1 + 2)*8);
	rgba.rgb = srgb_nonlinear_to_linear(rgba.rgb);
	return rgba;
}
	