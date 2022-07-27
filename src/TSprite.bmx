'Sprite-Klasse
'Erstellen und Klonen von frameunabhängigen Sprites
'Christian Merz 15.August 2005


Type TSprite
	' Position
	Field x:Float = 0
	Field y:Float = 0
	
	' Velocity in pixels
	Field velx:Float = 0
	Field vely:Float = 0
	
	' Sprite image
	Field Image:TImage
	
	' Current animation frame
	Field CurAnimFrame:Int = 0
	
	' Width and height of sprite
	Field Width:Int = 0
	Field Height:Int = 0
	
	' Animation frame list
	Field FrameIndices:Int[] = Null
	
	' Animation timer vars
	Field AnimDelay:Int = 0
	Field AnimTime:Int = 1000
	Field CurAnimIndex:Int = 0
	
	' Load sprite
	Method Load(URL:Object, TileWidth:Int, TileHeight:Int, FirstTile:Int, NumTiles:Int)
		' Load image
		Image = LoadAnimImage(URL, TileWidth, TileHeight, FirstTile, NumTiles)
		
		' Save dimensions
		Width = TileWidth
		Height = TileHeight
		
		' Set cur anim frame
		CurAnimFrame = 0
	EndMethod
	
	
	' Clone sprite
	Method Clone:TSprite()
		' Create new copy
		Local NewSprite:TSprite = New TSprite
		
		' Copy pointers to indices/image
		NewSprite.SetFrameIndices(FrameIndices)
		NewSprite.SetImage(Image, Width, Height)
		NewSprite.SetAnimDelay(AnimDelay)
		NewSprite.SetX(x)
		NewSprite.SetY(y)
		NewSprite.SetVelocityX(velx)
		NewSprite.SetVelocityY(vely)
		Return NewSprite		
	EndMethod
	
	
	' Update sprite
	Method Update(DeltaTime:Int)
		' Update movement
		x = x + (velx * DeltaTime)
        y = y + (vely * DeltaTime)

		' Update animation
		If (FrameIndices)
		
			' Increase anim timer
			AnimTime = AnimTime + DeltaTime
			
			' Is it time?
			If (AnimTime > AnimDelay)
			
				' Reset anim time
				AnimTime = 0
				
				' Ok to advance?
				If (CurAnimIndex < (FrameIndices.length-1))	
				
					CurAnimIndex = CurAnimIndex + 1
									
				Else
				
					CurAnimIndex = 0
				
				EndIf
				
				CurAnimFrame = FrameIndices[CurAnimIndex]
			EndIf
		
		EndIf
	EndMethod
	
	
	' Set image
	Method SetImage(Image:TImage, Width:Int, Height:Int)
		self.Image = Image
		self.Width = Width
		self.Height = Height
	EndMethod
	
	
	' Draw sprite
	Method Draw()
		DrawImage(Image, x, y, CurAnimFrame)
	EndMethod
	
	
	' Set current frame
	Method SetCurFrame(Frame:Int)
		CurAnimFrame = Frame
	EndMethod
	
	
	' Set animation delay
	Method SetAnimDelay(NewDelay:Int)
		AnimDelay = NewDelay
	EndMethod
	
	
	' Set frame index list
	Method SetFrameIndices(Indices:Int[])
		FrameIndices = Indices
	EndMethod
	
	
	' Get image for manipulation
	Method GetImage:TImage()
		Return Image
	EndMethod
	
	
	' Set X
	Method SetX(x:Float)
		self.x = x	
	EndMethod
	
	
	' Set Y
	Method SetY(y:Float)
		self.y = y
	EndMethod
	
	
	' Get X
	Method GetX:Float()
		Return x
	EndMethod
	
	
	' Get Y
	Method GetY:Float()
		Return y
	EndMethod
	
	
	' Set x velocity
	Method SetVelocityX(vx:Float)
		velx = vx
	EndMethod
	
	
	' Set y velocity
	Method SetVelocityY(vy:Float)
		vely = vy
	EndMethod

	
	' Get width of sprite
	Method GetWidth:Int()
		Return Width
	EndMethod
	
	
	' Get height of sprite
	Method GetHeight:Int()
		Return Height
	EndMethod		
EndType


REM 
-----------
ANWENDUNG:
------------
Strict 

' Include sprite
Include "TSprite.bmx"

' Set graphics
Graphics 640, 480, 0, -1

' Create and load sprite
Global test:TSprite = New TSprite
test.Load("sprite.png", 64, 64, 0, 4)

' Some timer vars
Global StartTime:Int = MilliSecs()
Global CurTime:Int = StartTime

' List of animation frames
Global Indices:Int[] = [0, 1, 2, 3]

' Set initial velocity
test.SetVelocityX(0.1)
test.SetVelocityY(0.1)

' Set indices and delay between animations
test.SetFrameIndices(Indices)
test.SetAnimDelay(50)

' Create clone
Global test2:TSprite = test.Clone()

' Change velocity in x + position
test2.SetVelocityY(-0.1)
test2.SetX(320)
test2.SetY(240)

' Loop until escape
While Not KeyHit( KEY_ESCAPE )

	' Clear screen
	Cls

	' Calculate delta time
	Local DeltaTime:Int = (MilliSecs() - curTime);
	curTime = curTime + DeltaTime
	
	' Update sprites
	test.Update(DeltaTime)
	test2.Update(DeltaTime)

	' Draw stuff
	test.Draw()
	test2.Draw()
	
	' Test borders (Admitted a loop and a list would be nicer, but this is just a quick test :)
	If (test.GetX() > 640 - test.GetWidth())
	
		test.setVelocityX(-0.1)
	
	EndIf

	If (test.GetX() < 0)
	
		test.setVelocityX(0.1)
	
	EndIf
	
	If (test.GetY() > 480 - test.GetHeight())
	
		test.setVelocityY(-0.1)
	
	EndIf

	If (test.GetY() < 0)
	
		test.setVelocityY(0.1)
	
	EndIf
	
	' Repeate for sprite 2 :)
	If (test2.GetX() > 640 - test2.GetWidth())
	
		test2.setVelocityX(-0.1)
	
	EndIf

	If (test2.GetX() < 0)
	
		test2.setVelocityX(0.1)
	
	EndIf
	
	If (test2.GetY() > 480 - test2.GetHeight())
	
		test2.setVelocityY(-0.1)
	
	EndIf

	If (test2.GetY() < 0)
	
		test2.setVelocityY(0.1)
	
	EndIf


	' Update screen
	Flip

Wend



END REM 


