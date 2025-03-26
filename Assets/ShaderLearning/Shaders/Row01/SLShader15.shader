Shader "LearnShader/SLShader15"
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

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                float3 red = float3(1.0, 0.0, 0.0);
                float3 green = float3(0.0, 1.0, 0.0);

                float3 color = lerp(red, green, smoothstep(0.25, 0.75, i.uv.x));

                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}