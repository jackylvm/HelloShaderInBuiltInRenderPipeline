Shader "Functions/FShader06"
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
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                float a = i.uv.x * 10.0;
                float b = i.uv.y * 10.0;
                float2 c = float2(ceil(a) * 0.1, ceil(b) * 0.1);

                return fixed4(c.x, 0.0, 0.0, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}