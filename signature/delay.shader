uniform texture2d previous_output;

float4 mainImage(VertData v_in) : TARGET
{
	float4 col = image.Sample(textureSampler, v_in.uv);
	v_in.uv.y += (sin(elapsed_time)/2.+0.5)/50.+.01;
	v_in.uv.x += rand_f/100+.04;
	float4 prevCol = previous_output.Sample(textureSampler, v_in.uv);
	prevCol.a -= 0.2;
	prevCol.b = col.a;
	prevCol.g = sin(elapsed_time)/2.+0.5;
	col += prevCol;
	return col;
}