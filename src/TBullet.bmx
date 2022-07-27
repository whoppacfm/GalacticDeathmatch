Strict

Graphics 800,600,0


'AutoMidHandle True



Type TBullet
	Field x#
	Field y#
	Field origin_x#
	Field origin_y#
	Field scale_factor#
	Field alpha_factor#
	global bulletimage:TImage
		
	Field life#
	
	function create:TBullet()
		local bullet:TBullet = new TBullet
		bullet.bulletimage = CreateImage(16,16,DynamicImage|MaskedImage)
		DrawRect 0,0,3,10
		GrabImage bulletimage,0,0	
		
		bullet.life = 100
		bullet.alpha_factor=1
		bullet.x = MouseX()
		bullet.y = MouseY()
		Bullet.origin_x = bullet.x
		Bullet.origin_y = bullet.y
		
		'bullet.bulletList = CreateList()
		
		return bullet
	End Function
		
	Method draw()
		SetColor 200,125,125
		DrawRect x,y+(scale_factor*5),3,5
		SetScale 1,scale_factor
		SetColor 100,100,100
		SetAlpha alpha_factor		
		DrawRect origin_x,origin_y,3,5
		SetScale 1,1
		SetAlpha 1
	End Method
	
	Method update()
		y:-1
		life:-1
		scale_factor:-3
		alpha_factor:-0.03
		'If(alpha_factor <0) ListRemove bulletList,Self
	End Method
	
End Type








Cls
SetColor 200,200,200
SetBlend(alphablend)

global bulletList:TList
bulletList = CreateList()

Function UpdateBullets()
	For Local b:Tbullet = EachIn bulletList
      b.Draw()	
	  b.Update()
	  If(b.alpha_factor <0) ListRemove bulletList,b
	Next 
End Function



While Not KeyDown(KEY_ESCAPE)
	SetScale 1,1
	SetAlpha 1
	If KeyHit(KEY_SPACE)
		Local mybullet:TBullet = TBullet.create()
		bulletList.addLast(mybullet)
	End If
		
	UpdateBullets()		
		
	Flip
	Cls
Wend

FlushMem
End

