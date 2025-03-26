Shader "LearnShader/SLShader24"
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

            float _NumberOfCircles;

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
                float2 normal = normalize(i.uv - float2(0.5, 0.5));
                float r = normal.x;
                float t = normal.y;
                return fixed4(t, t, t, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}