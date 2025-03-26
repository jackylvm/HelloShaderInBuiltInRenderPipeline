Shader "LearnShader/SLShader22"
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
                float2 center = float2(0.5, 0.5);
                float dist = distance(i.uv, center);
                float2 dir = i.uv - center;
                float angle = atan2(dir.y, dir.x) / 3.14;

                float3 col1 = float3(1.0, 0.0, 0.0);
                float3 col2 = float3(0.0, 1.0, 0.0);
                float3 col = lerp(col1, col2, abs(angle));

                // 限定在一个圆里面
                col -= step(0.5, dist);

                return fixed4(col, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}