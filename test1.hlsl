float4 processing0(VertData v_in) {
	float4 s = image.Sample(textureSampler, v_in.uv);
	v_in.uv.x *= 0.95;
	v_in.uv.y *= 0.95;
	float4 s1 = image.Sample(textureSampler, v_in.uv);
	v_in.uv.x *= 1.15;
	v_in.uv.y *= 0.95;
	float4 s2 = image.Sample(textureSampler, v_in.uv);
	s.x *= s1.x;
	s.y *= s2.y;
	if (s.z == s1.z && s.z == s2.z) {
		s.a = 0.;
	}
	return s;
}

float4 processing1(VertData v_in, float4 s) {
	if (s.x > s.y) {
		s.x = v_in.uv.x;
		s.y = v_in.uv.x;
		s.z = sin(v_in.uv.x + elapsed_time_show);
	}
	return s;
}

float4 processing2(VertData v_in, float4 s) {
	if (sin(rand_f*22539) < v_in.uv.x && v_in.uv.x < sin(rand_f*914924) && sin(rand_f*149814) < v_in.uv.y && v_in.uv.y < sin(rand_f*23509)) {
		s.y = sin(v_in.uv.x*2.)*s.x;
		s.z = sin(v_in.uv.x*2.)*s.x;
	}
	return s;
}

VertData processing2_2(VertData v_in, float4 s) {
	if (sin(rand_f*139) < v_in.uv.x && v_in.uv.x < sin(rand_f*2589) && sin(rand_f*25825) < v_in.uv.y && v_in.uv.y < sin(rand_f*23509)) {
		v_in.uv.x = v_in.uv.y - 0.2;
		v_in.uv.y = v_in.uv.y - 0.2;
	}
	return v_in;
}

float4 processing3(VertData v_in, float4 s) {
	s.y *= sin(elapsed_time_show * 2042) / 2. + .5;
	s.x *= sin(elapsed_time_show) / 2. + .5;
	return s;
}

VertData processing4(VertData v_in) {
	if (sin(rand_f*2825) < v_in.uv.y && v_in.uv.y < sin(rand_f*255))
		v_in.uv.y = sin(elapsed_time_show) / 2. + .5;
	return v_in;
}

float4 processing5(VertData v_in, float4 s) {
	if (s.x < 0.1 && s.y < 0.1 && s.z < 0.1)
		s.a = 0.;
	return s;
}

float4 mainImage(VertData v_in) : TARGET
{
	v_in = processing4(v_in);
	float4 s = image.Sample(textureSampler, v_in.uv);
	
	return s;
}
