Shader "LearnShader/SLShader03"
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

            struct a2_v
            {
                float4 vertex : POSITION;
            };

            struct v2_f
            {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color = float4(0.0, 0.0, 1.0, 1.0);
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                return i.color.bgra;
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}