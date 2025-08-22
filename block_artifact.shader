uniform float blockSizeConfig<
    string label = "Block Size";
    string widget_type = "slider";
    float minimum = 0.;
    float maximum = 1.;
    float step = 0.001;
> = 0.01;

float2 blockArtifact(float2 uv, float blockSize) {
	uv.xy = floor(uv.xy / blockSize);
	uv.xy *= blockSize;
	return uv;
}

float4 mainImage(VertData v_in) : TARGET
{
	v_in.uv = blockArtifact(v_in.uv, blockSizeConfig);
	float4 base = image.Sample(textureSampler, v_in.uv);
	return base;
}

