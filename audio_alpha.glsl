#pragma shaderfilter set main__mix__description Main Mix/Track
#pragma shaderfilter set main__channel__description Main Channel
#pragma shaderfilter set main__dampening_factor_attack 0.0
#pragma shaderfilter set main__dampening_factor_release 0.0

#pragma shaderfilter set fft_min_input_limit__description FFT Min Input
#pragma shaderfilter set fft_min_input_limit__default -30
uniform int fft_min_input_limit;
#pragma shaderfilter set fft_max_input_limit__description FFT Max Input
#pragma shaderfilter set fft_max_input_limit__default 0
uniform int fft_max_input_limit;
#pragma shaderfilter set fft_output_mult__description FFT Output Multiply
#pragma shaderfilter set fft_output_mult__default 1.0
uniform float fft_output_mult;
#pragma shaderfilter set fft_max_frequencies__description FFT Max Frequencies
#pragma shaderfilter set fft_max_frequencies__default 20
uniform float fft_max_frequencies;
#pragma shaderfilter set fft_min_frequencies__description FFT Min Frequencies
#pragma shaderfilter set fft_min_frequencies__default 300
uniform float fft_min_frequencies;

uniform texture2d builtin_texture_fft_main;
uniform texture2d image;

float remap(float x, float2 from, float2 to) {
    float normalized = (x - from[0]) / (from[1] - from[0]);
    return normalized * (to[1] - to[0]) + to[0];
}

float getPeakFFT() {
    float peak = 0.0;
    float minI = (fft_min_frequencies - 20.0) / (22050.0 - 20.0);
    float maxI = (fft_max_frequencies - 20.0) / (22050.0 - 20.0);
 
    for (float i = minI; i <= maxI; i += 0.01) {
        float fft_amplitude = builtin_texture_fft_main.Sample(builtin_texture_sampler, float2(i, 0.5)).r;
        peak = max(peak, fft_amplitude);
    }
    return peak;
}


float4 render(float2 uv) {
	float peak_fft = getPeakFFT();
    float fft_db = 20.0 * log(peak_fft / 0.5) / log(10.0);
    float fft_db_remapped = remap(fft_db, float2(fft_min_input_limit, fft_max_input_limit), float2(0, 1));
	fft_db_remapped *= fft_output_mult;
	float4 nImage = image.Sample(builtin_texture_sampler, uv);
	nImage.a *= fft_db_remapped;
    return nImage;
}
