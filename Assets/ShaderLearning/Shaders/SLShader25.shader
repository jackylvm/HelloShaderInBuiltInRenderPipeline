Shader "LearnShader/SLShader25"
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
                float2 p0 = float2(0.5, 0.75);
                float2 p1 = float2(0.5, 0.0);
                float2 p2 = i.uv;

                float2 dir2 = p2 - p0;
                float2 n1 = normalize(p1 - p0);
                float2 n2 = normalize(dir2);

                float t = dot(n1, n2);
                float d = dot(n1, dir2);

                float red = step(0.5, t);
                red *= (1 - step(0.5, d));

                return fixed4(red, 0.0, 0.0, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}