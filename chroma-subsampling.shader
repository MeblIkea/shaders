uniform int blockSizeConfig<
    string label = "Block Size";
    string widget_type = "slider";
    int minimum = 2;
    int maximum = 256;
    int step = 2;
> = 8;

float4 chromaSubsampling420(VertData v_in, int blockSizePara) {
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


float4 mainImage(VertData v_in) : TARGET
{
	float4 base = chromaSubsampling420(v_in, blockSizeConfig);
	return base;
}
