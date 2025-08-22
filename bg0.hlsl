float4 mainImage(VertData v_in) : TARGET
{
    float2 uv = v_in.uv;
    float time = elapsed_time_show+1000;
    uv.x = ( (uv.x+time/50.) % .2)*5.;
    uv.y = ( (time/100.-uv.y ) % .2)*5.;

    float4 final_bg = float4(uv.x, uv.y, uv.x, 1.0);

    return final_bg;
}
