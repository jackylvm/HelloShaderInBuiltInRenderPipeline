Shader "Jacky/MyShader09"
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
                float3 color : COLOR;
            };

            fixed4 _Diffuse;

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                // 环境光
                // 环境光设置在Unity的Window>Rendering>Lighting>Environment>Environment Lighting中设置
                float3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;

                float3 light_dir = normalize(_WorldSpaceLightPos0.xyz);
                float3 normal_dir = normalize(UnityObjectToWorldNormal(v.normal));

                // 使用半兰伯特光照模型
                float half_lambert = 0.5 * dot(normal_dir, light_dir) + 0.5;

                float3 diffuse = half_lambert * _LightColor0.rgb * _Diffuse.rgb;

                // 使用高光模型
                fixed3 reflect_dir = reflect(-light_dir, normal_dir);
                fixed3 view_dir = normalize(_WorldSpaceCameraPos - mul(unity_ObjectToWorld, v.vertex));
                float3 specular = _LightColor0.rgb * pow(max(dot(reflect_dir, view_dir), 0), 10);

                o.color = diffuse + ambient + specular;
                return o;
            }

            // 在片元着色器中计算光照颜色
            fixed4 frag(v2_f f) : SV_Target
            {
                return fixed4(f.color, 1.0);
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}