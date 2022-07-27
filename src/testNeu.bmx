Strict
Framework BRL.D3D7Max2D

Import Indiepath.AnimImageFast
Import Indiepath.ProjMatrix
Import Indiepath.bMapText
Framework BRL.D3D7Max2D

SetGraphicsDriver D3D7Max2DDriver()

' Set the Graphics to whatever you want, the matrix will deal with the scale and position.

Graphics 640,480,0,60
'Graphics 800,600,0,60
'Graphics 1024,768,0,60

'SetMatrix(BaseWidth,BaseHeight,BaseDepth)
SetMatrix(800,600,2)

SetClsColor(80,80,80)
Cls

'bMapText.Create(bitmapname:string,flags)
Local text1:bMapText = bMapText.Create("fatbot",FILTEREDIMAGE|MIPMAPPEDIMAGE)

' TAnimImage(url:object,cell_width,cell_height,Start_frame,NumberFrames,Flags)
Local blob:TAnimImage = TAnimImage.Load("blocks.png", 32, 32, 0, 16, FILTEREDIMAGE)

For Local B=0 To 15
	' This Draw Command is 45% faster than the existing command.
	'Draw(x,y,width,height,frame)
	blob.Draw(5 + (B * 40), 200, 30, 30, B)
Next

SetScale(0.4,0.4)

' DrawbMapText(text:string,x,y,center,right)
text1.DrawbMapText("Indiepath Ltd",400,280,True,False)

SetScale(0.35,0.35)
SetColor(255,255,155)
text1.DrawbMapText("Hit ESC to Exit",400,330,True,False)

Flip

WaitKey()