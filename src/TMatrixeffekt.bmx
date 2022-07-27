Strict 

TMatrix.ObjectList = New TList 

Type TMatrix

	Global ObjectList:TList 
	
	Field Char:Byte
	Field ListLink:TLink 
	Field x:Float, y:Float
	Field Speed:Float
	Field Size:Int 
	Field CharHeight:Int 
	
	
	Method New()
		self.ListLink = self.ObjectList.AddLAst(Self)
	End Method
	
	
	Method Remove()
		self.ListLink.Remove()
	End Method
	
	
	Function GetInstance:TMatrix(x:Float,y:Float,Speed:Float,Size:Int,Char:Byte)
		Local TempObject:TMatrix = New TMatrix
		TempObject.Char       = Char
		TempObject.x          = x
		TempObject.y          = y
		TempObject.Speed      = Speed
		TempObject.Size       = Size
		TempObject.CharHeight = TextHeight(" ")
		Return TempObject
	End Function


	Function Idle()
		For Local TempObject:TMatrix = EachIn self.ObjectList
			TempObject.Update()
			TempObject.Render()
		Next 
	End Function 	

	
	Method Update()
		self.y:+(GameSpeed*self.speed)
		
		If self.y>GraphicsHeight()+(self.CharHeight*self.Size)
			self.Remove()
		EndIf
		
	End Method
	
	
	Method Render()
	
		SetColor 0,255,0
		SetBlend LIGHTBLEND
		SetScale 1.0,1.0
		For Local i:Int = 0 To self.size
			SetAlpha i/Float(self.size)
			DrawText Chr(self.Char+Rand(-20,20)),self.x,self.y-(i*self.CharHeight)
		Next 
		
	End Method
	
	
End Type




Function GetFPS()
	Global fps,tfps,time
	
	If MilliSecs()-time>1000
		fps = tfps
		tfps = 0
		time = MilliSecs()
	EndIf
	tfps:+1
	Return fps
End Function 



Function GetGameSpeed:Float(Hz:Int)
   Global _LoopTime:Int
   Local Speed:Float
   
   speed = MilliSecs()-_LoopTime
   speed = (Speed/1000.0)*Hz
   _LoopTime = MilliSecs()
   Return Speed
End Function




Graphics 1024,768,32

bglSetSwapInterval(0)

SeedRnd(MilliSecs())


Global GameSpeed:Float 
Local Timer


Repeat
Cls

GameSpeed = GetGameSpeed(60)

If MilliSecs()-Timer>15
	TMatrix.GetInstance(rnd(0,GraphicsWidth()),-1,rnd(2.0,7.0),Rand(5,20),Rand(30,128))
	Timer = MilliSecs()
EndIf


TMatrix.Idle()


SetColor 255,255,255
SetAlpha 1.0
SetBlend MASKBLEND
SetScale 2.0,2.0
DrawText "FPS: "+GetFPS(),10,10


Flip
FlushMem()
Until KeyHit(KEY_ESCAPE)

