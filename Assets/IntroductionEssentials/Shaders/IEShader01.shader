Shader "IE/IEShader01"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            float4 vert(float4 vertex : POSITION):SV_POSITION
            {
                return UnityObjectToClipPos(vertex);
            }

            float4 frag(float4 vertex : SV_POSITION):SV_TARGET
            {
                return fixed4(1, 0, 0, 1);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}