Shader "LearnShader/SLShader26"
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
                // 将顶点位置从模型空间转换到裁剪空间
                o.vertex = UnityObjectToClipPos(v.vertex);
                // 应用纹理的缩放和平移
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                float line_with = 0.2;
                float3 line_color = float3(1.0, 0.1, 0.1);
                float value = clamp(i.uv.x, 0.25, 0.75);
                float dist = abs(i.uv.y - value);
                float r = 1.0 - step(line_with * 0.5, dist);

                return fixed4(line_color * r, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}