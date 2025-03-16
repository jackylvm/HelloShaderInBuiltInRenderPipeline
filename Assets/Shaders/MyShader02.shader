Shader "Jacky/MyShader02"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            // 顶点函数
            // 作用是: 将顶点坐标从模型空间转换到裁剪空间,从顶点着色器传递到片元着色器,从游戏环境转换到视野相机屏幕
            #pragma vertex vert
            // 片元函数
            // 作用是: 返回模型对应的屏幕上的每个像素的颜色
            #pragma fragment frag

            float4 vert(float4 vertex : POSITION) : SV_POSITION
            {
                return UnityObjectToClipPos(vertex);
            }

            fixed4 frag(float4 pos:SV_POSITION) : SV_Target
            {
                float3 color = normalize(pos.xyz);
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
    Fallback "VertexLit"
}