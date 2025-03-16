Shader "Jacky/MyShader07"
{
    Properties
    {
        _Diffuse ("Diffuse Color", Color) = (1,1,1,1)
    }
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
                float3 normal : NORMAL;
            };

            fixed4 _Diffuse;

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            // 在片元着色器中计算光照颜色
            fixed4 frag(v2_f f) : SV_Target
            {
                // 环境光
                // 环境光设置在Unity的Window>Rendering>Lighting>Environment>Environment Lighting中设置
                float3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;

                float3 light_dir = normalize(_WorldSpaceLightPos0.xyz);
                float3 normal_dir = normalize(f.normal);
                
                float3 diffuse = max(0, dot(normal_dir, light_dir));

                // 漫反射光 + 环境光
                float3 color = diffuse * _LightColor0.rgb * _Diffuse.rgb + ambient;
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}