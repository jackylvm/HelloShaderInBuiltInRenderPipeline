Shader "LearnShader/SLShader01"
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
            };

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                return fixed4(1.0, 1.0, 0, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}