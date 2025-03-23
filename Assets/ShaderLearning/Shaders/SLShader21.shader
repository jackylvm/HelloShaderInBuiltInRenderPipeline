Shader "LearnShader/SLShader21"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
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

            sampler2D _MainTex;
            // 纹理的采样偏移
            float4 _MainTex_ST;

            v2_f vert(a2_v v)
            {
                v2_f o;
                // 将顶点位置从模型空间转换到裁剪空间
                o.vertex = UnityObjectToClipPos(v.vertex);
                // 应用纹理的缩放和平移
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                // TODO:这个shader牵涉到矩形,没想到怎么实现
                // 采样纹理
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}