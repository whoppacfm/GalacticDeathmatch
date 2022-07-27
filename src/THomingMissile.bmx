Graphics 640,480,0,70

Global LMissile:TList=New TList
Type TMissile
	Field x#,y# Field Velx#,Vely# Field Angle#,Drag#=0.980,Speed#=0.1 Field TargetX,TargetY
	Field Life Field angle2#
End Type

'=====================================

Repeat ; Cls
	
	UpdateMissile()
	
	If MouseHit(1)=True Then  MakeMissile()
	
	DrawOval 320-8,240-8,16,16
	DrawText "Target 1",32,32
	DrawText "Target 2",32,440
	
FlushMem() ; Flip ; Until KeyDown(KEY_ESCAPE)=True ; End

'=====================================

Function UpdateMissile()

	For m:TMissile = EachIn LMissile
		
		m.angle = ATan2(m.TargetY - m.Y , m.TargetX - m.X)
		
		m.angle2 = ATan2((m.Y+m.VelY) - m.Y , (m.X+m.VelX) - m.X)
		
		m.Velx=m.Velx * m.Drag + m.Speed * Cos(m.angle)
		m.Vely=m.Vely * m.Drag + m.Speed * Sin(m.angle)

		m.X:+m.VelX
		m.Y:+m.VelY
		
		SetRotation(m.angle2)
			SetColor 0,0,255 ; DrawRect m.X,m.Y,24,12
			SetHandle(-16,-2)
			SetColor 255,0,0 ; DrawOval m.X,m.Y,8,8
			SetHandle(0,0)
		SetRotation(0)
		
		If MilliSecs()>m.Life Then ListRemove(LMissile,m)
	Next

End Function

'=====================================

Function MakeMissile()

	m:TMissile = New TMissile
	ListAddLast(LMissile,m)
		m.x		= 320
		m.y		= 240
		m.Velx		= 4
		m.Vely		= 4
		m.Life		= MilliSecs()+3000
		m.TargetY	= MouseY()
		m.TargetX	= MouseX()

End Function

