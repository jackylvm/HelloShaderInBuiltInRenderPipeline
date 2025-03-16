Shader "Jacky/MyShader04"
{
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 100

        Pass
        {
            Tags
            {
                "LightMode" = "ForwardBase"
            }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            struct a2_v
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2_f
            {
                float4 pos : SV_POSITION;
                float3 color : COLOR;
            };

            // 在顶点着色器中计算光照颜色
            v2_f vert(a2_v v)
            {
                v2_f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                // replaced '_World2Object' with 'unity_WorldToObject'
                // float3 normal_dir = normalize(mul(v.normal, (float3x3)_World2Object));
                float3 normal_dir = normalize(mul(v.normal, (float3x3)unity_WorldToObject));
                float3 light_dir = normalize(_WorldSpaceLightPos0.xyz);

                float3 diffuse = max(0, dot(normal_dir, light_dir));
                o.color = diffuse * _LightColor0.rgb;

                return o;
            }

            fixed4 frag(v2_f f) : SV_Target
            {
                return fixed4(f.color, 1.0);
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}