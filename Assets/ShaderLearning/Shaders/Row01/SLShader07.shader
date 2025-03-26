Shader "LearnShader/SLShader07"
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
                float2 uv : TEXCOORD0;
            };

            struct v2_f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                float a = 1.0 - step(0.25, i.uv.x);
                float b = step(0.75, i.uv.x);
                float c = max(a, b);
                float3 color = float3(1.0, 0.3, 0.3) * c;
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}