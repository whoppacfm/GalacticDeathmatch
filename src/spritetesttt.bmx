Strict 

' Include sprite
Include "TSprite.bmx"

' Set graphics
Graphics 1024, 768, 0, -1

' Create and load sprite
Global test:TSprite = New TSprite
test.Load("ufo.png", 100, 75, 0, 7)
'test.Load("sprite.png", 64, 64, 0, 4)


' Some timer vars
Global StartTime:Int = MilliSecs()
Global CurTime:Int = StartTime

' List of animation frames
Global Indices:Int[] = [0, 1, 2, 3,4,5,6]

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

