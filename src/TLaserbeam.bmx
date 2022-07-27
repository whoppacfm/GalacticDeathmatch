'SetGraphicsDriver GLMax2DDriver()

Local lastTime:Float=MilliSecs()
Local timeNow:Float=lastTime
Local timeConstant:Float

Local powerTime:Float
Local alphaTime:Float

Graphics 640,480,0

SetBlend ALPHABLEND


While Not KeyHit(KEY_ESCAPE)
	
	'Calculate a time constant so program runs at equal speed on all PCs
	timeNow=MilliSecs()
	timeConstant=(timeNow-lastTime)/100
	lastTime=timeNow
	
	'Depending on how much we add to powerTime and alphaTime, the speed at which the laser changes strength will vary
	'The laser's "power" is how quickly it changes from coloured (at the edge) to white (in the middle).
	'By using SetAlpha before calling drawLaser, we can make the width of the beam appear to change over time, since
	'the edge of the beam becomes transparent at a lower alpha level than the centre of the beam.
	powerTime :+ timeConstant*20
	alphaTime :+ timeConstant*40
	
	SetColor 20,200,20
	SetAlpha 0.1+Abs(Sin(alphaTime)*0.35)
	drawLaser(10,10,300,300,20,0.25+Abs(Sin(powerTime)*0.75))
	drawlaser 100,100,200,200,20,0.25+Abs(Sin(powerTime)*0.75)
		
	Flip
	Cls
	PollSystem
	
Wend

'Creates a laser effect by drawing a whole series of lines, starting at the specified width and working down
'towards a line only a pixel wide.  Each time it draws a line it brightens the colour, which makes the centre 
'appear hotter.
Function drawLaser(x1,y1,x2,y2,width:Float,power:Float)

	Local initialWidth:Float=width
	

	While (width > 0)
		SetLineWidth width
		
		
		DrawLine x1,y1,x2,y2,False
	
		
		Local r,g,b
		GetColor(r,g,b)
		
		SetColor(Min(r+(20*power),255),Min(g+(20*power),255),Min(b+(20*power),255))
		
		width :- 1
	End While

End Function

