Shader "LearnShader/SLShader08"
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

            float step_union(float edge, float x)
            {
                // check if the value is less than 0.25.
                float r0 = 1.0 - step(edge, x);

                // check if the value is greater than 0.75.
                float r1 = step(1 - edge, x);

                // check if the value is less than 0.25 or greater than 0.75.
                return max(r0, r1);
            }

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                // 方法一
                // float a = step_union(0.25, i.uv.x);
                // float b = step_union(0.25, i.uv.y);
                // float c = max(a, b);
                // float3 color = float3(i.uv.x, i.uv.y, 0.0) * c;

                // return fixed4(color, 1.0);

                // 方法二
                float w0 = 0.10;
                float w1 = 0.10;

                float t1 = step(1.0 - w0, i.uv.x);
                float t2 = 1.0 - step(w0, i.uv.x);
                float t3 = step(1.0 - w1, i.uv.y);
                float t4 = 1.0 - step(w1, i.uv.y);

                float t = max(t1, max(t2, max(t3, t4)));

                return fixed4(i.uv * t, 0.0, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}