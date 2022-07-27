     
                
   
Type TSchussart
	Field sID:Int
	Field bezeichnung:String
	
	Field sImagePath:String  
	Field sImageLevelPath:String
	Field simagelevel:TImage
	Field sSoundPath:String
	Field sImage:TImage
	Field sSound:TSound

	Field scalex:Float
	Field scaley:Float
	Field damage:Float
	Field lifetime:Float
	Field speed:Int 
	Field sdelay:Int    
	
	Field startmun:Int
	Field ItemMun:Int
	
	Function Create:TSchussart(sID:Int,bezeichnung:String,sImagePath:String,sSoundPath:String,sImageLevelPath:String,scalex:Float,scaley:Float,damage:Float,lifetime:Int,speed:Int,sdelay:Int,startmun:Int,ItemMun:Int)
		Local schussart:TSchussart = New TSchussart
		schussart.sID = sID
		schussart.bezeichnung = bezeichnung
		schussart.startmun = startmun
		schussart.ItemMun = ItemMun
		schussart.sImagePath = sImagePath
		schussart.sSoundPath = sSoundPath   
		schussart.sImageLevelPath = sImageLevelPath   
		schussart.scalex = scalex
		schussart.scaley = scaley
		schussart.damage = damage
		schussart.lifetime = lifetime
		schussart.speed = speed
		schussart.sdelay = sdelay                  
		If schussart.sImageLevelPath.Trim() <> "" Then
			schussart.simagelevel = LoadImage(schussart.sImageLevelPath)
			MidHandleImage(schussart.simagelevel)
		End If
		schussart.sImage = LoadImage(schussart.sImagePath)
		MidHandleImage(schussart.sImage)
		schussart.sSound = LoadSound(schussart.sSoundPath)
		Return schussart			
	End Function
	
	
	Method ShootMe(x1:Int,Y1:Int,awinkel:Int,ateam:Int,schiff:TShip)
		If sID = 1 Then
			'Laser
			'schussarten[waffe].shoot(x1,y1,mwinkel,team)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*-0, y1+Sin(awinkel)*-0, Self, awinkel, ateam),schiff)
		
		
		Else If sID = 2 Then
			'Powerlaser
			'schussarten[waffe].shoot(x1,y1,mwinkel,team)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*-0-Sin(awinkel)*(-6), y1+Sin(awinkel)*-0+Cos(awinkel)*(-6), Self, awinkel, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*-0-Sin(awinkel)*(6), y1+Sin(awinkel)*-0+Cos(awinkel)*(6), Self, awinkel, ateam),schiff)
		
		
		Else If sID = 5 Then        
			'Flamer                                       
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*-0, y1+Sin(awinkel)*-0, Self, awinkel, ateam),schiff)
			'bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*0-Sin(awinkel)*(-10), y1+Sin(awinkel)*0+Cos(awinkel)*(-10), Self, awinkel, ateam))
			'bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*0-Sin(awinkel)*(-20), y1+Sin(awinkel)*0+Cos(awinkel)*(-20), Self, awinkel, ateam))
		
			'bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*0-Sin(awinkel)*(10), y1+Sin(awinkel)*0+Cos(awinkel)*(10), Self, awinkel, ateam))
			'bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*0-Sin(awinkel)*(20), y1+Sin(awinkel)*0+Cos(awinkel)*(20), Self, awinkel, ateam))
		
		Else If sID = 6 Then
			'Minen
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*40, y1+Sin(awinkel)*40, Self, awinkel, ateam),schiff)
			'bullets.AddBullet(TBullet1.Create(x1, y1, Self, awinkel, ateam))

		Else If sID = 3 Then 
			'Triple Laser
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*-0, y1+Sin(awinkel)*-0, Self, awinkel, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*-0, y1+Sin(awinkel)*-0, Self, awinkel-25, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*-0, y1+Sin(awinkel)*-0, Self, awinkel+25, ateam),schiff)
			'bullets.AddBullet(TBullet1.Create(x1, y1, Self, awinkel, ateam))

		Else If sID = 4 Then
			'Allrounder
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*10, y1+Sin(awinkel)*10, Self, awinkel, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*10, y1+Sin(awinkel)*10, Self, awinkel+90, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*10, y1+Sin(awinkel)*10, Self, awinkel-90, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*10, y1+Sin(awinkel)*10, Self, awinkel+180, ateam),schiff)
			'bullets.AddBullet(TBullet1.Create(x1, y1, Self, awinkel, ateam))

		Else If sID = 7 Then
			'Target Launcher
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*-10, y1+Sin(awinkel)*-10, Self, 361, ateam),schiff) 
			'bullets.AddBullet(TBullet1.Create(x1, y1, Self, awinkel, ateam))

		Else If sID = 8 Then
			'Bullet of Death
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*40, y1+Sin(awinkel)*40, Self, awinkel, ateam),schiff)
			'bullets.AddBullet(TBullet1.Create(x1, y1, Self, awinkel, ateam))

		Else If sID = 9 Then
			'Ultragun
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*10, y1+Sin(awinkel)*10, Self, awinkel, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*10, y1+Sin(awinkel)*10, Self, awinkel+45, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*10, y1+Sin(awinkel)*10, Self, awinkel+90, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*10, y1+Sin(awinkel)*10, Self, awinkel+135, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*10, y1+Sin(awinkel)*10, Self, awinkel-135, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*10, y1+Sin(awinkel)*10, Self, awinkel-90, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*10, y1+Sin(awinkel)*10, Self, awinkel-45, ateam),schiff)
			bullets.AddBullet(TBullet1.Create(x1+Cos(awinkel)*10, y1+Sin(awinkel)*10, Self, awinkel+180, ateam),schiff)

		End If
		
		
		
	End Method
End Type
                      



              

Type TSchussarten
	Field schuesse:TList
	          
    Function Create:TSchussarten()
    	Local gs:TSchussarten = New TSchussarten
    	gs.schuesse = New TList
    	Return gs
    End Function
	
	Method AddSchussart(schussart:TSchussart)
		schuesse.AddLast(schussart)
	End Method
End Type      
         




Type TBullet1
	Field schussArtID:Int
	Field x#
	Field Y#
	Field startx#
	Field starty#
	Field ausloeser:TShip
	
	Field speedx#
	Field speedy#

	Field scale_factorx#
	Field scale_factory#
	
	Field alpha_factor#

	Field winkel#
	Field scalex#
	Field scaley#
	Field angel#
	Field dmg
	Field lifetime
	Field speed#
	Field schussTeam:Int
	'field bullPart:TCustomEmitter
	Field image1:TImage
	Field lifetimer:Int = 0

	Function Create:TBullet1(x1:Float,y1:Float,schussArt:TSchussart, awinkel:Int,aTeam:Int)
	Try
		Local t:TBullet1 = New TBullet1
		t.ausloeser=Null
		t.startx = x1
		t.starty = y1
		t.x# = x1
		t.Y# = y1
		t.winkel# = awinkel
		t.dmg = schussart.damage '1'Rnd(pdmg-10,pdmg)
		t.lifetime = schussArt.lifetime'5000'plifetime
		t.speed# = schussArt.speed'1000'pspeed
		t.schussTeam = aTeam
		t.scalex = schussArt.scalex'0.5
		t.scaley = schussArt.scaley'0.5
		t.schussArtID = schussArt.sID
		t.speedx = 3000
		t.speedy = 3000
		
		t.alpha_factor=1
		
		t.image1 = schussArt.sImage 'LoadImage("images/nebula.png")
		MidHandleImage(t.image1)  'WICHTIG !!!
		
		't.bullpart = TCustomEmitter.createfromfile("partikelini/schuss3.ini",posx,posy)
'		ListAddLast bu_list, t
		Return t
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TBullet1-create)")	
	End Try
	End Function
	
	
	Method GetX:Int()
		Return x-ViewX
	End Method
		
	Method GetY:Int()	
		Return y-ViewY
	End Method

		
	Method GetX2:Int()
		Return x-ViewX2
	End Method
		
	Method GetY2:Int()	
		Return y-ViewY2
	End Method
	
	
	
	Method Draw()
	Try
		If (lifetime > 0) Then 
			SetAlpha 1
			SetBlend LIGHTBLEND
			SetScale scalex,scaley
			SetColor 255,255,255
					
			If schussartid = 6 Then 'Minen
				SetScale 0.7,0.7
				SetBlend alphablend
				If (schussteam = 0) Then
					SetColor 0,0,255
				Else
					SetColor 255,0,0
				End If
				
			Else If schussartid = 8 Then 'Bullet of Death
				SetColor 200,125,125
'				DrawRect getx(),gety()+(scale_factor*5),3,5
				
				SetScale 1,scale_factorx
				'SetScale scale_factorx,scale_factory
								
				SetColor 100,100,100
				SetAlpha alpha_factor
									
				SetRotation winkel-90	
				If ausloeser <> Null Then
					If splitscreen = 0 Then
						DrawRect (startx-viewx)+Cos(winkel)*(-50-GameManager.FPS_Val(ausloeser.speed*12)) - Sin(winkel)*+1, (starty-viewy)+Sin(winkel)*(-50-GameManager.FPS_Val(ausloeser.speed*12)) + Cos(winkel)*+1, 2, 5
					Else
						SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()												
						DrawRect (startx-viewx)+Cos(winkel)*(-50-GameManager.FPS_Val(ausloeser.speed*12)) - Sin(winkel)*+1, (starty-viewy)+Sin(winkel)*(-50-GameManager.FPS_Val(ausloeser.speed*12)) + Cos(winkel)*+1, 2, 5
						SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()				
						DrawRect (startx-viewx2)+Cos(winkel)*(-50-GameManager.FPS_Val(ausloeser.speed*12)) - Sin(winkel)*+1, (starty-viewy2)+Sin(winkel)*(-50-GameManager.FPS_Val(ausloeser.speed*12)) + Cos(winkel)*+1, 2, 5
						SetViewport 0,0, GraphicsWidth(), GraphicsHeight()				
					
					End If			
				Else
					'DrawRect (startx-viewx)+Cos(winkel)*(-30), (starty-viewy)+Sin(winkel)*(-30), 3, 5
				End If
				SetRotation 0

				SetScale 1,1
				SetAlpha 1
				
				scale_factorx:-GameManager.FPS_Val(speed#/4)
				'scale_factorx = scale_factorx - Cos(winkel) * GameManager.FPS_Val(speed#)
				'scale_factory = scale_factory - Sin(winkel) * GameManager.FPS_Val(speed#)

				alpha_factor:-0.03			
			End If
						
			
			'setrotation x*y
			SetRotation 0

			'drawimage image1,getx()+cos(winkel)*19,gety()+sin(winkel)*19

			If splitscreen = 0 Then
				DrawImage image1,GetX(),GetY()
			Else
				SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()												
				DrawImage image1,GetX(),GetY()		
				SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()				
				DrawImage image1,GetX2(),GetY2()		
				SetViewport 0,0, GraphicsWidth(), GraphicsHeight()				
			End If
			
			
			'kollision mit level
			
			'If CollideImage(image1,GetX(),GetY(),0,1,0) Then
			If CollideImage(image1,X,Y,0,1,0) Then
				lifetime=0
				'If (GetX() > 0) And (GetX() < gfxOptions.gw) And (GetY() > 0) And (GetY() < gfxOptions.gh) Then
				If (x > 0) And (x < gfxOptions.gw) And (y > 0) And (y < gfxOptions.gh) Then
					miniexplo.resetEmitter(GetX(),GetY())
					partiklesover.addpartikel(miniexplo)
				End If
			End If
			
			
		End If
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TBullet1-draw)")	
	End Try
	End Method
		
	
	Method getlife()
		Return lifetime
	End Method
				
			
	Method checkCollision(shiplist:TList) 'kollision mit gegnern
	Try
		Local sh:TShip
		For sh:TShip = EachIn shiplist
			If sh<>Null Then
				'If sh.x# - 7 < x# And sh.x# + 7 > x# And sh.y# - 7 < y# And sh.y# + 7 > y# And sh.team <> nummer Then sh.takedmg(dmg) ; lifetime = 0
				'If sh.getX() - 50 < x And sh.getX() + 50 > x And sh.getY() - 50 < y And sh.getY() + 50 > y And sh.team <> nummer Then sh.takedmg(dmg) ; lifetime = 0

'				setcolor 255,0,0
'				DrawText ("GetX:" + sh.GetX()+ "                         BX:" + x ,400,100)
				If (lifetime > 0) Then
					'hier
					
					
					'If (GetX() > sh.GetX()-sh.width/2) And (GetX() < sh.GetX()+sh.width/2) And (GetY() > sh.GetY()-sh.width/2) And (GetY() < sh.GetY()+sh.width/2) And (sh.dead=0) And (sh.team <> schussTeam)
					If (X > sh.X-sh.width/2) And (X < sh.X+sh.width/2) And (Y > sh.Y-sh.width/2) And (Y < sh.Y+sh.width/2) And (sh.dead=0) And (sh.team <> schussTeam)

					
					'if (x > sh.x-100) and (x < sh.x+100) and (y > sh.y-100) and (y < sh.y+100) And (sh.team <> nummer)					
						'explosions.AddExplosion (TExplosion.create(sh.x,sh.y))
						Local iview = sh.inViewport()
						If iview=1 Then
							playeffect damage
						End If

						'Deathmatch:  verhindern dass bei zwei geschossen zwei frags angerechnet werden
						If (sh.dead = 0) And (sh.life > 0) And (sh.damagecheck(dmg)=0) Then
						
							'sh.dead = 0
							'sh.life > 1
							'sh.life - dmg < 1
								
							sh.DeathmatchDies:+1
							ausloeser.DeathmatchFrags:+1
						End If
						
						sh.eingesteckterSchaden:+dmg
						ausloeser.ausgeteilterSchaden:+dmg

						sh.takedmg(dmg)
						sh.checkdead()
						
						lifetime = 0			
					End If
				End If
			End If
		Next
		
		
		'Collision mit Level
		Rem 
		local ti:TTile
		For ti:TTile = EachIn arena1.tilesG
			if imagescollide2(ti.image,ti.tx-viewx,ti.ty-viewy,ti.aframe,ti.rotation,ti.scaleX,ti.scaleY, image1, getx(), gety(), 0, winkel, scalex, scaley) then
				'kleine explo
				if (getx() > 0) and (getx() < gw) and (gety() > 0) and (gety() < gh) then
					miniexplo.resetEmitter(getx(),gety())
					partikles.addpartikel(miniexplo)
				end if
				lifetime=0
			end if
		next	
		end rem	
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TBullet1-checkCollision)")	
	End Try
	End Method

			
			
			
	Method Update()
	Try

'		local x1 = ax + cos(awinkel) * 100 + sin(awinkel) * 0
'		local y1 = ay + cos(awinkel) * 0 + sin(awinkel) * 100
		'x# = x# - Cos(winkel#) * speed# +sin(Winkel) * 10
		'y# = y# - cos(winkel#) * 10 +  Sin(winkel#) * speed#

		If ausloeser <> Null And winkel=361 Then ' zielsucher
			Local suchwinkel:Float = ausloeser.getfeindwinkel()
			If ausloeser.meinfeind <> Null Then
				suchwinkel = ATan2(ausloeser.meinfeind.y - ausloeser.y, ausloeser.meinfeind.x - ausloeser.x)
			End If		
			x# = x# + Cos(suchwinkel#) * GameManager.FPS_Val(speed#)
			Y# = Y# + Sin(suchwinkel#) * GameManager.FPS_Val(speed#)

'			speedx# = GameManager.FPS_Val(speedx#) * 0.98 + Cos(suchwinkel#) * GameManager.FPS_Val(speed)
'			speedy# = GameManager.FPS_Val(speedy#) * 0.98 + Sin(suchwinkel#) * GameManager.FPS_Val(speed)

'			x = x + speedx
'			y = y + speedy
			
			'->Rocket-Test
'			Local winkel2:Float=0
				
'			suchwinkel = ATan2(m.TargetY - m.Y , m.TargetX - m.X)
			'winkel2 = ATan2((y + speedy) - y , (x + speedx) - x)
		
'			speedx = speedx * 0.980 + speed * Cos(suchwinkel)
'			speedy = speedy * 0.980 + speed * Sin(suchwinkel)

'			x :- speedX
'			y :- speedY
			'<-Rocket-Test
		Else
			x# = x# - Cos(winkel#) * GameManager.FPS_Val(speed#)
			Y# = Y# - Sin(winkel#) * GameManager.FPS_Val(speed#)
		End If
		
		
		
'		SetRotation(winkel2)
'			SetColor 0,0,255 ; DrawRect m.X,m.Y,24,12
'			SetHandle(-16,-2)
'			SetColor 255,0,0 ; DrawOval m.X,m.Y,8,8
'			SetHandle(0,0)
'		SetRotation(0)
			
			
		
		
		'If x# > GH Then x# = 0
		'If x# < 0 Then x# = GH
		'If y# > GW Then y# = 0
		'If y# < 0 Then y# = GW
'		speed = speed + 0.1
		'stopuhr   
		
		'lifetime = Reichweite

		If lifetime <> 30000 Then  '30000 = unsterblich
			If (Sqr((x-startx)*(x-startx)) + Sqr((y-starty)*(y-starty))) > lifetime Then
				lifetime = 0
			End If
		End If		
				
		
		'If lifetimer = 0 Then
		'	lifetimer = MilliSecs()
		'Else
		'	If MilliSecs() > lifetimer+500 Then 
		'		lifetimer = 0
		'		lifetime = 0
		'	End If
		'End If
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TBullet1-update)")	
	End Try
	End Method
End Type

                     



Type TBullets
	Field bu_list:TList
	
	Function Create:TBullets()
	Try
		Local s:TBullets = New TBullets
		s.bu_list = CreateList()
		Return s
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TBullets-create)")	
	End Try
	End Function
	
	Method Clear()
		bu_list.clear()	
	End Method
	
	Method AddBullet(bullet:TBullet1,sh:TShip)
	Try
		bullet.ausloeser = sh
		ListAddLast bu_list, bullet
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TBullets-addBullet)")	
	End Try
	End Method

		
	Method Update()
	Try
		Local bu:TBullet1
		For bu:TBullet1 = EachIn bu_list
			If bu<>Null Then
				bu.checkCollision(aktuellerLevel.gegner.sh_list)
				bu.Update()
				bu.Draw()
				If bu.getlife() <= 0 Then
					ListRemove(bu_list, bu)
					'FlushMem()
				End If
			End If
 		Next
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TBullets-update)")	
	End Try
	End Method
End Type
