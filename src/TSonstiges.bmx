
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


Function resetGfx()
	SetRotation 0
	SetScale 1,1
	SetBlend maskblend
	SetAlpha 1
	SetColor 255,255,255
End Function


Function round:Int(Input:Float)
	Return Int(Input+0.5)
End Function
