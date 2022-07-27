
Graphics 1024,768


Global counter = CountGraphicsModes()

While Not KeyHit(KEY_ESCAPE)
	Cls
	Local i
	Local k
	Local j
	For i = 0 To counter - 1
		Local w
		Local h
		Local d
		Local hertz
		GetGraphicsMode(i,w,h,d,hertz)
		
		DrawText(w + "x" + h + "  " + d + "bit" + "  " + hertz + "Hz",10+j*200,10+k*30) 
		k:+1
		
		If k = 30 Then 
			k = 0
			j :+1
		End If
	Next
	
	Flip
Wend

