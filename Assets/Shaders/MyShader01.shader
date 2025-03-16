Shader "Jacky/MyShader01"
{
    Properties
    {
        _Color("Color", Color) = (1, 1, 1, 1)
        _Vector("Vector", Vector) = (1, 1, 1, 1)
        _Int("Int", Int) = 1
        _Float("Float", Float) = 1
        _Range("Range", Range(0, 10)) = 1
        _2D("Texture2D", 2D) = "white" {}
        _Cube("Cube", Cube) = "white" {}
        _3D("Texture3D", 3D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct a2_v
            {
                float4 vertex : POSITION;
                float3 color : COLOR;
            };

            struct v2_f
            {
                float4 pos : SV_POSITION;
                float3 color : COLOR;
            };

            // float 32位
            // half 16位
            // fixed 11位
            fixed4 _Color;
            fixed4 _Vector;
            float _Int;
            float _Float;
            float _Range;
            sampler2D _2D;
            samplerCUBE _Cube;
            sampler3D _3D;

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = _Color.rgb;
                return o;
            }

            fixed4 frag(v2_f f) : SV_Target
            {
                return fixed4(f.color, 1.0);
            }
            ENDCG
        }
    }
    Fallback "VertexLit"
}