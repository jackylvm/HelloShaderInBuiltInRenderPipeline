Shader "LearnShader/SLShader16"
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
                float r = abs(i.uv.x * 2.0 - 1.0);
                return fixed4(r, 0.0, 0.0, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}