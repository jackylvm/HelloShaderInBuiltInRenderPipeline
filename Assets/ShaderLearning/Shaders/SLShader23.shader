Shader "LearnShader/SLShader23"
{
    Properties
    {
        _NumberOfCircles("Number of Circles", Range(1,20)) = 1
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
                float2 center = float2(0.5, 0.5);
                float dist = distance(i.uv, center);

                float r = sin(dist * 3.1415926 * 2.0 * _NumberOfCircles);

                return fixed4(r, 0.0, 0.0, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}