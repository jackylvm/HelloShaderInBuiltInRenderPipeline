Shader "LearnShader/SLShader02"
{
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct a2_v
            {
                float4 vertex : POSITION;
            };

            struct v2_f
            {
                float4 vertex : SV_POSITION;
            };

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                float4 blue_channel = float4(0.0, 0.0, 0.75, 0.0);
                float4 red_channel = float4(0.5, 0.0, 0.0, 0.0);
                float4 alpha_channel = float4(0.0, 0.0, 0.0, 1.0);
                float4 sum_channel = blue_channel + red_channel + alpha_channel;
                return fixed4(sum_channel.r, sum_channel.g, sum_channel.b, red_channel.a);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}