uniform int quantization_level<
    string label = "Quantization Level";
    string widget_type = "slider";
    int minimum = 2;
    int maximum = 256;
    int step = 2;
> = 8;

float4 quantization(float4 col, int quant_lvl) {
	//levels  = exp2(bitsPerChannel)							//0-BIT
	//col.rgb = round(col.rgb * (quant_lvl)) / (quant_lvl-1);	//1-REDUCTION
	
	col.rgb = round(col.rgb * (quant_lvl-1)) / (quant_lvl-1);
	return col;
}

float4 mainImage(VertData v_in) : TARGET
{
	float4 base = image.Sample(textureSampler, v_in.uv);
	base = quantization(base, quantization_level);
	return base;
}
