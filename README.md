# Hologram Shader
This project runs over the fundamentals of Unity shaders buy putting together an unlit shader which could be used for a hologram with a glitching effect.

[Unity Tutorial](https://learn.unity.com/tutorial/writing-your-first-shader-in-unity#5c7f8528edbc2a002053b577)

<br>

## How it fits together:
>### **3D model**
>- Vertex positions (model points)
>- Vectex colours
>- Nromals (vertex directions)
>- UV data (texture mapping)

<p style="text-align:center;">has a</p>

>### **Material**
>- Textures
>- Shader property values

<p style="text-align:center;">uses a</p>

>### **Shader**
> A program made to run on a GPU. It ultimately draws the triangles of your 3D models.
>- CG / HLSL code

---
<br>

## Shader Types:
- Surface Shaders - interacts with lights
- **Unlit Shaders** - has no interaction with unity's lights
- Image Effect Shaders
- Compute shaders

<br>

## ShaderLab
- Mix of 2 languages
- Tells Unity how to render things
- CG Program and CG block for Graphics code to run on GPI
- Properties define shader variables

<br>
Shaders do not use inheritance

---
<br>

![Unlit image](unlit_shader.png)

<br>

![Coordinate image](coordinate.png "Title")