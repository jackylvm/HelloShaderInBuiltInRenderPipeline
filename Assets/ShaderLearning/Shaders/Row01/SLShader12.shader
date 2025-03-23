Shader "LearnShader/SLShader12"
{
    Properties
    {
        _HidePos("HidePos", Range(0,2)) = 1.0
    }
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

            int _HidePos;

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                float2 uv = i.uv * 9.0;

                float c = frac(uv.x);
                c = step(0.5, c);
                
                float a = fmod(uv.x + _HidePos, 3.0);
                float b = step(1.0, a);
                
                c = c * b;
                return fixed4(c, 0.0, 0.0, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}