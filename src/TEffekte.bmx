'Spezialeffekte Blitzmax
'Christian Merz 2005



'Strict
'Graphics 1024,768

type TSchlange
  field bobImage:TImage
  field maxbobs:Int = 256 
  field bobx:Int[maxbobs] 
  field boby:Int[maxbobs]
  field bobXadd:int = 1 
  field bobYadd:int = 2 
  field bobXpos:int = 200
  field bobYpos:int = 200
  field bobWidth:int = 40
  field bobHeight:int = 40
  global bobUpdate:Int
    
  function create:TSchlange(url:string)
    local schlange:TSchlange = new TSchlange
    local i:Int
	schlange.bobImage = loadimage(url)
	MidHandleImage schlange.bobImage
	For i = 0 To schlange.maxbobs-1
	  schlange.bobx[ i ] = i * 5 Mod 360 ' space the positions out a little
      schlange.boby[ i ] = i * 4 Mod 360 ' using Mod to keep the numbers between 0 and 360
	Next
	Return schlange
  End Function
   
  method draw()
	SetBlend LIGHTBLEND
  	local i:Int
  	For i = 0 To maxbobs-1
	  DrawImage bobImage, bobXpos + Sin( bobx[i] ) * bobWidth, bobYpos + Sin( boby[i] ) * bobHeight
	Next

	'If MilliSecs() > bobUpdate+ 15 Then ' here we find the next position of the bobs
	  'bobUpdate= MilliSecs()
	  For i = 0 To maxbobs-1
	    bobx[i] = bobx[i] + bobXadd Mod 360
        boby[i] = boby[i] + bobYadd Mod 360
	  Next
   ' End If
   	SetBlend SOLIDBLEND
  End Method

End type

rem 
local s:TSchlange = TSchlange.Create("sphere.png")
While Not KeyHit(KEY_ESCAPE)
  Cls
  s.draw 
  Flip
Wend
End
end rem 




type TBlob2D
	field ballsize:Int=80
	field ballsizehalf:Int=ballsize/2
	field balldivider:Float
	field lineardivider:Float
	field img:TImage

	function create:TBlob2D(blobsize:int=80)
		Local m:TBlob2D = New TBlob2D
		m.ballsize = blobsize
		m.ballsizehalf=m.ballsize/2
		If m.ballsize<100 Then m.balldivider=32
		If m.ballsize=128 Then m.balldivider=64 
		If m.ballsize=256 Then m.balldivider=256 
		If m.ballsize>511 Then m.balldivider=1024 
		If m.ballsize<100 Then m.lineardivider=0.2
		If m.ballsize=128 Then m.lineardivider=0.5
		If m.ballsize=256 Then m.lineardivider=1
		If m.ballsize>511 Then m.lineardivider=2
		return m
	End Function
	
	method render()
		For Local r:Float=1 To ballsize-1 Step 0.5
			Local level:Float=r
			level:*level
			level=level/balldivider
			SetColor level,level,level 'For blobby gradient shape
			'SetColor r/lineardivider,r/lineardivider,r/lineardivider 'For linear gradients
			DrawOval r/2,r/2,ballsize-r,ballsize-r
		Next

		AutoMidHandle True 'Schwerpunkt aller Images liegt im Mittelpunkt
		img=CreateImage(ballsize,ballsize,1,FILTEREDIMAGE)
		GrabImage(img,0,0,0)
'		SetBlend LIGHTBLEND 'Pixel werden zum Backbuffer addiert
	end method

	method draw(x,y:Int)
		SetBlend LIGHTBLEND
		DrawImage img,x,y
		SetBlend SOLIDBLEND
	End Method
end type

rem 
'Use TBlob2D
	'Set up the display
	Graphics 800,600,0
	Cls

	local h:TBlob2D = TBlob2D.create(80)
	h.render
	hidemouse
	
	Repeat
		Cls
		h.draw(400,300)
		h.draw(MouseX(),MouseY())
		'DrawImage img,400,300
	'	DrawImage img,MouseX(),MouseY()
		Flip
	Until KeyHit(KEY_ESCAPE)
'End of Example
end rem 








