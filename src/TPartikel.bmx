
'Partikel-Klasse
'Include "TIniFiles.bmx"

Type TParticle2D
	Field x:Float, y:Float, scale:Float, alpha:Float
	Field vx:Float, vy:Float
	Field speed:Float, angle:Float, scaleDelta:Float, alphaDelta:Float
	Field rot:Float, rotDelta:Float
	Field lastUpdate:Long, updateInterval:Long
	Field r:Int,G:Int,b:Int
'	Field image:Int
	Field image:TImage

	Field blend:Int
	Field active:Int
	Field gravity:Float
	
	Method New()
		r=255
		G=255
		b=255
		scale=1
		alpha=1
		active=0
		gravity=0
		updateInterval=1
		lastUpdate=MilliSecs()
		blend=ALPHABLEND
	End Method
	
	Method update(ax,ay:Int,currTime:Long)
		If currTime-lastUpdate >= updateInterval And active<>0 Then
			vx=(speed*Cos(angle))   
			vy=(speed*Sin(angle))
			vy:+gravity
			'x=ax
			'y=ay
			x:+vx
			y:+vy
			speed = Sqr((vx*vx)+(vy*vy))
			angle = ATan2(vy,vx);			
			scale:+scaleDelta
			If scale<=0 Then scale=0
			alpha:+alphaDelta
			rot:+rotDelta
			lastUpdate=currTime
		EndIf
	End Method
	
	
	
	Method Draw()
		If active<>0 Then
			SetColor(r,G,b)
			SetRotation(rot)
			SetBlend(blend)
			SetScale(scale,scale)
			'SetScale(0.6,0.6)
			SetAlpha(alpha)
			
			If splitscreen = 0 Then
				DrawImage image,x,y
			Else
				'pai einführen
			
				SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()
				DrawImage image,x-viewx,y-viewy
				
				SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()
				DrawImage image,x-viewx2,y-viewy2
				
				SetViewport 0,0, GraphicsWidth(), GraphicsHeight()
			End If
							
			SetColor 255,255,255
			SetRotation 0.0
			SetAlpha 1.0
			SetScale 1.0,1.0
			SetBlend MASKBLEND
		EndIf
	End Method
	
End Type





Type TEmitter2D Abstract
	Field x:Float, y:Float
	Field vx:Float, vy:Float
	Field particleVel:Float
	Field startAngle:Float, endAngle:Float, currAngle:Float, angleDelta:Float
	Field lastEmit:Long, emitInterval:Long
	Field lastUpdate:Long, updateInterval:Long
	Field emitCount=1
	Field pool:TParticle2D[]
	Field lifetime:Int

	Method New()
		emitInterval=1000
		updateInterval=1
		lastUpdate=MilliSecs()
		lastEmit=lastUpdate
		startAngle=0
		currAngle=0
		endAngle=360
		particleVel=1
		'lifetime=100
	End Method
	
	Method FindPoolIndex(start:Int)
		Local Loop:Int
		For Loop=start To pool.length-1
			If pool[Loop].active=0
				Return Loop
			EndIf
		Next
		Return -1
	End Method
	
	Method CreatePool(Count:Int)
		'count = 10
		Local Loop:Int     
		pool = New TParticle2D[Count]
		For Loop=0 To Count-1
			pool[Loop] = CreateParticle()
		Next
		'flushmem()
	End Method
	
	Method Draw()
		Local Loop:Int
		For Loop=0 To pool.length-1
			pool[Loop].Draw()
		Next
	End Method
	
	Method update(currTime:Long)
		Local Loop:Int
		If currTime-lastUpdate >= updateInterval Then
			For Loop=0 To pool.length-1
				pool[Loop].update(x,y,currTime)
			Next
			Move(x+vx,y+vy)
			'x:+vx
			'y:+vy
			lastUpdate=currTime
		EndIf
	End Method
	
	Method Emit(currTime:Long)
		Local r=Rand(50,255)
		Local G=Rand(50,255)
		Local b=Rand(50,255)
		
		If currTime-lastEmit >= emitInterval Then
			Local start=0
			Local Loop
			
			For Loop=0 To emitCount-1
				Local p:TParticle2D = Null
				Local index = FindPoolIndex(start)
				If index<>-1 Then
					start = index
					p = pool[index]
					p.active = 1
					Activate(p)
					p.speed=particleVel
					p.angle=currAngle
					currAngle:+angleDelta
					If currAngle>=endAngle Then currAngle=startAngle
				Else
					start=0
				EndIf
			Next
			lastEmit=currTime
		EndIf
	End Method
	
	Method Deactivate()
		Local w:Int,h:Int,d:Int,hz:Int
		Local Loop:Int
		'GetGraphics(w,h,d,hz)
		w = GraphicsWidth()
		h = GraphicsHeight()
		d = GraphicsDepth()
		hz = GraphicsHertz()
		For Loop=0 To pool.length-1
			If pool[Loop].x > w Or pool[Loop].x < 0 Or  pool[Loop].y > h Or pool[Loop].y < 0 Then
				pool[Loop].active=0
			EndIf
		Next
	End Method
	
	Method MoveParticles(nx:Float,ny:Float)
		Local dx:Float,dy:Float
		dx = nx-x
		dy = ny-y
		Local Loop:Int
		
		For Loop=0 To pool.length-1
			If pool[Loop].active<>0 Then
				pool[Loop].x:+dx
				pool[Loop].y:+dy
			EndIf
		Next
	End Method

	Method Move(nx:Float,ny:Float)
		Local dx:Float,dy:Float
		Local Loop:Int
		dx = nx-x
		dy = ny-y
		For Loop=0 To pool.length-1
			If pool[Loop].active<>0 Then
				pool[Loop].x:+dx
				pool[Loop].y:+dy
			EndIf
		Next
		x:+dx
		y:+dy
	End Method	
	
	Method DoDelta(nx:Float,ny:Float)
		Local Loop:Int
		
		For Loop=0 To pool.length-1
			If pool[Loop].active<>0 Then
				pool[Loop].x:+nx
				pool[Loop].y:+ny
			EndIf
		Next
	End Method
	
	Method CreateParticle:TParticle2D() Abstract
	Method Activate(p:TParticle2D) Abstract
	
End Type






Global kreisimage:TImage = LoadImage("images/kreis1.png")
Global partImage:TImage = LoadImage("images/particle1.png")

'----------------------------------------------------------------------------
'-------------------- Custom Emitter--------- -------------------------------
'----------------------------------------------------------------------------

'global EmImage:TImage

Type TCustomEmitter Extends TEmitter2D
	'Partikeldaten für CreateParticle
	Field imagepath:String
	Field px, py:Int
	Field pUpdateInterval:Int
	Field pAlpha:Float
	Field pAlphaDelta:Float
	Field pBlend:Int
	Field pScale:Float
	Field pScaleDelta:Float
	Field pR,pG,pB:Int
	Field pVx:Int
	
	Field aktiv:Int=0 'emitter ist in partikel-Liste->1 nein->0
	
	Field pImage:TImage=Null
	
	Field pPool:Int
	'-------------------
	
	'Reset-Temp-Variablen
	Field pangleDelta = 0
	Field pemitInterval = 0
	Field pparticleVel = 0
	Field pemitCount = 0
	Field plifetime = 0
	Field pcurrangle = 0
	Field pstartangle = 0
	Field pendangle = 0
	'---------------
	
	
	Method CreateParticle:TParticle2D()
		Local p:TParticle2D = New TParticle2D
		If p.image <> Null Then
			p.image = pImage
		Else
			p.image=LoadImage(imagepath)
		End If
		MidHandleImage(p.image)
				
		p.x = x
		p.y = y
		p.updateInterval=pUpdateInterval
		p.alpha = pAlpha
		p.alphaDelta = pAlphaDelta
		p.blend=pBlend
		p.scale=pScale
		p.scaleDelta=pScaleDelta
		p.vx = pVx
		p.r = pR
		p.G = pG
		p.b = pB
'		FlushMem()
		Return p
	End Method

	
	'Update-Funktion für Emitter die nicht in der Liste stehen	
	Method updateAll(ax,ay,ang:Float)
		x = ax + Cos(ang)*19
		y = ay + Sin(ang)*19
		currAngle = ang
		Emit(MilliSecs())
		update(MilliSecs())
		Draw()
		Deactivate()
	End Method
	'----------------------------------------------------
	
	Method resetEmitter(ax,ay:Int)
		x = ax
		y = ay
		px=x
		py=y
		
		angleDelta = pangleDelta
		emitInterval = pemitInterval 
		particleVel = pparticleVel
		emitCount = pemitCount

		lifetime = plifetime
		currAngle = pcurrangle
		startAngle = pstartangle
		endAngle = pendangle
		resetPool()
		
		'createPool(ppool)
	End Method
		
	
	Method SetColor(ar,ag,ab:Int)
		Local Loop:Int
		'pool = New Particle2D[count]
		For Loop=0 To pPool-1
			pool[Loop].r = ar
			pool[Loop].G = ag
			pool[Loop].b = ab
		Next	
	End Method

	
	Method resetPool()
		Local Loop:Int
		'pool = New Particle2D[count]
		For Loop=0 To pPool-1
			'pool[loop] = CreateParticle()
			pool[Loop].x = x
			pool[Loop].y = y
			pool[Loop].updateInterval=pUpdateInterval
			pool[Loop].alpha = pAlpha
			pool[Loop].alphaDelta = pAlphaDelta
			pool[Loop].blend=pBlend
			pool[Loop].scale=pScale
			pool[Loop].scaleDelta=pScaleDelta
			pool[Loop].vx = pVx
			pool[Loop].r = pR
			pool[Loop].G = pG
			pool[Loop].b = pB
		Next	
	End Method
	
	
	Function createFromFile:TCustomEmitter(filename:String,ax,ay:Int)
		Local CustomEmitter:TCustomEmitter = New TCustomEmitter
		CustomEmitter.x=ax
		CustomEmitter.y=ay
		
		CustomEmitter.angleDelta = Float(Ini_GetValue(filename,"angleDelta","0"))
		CustomEmitter.emitInterval = Float(Ini_GetValue(filename,"emitInterval","0"))
		CustomEmitter.particleVel = Float(Ini_GetValue(filename,"particleVel","0"))
		CustomEmitter.emitCount = Float(Ini_GetValue(filename,"emitCount","0"))
		CustomEmitter.lifetime = Float(Ini_GetValue(filename,"lifetime","0"))
		CustomEmitter.currAngle = Float(Ini_GetValue(filename,"currangle","0"))
		CustomEmitter.startAngle = Float(Ini_GetValue(filename,"startangle","0"))
		CustomEmitter.endAngle = Float(Ini_GetValue(filename,"endangle","0"))
		
		
		'Für Reset
		CustomEmitter.pangleDelta = CustomEmitter.angleDelta
		CustomEmitter.pemitInterval = CustomEmitter.emitInterval 
		CustomEmitter.pparticleVel = CustomEmitter.particleVel
		CustomEmitter.pemitCount = CustomEmitter.emitCount
		CustomEmitter.plifetime = CustomEmitter.lifetime
		CustomEmitter.pcurrangle = CustomEmitter.currAngle
		CustomEmitter.pstartangle = CustomEmitter.startAngle
		CustomEmitter.pendangle = CustomEmitter.endAngle
				
		'Partikel-Vars
		CustomEmitter.imagepath=Ini_GetValue(filename,"image","0")
		CustomEmitter.pUpdateInterval=Float(Ini_GetValue(filename,"updateinterval","0"))
		CustomEmitter.pAlpha=Float(Ini_GetValue(filename,"alpha","0"))
		CustomEmitter.pAlphaDelta=Float(Ini_GetValue(filename,"alphadelta","0"))
		CustomEmitter.pBlend=Float(Ini_GetValue(filename,"blend","1"))
		CustomEmitter.pScale=Float(Ini_GetValue(filename,"scale","0"))
		CustomEmitter.pScaleDelta=Float(Ini_GetValue(filename,"scaledelta","0"))
		CustomEmitter.pR=Float(Ini_GetValue(filename,"r","0"))
		CustomEmitter.pG=Float(Ini_GetValue(filename,"g","0"))
		CustomEmitter.pB=Float(Ini_GetValue(filename,"b","0"))
		CustomEmitter.pVx=Float(Ini_GetValue(filename,"vx","0"))
			
		Local pool1:Int = Int(Ini_GetValue(filename,"CreatePool","0"))
		CustomEmitter.CreatePool(pool1)
		CustomEmitter.pPool = pool1
		Return CustomEmitter
	End Function
	
	
	
	Method Activate(p:TParticle2D)
		p.x = x
		p.y = y
		p.vx = pVx
		p.alpha = pAlpha
		p.alphaDelta = pAlphaDelta
		p.scale = pScale
	End Method
			
	
	
	
	
	
	Function createExplode1:TCustomEmitter(ax,ay:Int)
		Local CustomEmitter:TCustomEmitter = New TCustomEmitter
		CustomEmitter.x=ax
		CustomEmitter.y=ay
									
		CustomEmitter.angleDelta = 0
		CustomEmitter.emitInterval = 0
		CustomEmitter.particleVel = 0
		CustomEmitter.emitCount = 1
		CustomEmitter.lifetime = 30
		CustomEmitter.currAngle = 0
		CustomEmitter.startAngle = 0
		CustomEmitter.endAngle = 0
		
		'Partikel-Vars
		CustomEmitter.pImage = kreisimage
		CustomEmitter.imagepath="images/kreis1.png"
		CustomEmitter.pUpdateInterval=5
		CustomEmitter.pAlpha=1
		CustomEmitter.pAlphaDelta=-0.0350000001
		CustomEmitter.pBlend=4
		CustomEmitter.pScale=0.300000012
		CustomEmitter.pScaleDelta=0.0599999987
		CustomEmitter.pR=0
		CustomEmitter.pG=0
		CustomEmitter.pB=170
		CustomEmitter.pVx=0
			
		Local pool1:Int=3
		CustomEmitter.CreatePool(pool1)
		CustomEmitter.pPool = pool1
		Return CustomEmitter
	End Function
	
	
	Function createExplode2:TCustomEmitter(ax,ay:Int)
		Local CustomEmitter:TCustomEmitter = New TCustomEmitter
		CustomEmitter.x=ax
		CustomEmitter.y=ay
									
		CustomEmitter.angleDelta = 30
		CustomEmitter.emitInterval = 50
		CustomEmitter.particleVel = 0
		CustomEmitter.emitCount = 10
		CustomEmitter.lifetime = 20
		CustomEmitter.currAngle = 0
		CustomEmitter.startAngle = 0
		CustomEmitter.endAngle = 360

		'Partikel-Vars
		CustomEmitter.pImage=partImage
		CustomEmitter.imagepath="images/particle1.png"
		CustomEmitter.pUpdateInterval=5
		CustomEmitter.pAlpha=1
		CustomEmitter.pAlphaDelta=-0.0250000004
		CustomEmitter.pBlend=4
		CustomEmitter.pScale=2.00000000
		CustomEmitter.pScaleDelta=-0.0899999961
		CustomEmitter.pR=255
		CustomEmitter.pG=50
		CustomEmitter.pB=30
		CustomEmitter.pVx=0
			
		Local pool1:Int=15
		CustomEmitter.CreatePool(pool1)
		CustomEmitter.pPool = pool1
		Return CustomEmitter
	End Function
	
	


End Type














'----------------------------------------------------------------------------
'					Feuerwerk 1
'----------------------------------------------------------------------------


Type P2Fireworks1 Extends TEmitter2D
	Method CreateParticle:TParticle2D()
		Local p:TParticle2D = New TParticle2D
		p.image = LoadImage("images/blam.png")
		MidHandleImage(p.image)
		p.x = x
		p.y = y
		p.updateInterval=15
		p.alpha = 1
		p.alphaDelta = Rnd!(-.009,-.01)
		p.rotDelta = 5
		p.blend=LIGHTBLEND
		p.scale=.35
		p.scaleDelta=-.002
		'p.r=Rand(100,255)
		'p.g=Rand(100,255)
		'p.b=Rand(100,255)
'		p.gravity=.05
		Return p
	End Method
	
	Method Activate(p:TParticle2D)
		p.x = x
		p.y = y
		p.alpha = 1
		p.scale=Rnd!(.1,.5)
	End Method
End Type


Rem 
Anwendung:


include "TPartikel2.bmx"
graphics 1024,768

Global ep1:Emitter2D = New P2FireWorks1
ep1.x=400
ep1.y=300
ep1.startAngle=0
ep1.endAngle=360
ep1.currAngle=0
ep1.emitInterval = 950
ep1.particleVel=2.5
ep1.CreatePool(1000)
ep1.emitCount=180
ep1.angleDelta=(360/ep1.emitCount)+1


While Not KeyHit(KEY_ESCAPE)
	Cls
		'SetColor(255,255,255)
		'SetRotation(0)
		'SetBlend(ALPHABLEND)
		'SetScale(.1,.1)
		

			ep1.emitCount=Rand(10,280)
			ep1.angleDelta=(360/ep1.emitCount)+1
			ep1.Emit(MilliSecs())
			ep1.Update(MilliSecs())
			ep1.Draw()
			ep1.Deactivate()
			ep1.x = Rand(50,750)
			ep1.y = Rand(50,350)
			'ep1.MoveParticles(ep1.x+1.5,ep1.y+.5)
	Flip
Wend

end rem 









'----------------------------------------------------------------------------
'					Feuerwerk 2
'----------------------------------------------------------------------------


Type P2Fireworks2 Extends TEmitter2D
	Method CreateParticle:TParticle2D()
		Local p:TParticle2D = New TParticle2D
		p.image = LoadImage("images/gradball.png")
		MidHandleImage(p.image)

		p.x = x
		p.y = y
		p.updateInterval=10'5
		p.alpha = .751
		'p.alphaDelta = rnd!(-.009,-.01)
		p.rotDelta = 5
		p.blend=LIGHTBLEND
		p.scale=.135
		p.scaleDelta=-.0012
		p.r=00
		p.G=00
		p.b=Rand(10,255)
'		p.gravity=.075
		Return p
	End Method
	
	Method Activate(p:TParticle2D)
		p.x = x
		p.y = y
		p.alpha = .751
		'If Rand(100)>75 Then
			'p.r=Rand(10,200)
			'p.g=Rand(10,200)
			'p.b=Rand(10,200)
			p.r = 255
			p.G = 100
			p.b = 0
		'EndIf
		p.scale=Rnd!(.1,.5)
		p.rotDelta = Rand(10)
	End Method
End Type


Rem 
Anwendung:

include "TPartikel2.bmx"
graphics 1024,768


Global ep1:Emitter2D = New P2FireWorks2
ep1.x=400
ep1.y=500
ep1.angleDelta=.51
ep1.startAngle=260
ep1.endAngle=280
ep1.currAngle=260
ep1.emitInterval = 25
ep1.particleVel=8
ep1.CreatePool(6000)
ep1.emitCount=30
'ep1.angleDelta=(360/ep1.emitCount)+1

While Not KeyHit(KEY_ESCAPE)
	Cls
	
			'ep1.emitCount=Rand(10,280)
			'ep1.angleDelta=(360/ep1.emitCount)+1
			ep1.Emit(MilliSecs())
			ep1.Update(MilliSecs())
			ep1.Draw()
			ep1.Deactivate()
			'ep1.x = MouseX()
			'ep1.y = MouseY()
			'ep1.MoveParticles(ep1.x+1.5,ep1.y+.5)
			

	Flip
Wend

end rem 











'----------------------------------------------------------------------------
'					Milchstrasse
'----------------------------------------------------------------------------

Type P2StarStreet Extends TEmitter2D
	Method CreateParticle:TParticle2D()
		Local p:TParticle2D = New TParticle2D
		p.image = LoadImage("images/blam.png")
		MidHandleImage(p.image)
		p.x = x
		p.y = y
		p.updateInterval=15
		p.alpha = .751
		'p.alphaDelta = rnd!(-.009,-.01)
		p.rotDelta = 5
		p.blend=LIGHTBLEND
		p.scale=.35
		p.scaleDelta=-.002
		p.r=00
		p.G=00
		p.b=Rand(10,255)
		p.gravity=.075
		Return p
	End Method
	
	Method Activate(p:TParticle2D)
		p.x = x
		p.y = y
		p.alpha = .751
		If Rand(100)>75 Then
			p.r=50
			p.G=50
		EndIf
		p.scale=Rnd!(.1,.5)
		p.rotDelta = Rand(10)
	End Method
End Type


Rem 
Anwendung:

include "TPartikel2.bmx"
graphics 1024,768

'-> mal mit Bubble Graphik testen -> anderer Effekt!!!

Global ep1:Emitter2D = New P2StarStreet
ep1.x=400
ep1.y=300
ep1.angleDelta=1
ep1.startAngle=165
ep1.endAngle=195
ep1.currAngle=250
ep1.emitInterval = 25
ep1.particleVel=4.5
ep1.CreatePool(3000)
ep1.emitCount=30
'ep1.angleDelta=(360/ep1.emitCount)+1

While Not KeyHit(KEY_ESCAPE)
	Cls
			'ep1.emitCount=Rand(10,280)
			'ep1.angleDelta=(360/ep1.emitCount)+1
			ep1.Emit(MilliSecs())
			ep1.Update(MilliSecs())
			ep1.Draw()
			ep1.Deactivate()
			ep1.x = MouseX()
			ep1.y = MouseY()
			'ep1.MoveParticles(ep1.x+1.5,ep1.y+.5)
	Flip
Wend

end rem 




Rem 
'----------------------------------------------------------------------------
'					Sonne
'----------------------------------------------------------------------------

Type P2Sonne1 Extends Emitter2D
	Method CreateParticle:Particle2D()
		Local p:Particle2D = New Particle2D
		p.image =LoadImage("images/gradball.png")
		MidHandleImage(p.image)
		p.x = x
		p.y = y
		p.updateInterval=5
		p.alpha = 1
		p.alphaDelta = -.005
		p.blend=LIGHTBLEND
		p.scale=2
		p.scaleDelta=-.002
		p.r = 255
		p.g = 100
		p.b = 0
		Return p
	End Method
	
	function create:P2Sonne1(ax,ay:Int)
		local sonne:P2Sonne1 = new P2Sonne1
		sonne.x=ax
		sonne.y=ay
		sonne.angleDelta=15
		sonne.emitInterval = 50
		sonne.particleVel=2
		sonne.CreatePool(1000)
		sonne.emitCount=5
		return sonne
	end function

	method updateAll()
'		x = ax + cos(ang)*19 'antrieb startet hinter raumschiff
'		y = ay + sin(ang)*19
'		currangle = ang
		Emit(MilliSecs())
		Update(MilliSecs())
		Draw()
		Deactivate()
	End Method
	
	Method Activate(p:Particle2D)
		p.x = x
		p.y = y
		p.vx= 1
		p.alpha = 1
		p.scale=2
	End Method
End Type



rem 
Anwendung:

include "TPartikel2.bmx"
graphics 1024,768

Global ep0:Emitter2D = New P2Sonne1
ep0.x=400
ep0.y=300
ep0.angleDelta=15
ep0.emitInterval = 50
ep0.particleVel=2
ep0.CreatePool(1000)
ep0.emitCount=5


While Not KeyHit(KEY_ESCAPE)
	Cls
			ep0.Emit(MilliSecs())
			ep0.Update(MilliSecs())
			ep0.Draw()
			ep0.Deactivate()
			'ep0.MoveParticles(e1.x+1.5,e1.y+.5)

	Flip
Wend
end rem 




























Type TPartikles
	Field exp_list:TList
		
	Function create:TPartikles()
		Local s:TPartikles = New TPartikles
		s.exp_list = CreateList()
		Return s
	End Function
	
	Method AddPartikel(partikel:TCustomEmitter)'Emitter2D)
		partikel.aktiv = 1
		ListAddLast exp_list, partikel
	End Method
	        
	Method updateGo()  'mit Anpassung an Viewspeed
		Local ex:TCustomEmitter 'Emitter2D
		For ex:TCustomEmitter = EachIn exp_list'Emitter2D = EachIn exp_list
			'ex.updateAll()         
			
			ex.DoDelta(-(Cos(viewWinkel+180)*GameManager.FPS_Val(viewSpeed)),-(Sin(viewWinkel+180)*GameManager.FPS_Val(viewSpeed)))
			
			ex.Emit(MilliSecs())
			ex.update(MilliSecs())
			ex.Draw()
			ex.Deactivate()
			
			If ex.lifetime > -5 Then
				ex.lifetime = ex.lifetime - 1
				If ex.lifetime < 0 Then
					ex.aktiv = 0
					ListRemove(exp_list, ex)
					'FlushMem()
				End If
			End If
 		Next
 	End Method
		
	
	
	Method update()
		Local ex:TCustomEmitter 'Emitter2D
		For ex:TCustomEmitter = EachIn exp_list'Emitter2D = EachIn exp_list
			'ex.updateAll()         
			'partikles.DoDelta(-(Cos(viewWinkel+180)*GameManager.FPS_Val(viewSpeed)),-(Sin(viewWinkel+180)*GameManager.FPS_Val(viewSpeed)))
			ex.Emit(MilliSecs())
			ex.update(MilliSecs())
			ex.Draw()
			ex.Deactivate()
			If ex.lifetime > -5 Then
				ex.lifetime = ex.lifetime - 1
				If ex.lifetime < 0 Then
					ex.aktiv = 0
					ListRemove(exp_list, ex)
					'FlushMem()
				End If
			End If
 		Next
 	End Method
End Type

