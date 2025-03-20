Shader "LearnShader/SLShader09"
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
                // // Calculate the interval index (0-9) and midpoint offset
                // float interval_width = 0.1;
                // float interval_index = floor(i.uv.x / interval_width);
                // float midpoint = interval_index * interval_width + interval_width * 0.5;
                //
                // // Determine color using step function (no branching)
                // float red_intensity = step(midpoint, i.uv.x);
                //
                // float3 color = float3(red_intensity, 0.0, 0.0);

                // 方法二
                float a = frac(i.uv.x * 10.0);
                float3 color = float3(step(0.5, a), 0.0, 0.0);

                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}