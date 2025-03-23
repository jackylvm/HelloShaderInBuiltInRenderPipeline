Shader "LearnShader/SLShader10"
{
    Properties
    {
        _Column("Columns", Integer) = 5.0
        _Row("Rows", Integer) = 3.0
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

            float pattern(float2 uv)
            {
                uv = uv * 2.0 - 1.0;
                float t = pow(uv.x * uv.x, 0.3) + pow(uv.y * uv.y, 0.3) - 1.0;
                return step(0.0, t) * t * 10.0 + step(0.2, t);
            }

            int _Column;
            int _Row;
            
            v2_f vert(a2_v v)
            {
                v2_f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                float columns = _Column;
                float rows = _Row;

                // Calculate repeated cells based on UV coordinates
                float2 repeated_uv = frac(i.uv * float2(columns, rows));

                return fixed4(pattern(repeated_uv), 0.0, 0.0, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}