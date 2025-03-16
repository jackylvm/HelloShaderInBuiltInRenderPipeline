Shader "Jacky/MyShader03"
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

            // 顶点输入结构体,application to vertex:从应用到顶点
            struct a2_v
            {
                float4 vertex : POSITION; // 顶点位置
                float3 normal : NORMAL; // 法线方向
                float4 texcoord : TEXCOORD0; // 纹理坐标
                float4 tangent : TANGENT; // 切线方向
                float4 color : COLOR; // 顶点颜色
            };

            // 顶点输出结构体,vertex to fragment:从顶点到片元
            struct v2_f
            {
                float4 pos : SV_POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
                float4 tangent : TANGENT;
                float4 color : COLOR;
            };

            v2_f vert(a2_v v)
            {
                v2_f o;
                // o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = v.normal;
                o.texcoord = v.texcoord;
                o.tangent = v.tangent;
                o.color = v.color;
                return o;
            }


            fixed4 frag(v2_f f) : SV_Target
            {
                return fixed4(f.normal, 1.0);
            }
            ENDCG
        }
    }
    Fallback "VertexLit"
}