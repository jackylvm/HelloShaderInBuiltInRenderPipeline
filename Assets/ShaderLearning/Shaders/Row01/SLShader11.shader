Shader "LearnShader/SLShader11"
{
    Properties
    {
        _CellSize("CellSize", Integer) = 50.0
        _Margin("Margin", Integer) = 10.0
        _Grid("Grid", Range(5,20)) = 10.0
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
                float2 uv : TEXCOORD0;
            };

            struct v2_f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            int _CellSize;
            int _Margin;
            int _Grid;

            v2_f vert(a2_v v)
            {
                v2_f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2_f i) : SV_Target
            {
                float cell_size = _CellSize;
                float margin = _Margin;

                float cell_width = cell_size + margin;
                float2 cell = i.uv * _Grid;

                float t = step(margin / cell_width, frac(cell.x));
                t *= step(margin / cell_width, frac(cell.y));

                return fixed4(t, 0.0, 0.0, 1.0);
            }
            ENDCG
        }
    }
    FallBack "VertexLit"
}