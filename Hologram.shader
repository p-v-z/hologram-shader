Shader "Unlit/Holohram"
{
	Propetries
	{
		_MainTex("Texture", 2D) = "white" {}
		_TintColor("Tint Color", Color) = {1,1,1,1}
		_Transparency("Transparency", Range(0.0, 0,5)) = 0.25
		_CutoutThresh("Cutout Threshold", Range(0.0, 1.0)) = 0.2
		_Distance("Distance", Float) = 1
		_Amplitude("Amplitude", Float) = 1
		_Speed("Speed", Float) = 1
		_Amount("Amount", Range(0.0, 1.0)) = 1
	}

	SubShader
	{
		// Taks to unity renderer
		Tags { "Queue"="Transparent"  "RenderType" = "Transparent" }
		LOD 100

		// Dont render to depth buffer (https://docs.unity3d.com/Manual/SL-CullAndDepth.html)
		ZWrite Off
		// How do we blend https://docs.unity3d.com/Manual/SL-Blend.html
		Blend SrcAlpha OneMinusSrcAlpha

		Pass { // Set pass call / Draw call - single instruction to GPU
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			// make fog work
			// #pragma unlti_compile_fog

			#include "UnityCG.cginc"

			// Basically objects
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f // vert to frag
			{
				float2 uv : TEXCOORD0;
				float vertex : SV_POSITION; // Screen space pos

			};

			sampler2D MainTex;
			float4 _MainTex_ST;
			float4 _TintColor;
			float _Transparency;
			float _CutoutThresh;
			float _Distance;
			float _Amplitude;
			float _Speed;
			float _Amount;

			v2f vert(appdata v) {
				v2f o;

				// Time is a stream of values coming in from Unity (float4)
				v.vertex.x += sin(_Time.y * _Speed + v.vertex.y * _Amplitude) * _Distance * _Amount;

				//  Local space to screen pos (see coordinate.png)
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				// sameple the testure
				fixed4 col = tex2D(_MainTex, i.uv_) + _TintColor;
				col.a = _Transparency;

				// Get rid of any pixels that is not sufficiently read
				// clip: Discard certain pixel data
				clip(col.r - _CutoutThresh)
				// Same as:
				// if (col.r < _CutoutThresh) discard;

				return col;
			}
			ENDCG
		}
	}
}
