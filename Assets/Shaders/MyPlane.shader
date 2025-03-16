Shader "Jacky/MyPlane"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
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

            #include "UnityCG.cginc"

            struct a2_v
            {
                float4 vertex : POSITION;
            };

            struct v2_f
            {
                float4 pos : SV_POSITION;
            };

            fixed4 _Color;

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag(v2_f f) : SV_Target
            {
                return float4(_Color.rgb, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}