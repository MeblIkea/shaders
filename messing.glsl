float slerpScalar(float a, float b, float t) {
    float theta = t * 3.141592653589793;
    float f = (1.0 - cos(theta)) * 0.5;
    return lerp(a, b, f);
}


float4 render(float2 uv)
{
	uv.x = (uv.x / 0.2)%0.3;
	uv.y = (uv.y / 0.2)%0.5;
	float localTime = builtin_elapsed_time;
    float tT = slerpScalar(0.0, 1.0, localTime)*2.;
    float3 col = 0.5 + 0.5*cos(localTime+uv.xyx+float3(0,tT,0));

    float4 fragColor = float4(col, col.x);
	return fragColor;
}