Shader "LearnShader/SLShader13"
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
            #pragma target 3.0

            #include "UnityCG.cginc"

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

            // lerp函数
            // float3 mix(float3 start, float3 end, float t)
            // {
            //     return start + (end - start) * t;
            // }

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                float4 color1 = float4(0.60, 0.20, 0.00, 1.0);
                float4 color2 = float4(1.00, 0.80, 1.00, 1.0);

                float t = step(0.5, i.uv.x) * (i.uv.x - 0.5);

                return fixed4(lerp(color1, color2, t));
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}