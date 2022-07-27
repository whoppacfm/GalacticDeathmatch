Strict
Global LightList:TList = New TList
Global AmbientLight:Int[3]

Type TLight
	Global BufferScale:Int = 8
	Global BufferImage:TImage = Null
	Global DefaultImage:TImage = Null
	
	Field Image:TImage
	Field X:Float
	Field Y:Float
	Field Color:Int[3]
	Field ScaleX:Float
	Field ScaleY:Float
	Field Alpha:Float
	Field status:Int
	
	Function Create:TLight (_X:Float, _Y:Float, _Color:Int[],_Alpha:Float = 1.0,_ScaleX:Float = 1.0,_ScaleY:Float = 1,_Image:TImage = Null,_status=1)
		Local Light:TLight = New TLight
		Light.X = _X
		Light.Y = _Y
		Light.Color = _Color
		Light.ScaleX = _ScaleX
		Light.ScaleY = _ScaleY
		Light.Alpha = _Alpha
		Light.Image = _Image
		Light.status = _status
		If Not Light.Image
			If Not DefaultImage
				Return Null
			Else
				Light.Image = DefaultImage
			End If
		End If
		LightList.AddLast(Light)
		Return Light
	End Function
	
	Function InitBuffer()
		 BufferImage = CreateImage(GraphicsWidth()/BufferScale, GraphicsHeight()/BufferScale)
		 SetImageHandle BufferImage, 0,0
	End Function
	
	Function UpdateBuffer()
		SetClsColor AmbientLight[0],AmbientLight[1],AmbientLight[2]
		Cls
		Local _Blend:Int = GetBlend()
		SetBlend LightBlend
		For Local Light:TLight = EachIn LightList
		  If light.status=1
			SetAlpha Light.Alpha
			SetColor Light.Color[0],Light.Color[1],Light.Color[2]
			SetScale Light.ScaleX/BufferScale, Light.ScaleY/BufferScale
			DrawImage Light.Image,Light.X/BufferScale, Light.Y/BufferScale
	      EndIf
		Next
		GrabImage(TLight.BufferImage,0,0)
		SetBlend _Blend
		SetColor 255,255,255
		SetScale 1,1
	End Function
	
	Function RenderBuffer()
		Local _Blend:Int = GetBlend()
		Local _SX:Float,_SY:Float
		GetScale _SX, _SY
		SetBlend shadeBlend
		SetScale TLight.BufferScale,TLight.BufferScale
		DrawImage TLight.BufferImage,0,0
		SetBlend _Blend
		SetScale _SX,_SY
	End Function
	
	Function lighton(Light:TLight)
		light.status=1
    End Function   

	Function lightoff(Light:TLight)
		light.status=-1
    End Function 
   
	Function switchstatus(Light:TLight)
		light.status=-light.status
    End Function    

   Function destroylight(Light:TLight)
      ListRemove lightlist,Light
   End Function
 
End Type








'SetGraphicsDriver GLMax2DDriver()
Graphics 640, 480,0

'Import "light.bmx"

AmbientLight = [200,200,200]
TLight.InitBuffer
TLight.DefaultImage = LoadImage("light.png")
MidHandleImage TLight.DefaultImage

Local Light1:TLight = TLight.Create(MouseX(),MouseY(),[255,255,255],1,4,4)

While Not KeyHit (KEY_ESCAPE)

	Light1.X = MouseX()
	Light1.Y = MouseY()

	TLight.UpdateBuffer

	Cls

	'Render your other stuff here
		
	TLight.RenderBuffer

	Flip
	FlushMem
Wend

