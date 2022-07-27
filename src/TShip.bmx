
               
'Maussteuerungs-Test
Global MouseXSpeed:Int
Global MouseYSpeed:Int


'ZoomTest mit +/-
Global mainscale:Float = 1
                                  



'explosion für Schuss/Levelstruktur       
Global miniexplo:TCustomEmitter = TCustomEmitter.createFromFile("partikelini/miniexplo.ini",0,0)
                   

Type TPunkt
	Field x:Int
	Field y:Int
	
	Function Create:TPunkt(x,y)
		Local pu:TPunkt = New TPunkt
		pu.x = x
		pu.y = y
		Return pu
	End Function
End Type


Type TEffektpositionen
	Field MuendungHo:Int
	Field MuendungVert:Int
	Field SchildHo:Int
	Field SchildVert:Int
	Field AntriebVert:Int
	Field AntriebHo:Int
	
	Function Create:TEffektpositionen()
		Local parPos:TEffektpositionen = New TEffektpositionen
		'parPos.MuendungHo = MuendungHo
		'parPos.MuendungVert = MuendungVert
		'parPos.SchildHo = SchildHo
		'parPos.SchildVert = SchildVert
		'parPos.AntriebVert = AntriebVert
		Return parPos
	End Function
End Type	
	    
	      
Type TGleiters
	Field gleiters:TList
	
	          
	Method GetGleiterByID:TGleiter(id:Int)
		Local gl:TGleiter
		For gl:TGleiter = EachIn gleiters
			If gl.gleiterid = id Then 	
				Return gl
			End If
		Next
		Return Null
	End Method
		
	
    Function Create:TGleiters()
    	Local gs:TGleiters = New TGleiters
    	gs.gleiters = New TList
    	Return gs
    End Function
	
	Method AddGleiter(gleiter:TGleiter)
		gleiters.AddLast(gleiter)
	End Method
End Type
    
	
	
Type TGleiter   
	Field bezeichnung:String
	Field life:Float
	Field maxspeed:Int
	Field winkelSpeed:Int	
	Field ImagePath:String  
	Field imagePathMenu:String 
	Field imageMenu:TImage    
	Field EffektPositionen:TEffektpositionen 
	Field gleiterID:Int

	Function Create:TGleiter(gleiterID:Int,bezeichnung:String,ImagePath:String,imagePathAnim:String,life:Float,maxspeed,winkelSpeed)
		Local gleiter:TGleiter = New TGleiter
		gleiter.bezeichnung = bezeichnung
		gleiter.life = life     
		gleiter.maxspeed = maxspeed
		gleiter.winkelSpeed = winkelSpeed
		gleiter.ImagePath=ImagePath   
		gleiter.imagePathMenu=imagepathanim
		gleiter.imageMenu = LoadImage(gleiter.imagePathMenu)
		gleiter.EffektPositionen = TEffektpositionen.Create()
        gleiter.gleiterID = gleiterID
        
'gleiterSammlung.AddGleiter(TGleiter.Create(0,"Scout","incbin::finalscout.png","incbin::scout.png",100,200,150))
'gleiterSammlung.AddGleiter(TGleiter.Create(1,"Ice Tiger","incbin::icetigerfinal.png","incbin::icetiger.png",120,900,400))
'gleiterSammlung.AddGleiter(TGleiter.Create(2,"Monster Bat","incbin::finalshark.png","incbin::shark.png",160,260,220))
'gleiterSammlung.AddGleiter(TGleiter.Create(3,"Devil","incbin::finaldevil.png","incbin::devil.png",200,300,250))
'gleiterSammlung.AddGleiter(TGleiter.Create(4,"Beast","incbin::finalfish.png","incbin::daemon.png",220,330,280))
'gleiterSammlung.AddGleiter(TGleiter.Create(5,"Battle Shuttle","incbin::finalshuttle.png","incbin::shuttle.png",250,360,300))
		
		If gleiterID = 5 Then 'Scout
			gleiter.EffektPositionen.AntriebVert = -15 
			gleiter.EffektPositionen.AntriebHo = -1
			gleiter.EffektPositionen.MuendungHo = -2
			gleiter.EffektPositionen.MuendungVert = -17
			gleiter.EffektPositionen.SchildHo = 1
			gleiter.EffektPositionen.SchildVert = -10
		Else If gleiterID = 1 Then  'Ice Tiger
			gleiter.EffektPositionen.AntriebVert = -15
			gleiter.EffektPositionen.AntriebHo = 0
			gleiter.EffektPositionen.MuendungHo = 0
			gleiter.EffektPositionen.MuendungVert = -17
			gleiter.EffektPositionen.SchildHo = 1
			gleiter.EffektPositionen.SchildVert = -10
        Else If gleiterID = 2 Then  'Monster Bat
			gleiter.EffektPositionen.AntriebVert = -15
			gleiter.EffektPositionen.AntriebHo = 1
			gleiter.EffektPositionen.MuendungHo = 1
			gleiter.EffektPositionen.MuendungVert = -17
			gleiter.EffektPositionen.SchildHo = 1
			gleiter.EffektPositionen.SchildVert = -10
        Else If gleiterID = 3 Then  'Devil
			gleiter.EffektPositionen.AntriebVert = -10
			gleiter.EffektPositionen.AntriebHo = 1
			gleiter.EffektPositionen.MuendungHo = 1
			gleiter.EffektPositionen.MuendungVert = -17
			gleiter.EffektPositionen.SchildHo = 1
			gleiter.EffektPositionen.SchildVert = -10
        Else If gleiterID = 4 Then  'Beast
			gleiter.EffektPositionen.AntriebVert = -15 
			gleiter.EffektPositionen.AntriebHo = 1
			gleiter.EffektPositionen.MuendungHo = 1
			gleiter.EffektPositionen.MuendungVert = -17
			gleiter.EffektPositionen.SchildHo = 1
			gleiter.EffektPositionen.SchildVert = -10
        Else If gleiterID = 0 Then  'Battle Shuttle
			gleiter.EffektPositionen.AntriebVert = -15 
			'gleiter.EffektPositionen.AntriebHo = 1
			gleiter.EffektPositionen.AntriebHo = 6

			'gleiter.EffektPositionen.MuendungHo = 1
			gleiter.EffektPositionen.MuendungHo = 6

			gleiter.EffektPositionen.MuendungVert = -19
			'gleiter.EffektPositionen.SchildHo = 1
			gleiter.EffektPositionen.SchildHo = 6

			gleiter.EffektPositionen.SchildVert = -8
	
		'Drohnen
        Else If (gleiterID = 6) Then
			gleiter.EffektPositionen.AntriebVert = -12 
			gleiter.EffektPositionen.AntriebHo = 0
			gleiter.EffektPositionen.MuendungHo = 1
			gleiter.EffektPositionen.MuendungVert = -17
			gleiter.EffektPositionen.SchildHo = 1
			gleiter.EffektPositionen.SchildVert = -10
 


		Else If (gleiterID = 7) Or (gleiterID = 9) Or (gleiterID = 10) Or (gleiterID = 11) Then 'Drone1
			gleiter.EffektPositionen.AntriebVert = -15
			gleiter.EffektPositionen.AntriebHo = -1
			gleiter.EffektPositionen.MuendungHo = -2
			gleiter.EffektPositionen.MuendungVert = -17
			gleiter.EffektPositionen.SchildHo = 1
			gleiter.EffektPositionen.SchildVert = -10
'		Else If gleiterID = 7 Then 'Drone2
'			gleiter.EffektPositionen.AntriebVert = -15 
'			gleiter.EffektPositionen.AntriebHo = -1
'			gleiter.EffektPositionen.MuendungHo = -2
'			gleiter.EffektPositionen.MuendungVert = -17
'			gleiter.EffektPositionen.SchildHo = 1
'			gleiter.EffektPositionen.SchildVert = -10
		
			
		Else If gleiterID = 8 Then 'Station1
			gleiter.EffektPositionen.AntriebVert = -15 
			gleiter.EffektPositionen.AntriebHo = -1
			
			gleiter.EffektPositionen.MuendungHo = -2
			gleiter.EffektPositionen.MuendungVert = -17
			
			gleiter.EffektPositionen.SchildHo = 60
			gleiter.EffektPositionen.SchildVert = 55

        Else If gleiterID = 12 Then  'Devil
			gleiter.EffektPositionen.AntriebVert = -6
			gleiter.EffektPositionen.AntriebHo = 1
			gleiter.EffektPositionen.MuendungHo = 1
			gleiter.EffektPositionen.MuendungVert = -17
			gleiter.EffektPositionen.SchildHo = 1
			gleiter.EffektPositionen.SchildVert = -10
		
        Else If gleiterID = 14 Or gleiterID = 15 Then  'Tower1,2
			gleiter.EffektPositionen.AntriebVert = -6
			gleiter.EffektPositionen.AntriebHo = 1
			gleiter.EffektPositionen.MuendungHo = -7
			gleiter.EffektPositionen.MuendungVert = -32
			gleiter.EffektPositionen.SchildHo = -7
			gleiter.EffektPositionen.SchildVert = 0
		
				
		End If
		
		Return gleiter
	End Function
End Type
   
    


Type TShip 

	Field goMWinkel:Int
	Field superToWinkel:Int
	
	Field winkelspeed:Int
	Field urlife:Int
	
	Field autoSpawn:Int
    Field gleiter:TGleiter                      
	Field dahinter:Int = 0
	Field boosterEnergie:Float = 0
		
	'Variablen um Animation einzuladen
	Field MaxStandAnim:Int 'Max Index der Standanimation
	Field StartLinks:Int 'Start Index der Linksflug-Animationen
	Field StartRechts:Int 'Start Index der Rechtsflug-Animationen
	Field EndLinks:Int 'End Index Linksflug-Animationen
	Field EndRechts:Int 'End Index Rechtsflug-Animationen
	Field Direction:Int '0=normal, 1=links, 2=rechts
	Field Antrieb:TCustomEmitter
	Field explode1:TCustomEmitter
	Field explode2:TCustomEmitter
	Field erscheinung:TCustomEmitter
	Field muendungsfeuer:TCustomEmitter
	
	Field shoottimer:Int = 0
		
	Field x#=-100
	Field Y#=-100     
	Field startX#
	Field startY#
	Field winkel#
	Field name:String

	Field life
'	Field entity
	Field speed#

	
	'Wegfindung
	Field GeheWeg:TPosition[]
	Field PNow:Int 'index für aktuelle position
	Field ASternZeit:Int
	'----------------
	
	
	Field mwinkel#
	Field _KU = KEY_UP
	Field _KD = KEY_DOWN
	Field _KS = KEY_SPACE
	Field _KR = KEY_RIGHT
	Field _KL = KEY_LEFT
	
	'KI
	Field weg# = 0
	Field tox# = 0
	Field toy# = 0   
	Field toWinkel# = 0
	
	Field meinFeind:TShip
	
	
	Field schiff:Int=0
	
	Field waffe:Int=1    
	Field waffenArsenal[] = [0,1,0,0,0,0,0,0,0,0]
	Field waffenMun[] = [0,-5,0,0,0,0,0,0,0,0]
	                           
	     
	Field towers:Int[] = [0,0]

	
	'Waffe dreht sich
	Field waffenTimer:Int=0  
	Field wRot:Int=0
	
	
	Field schild:TImage
	Field zusatzschild:TImage=Null
	Field schildStufe:Int=0	
	Field schildEnergie:Int=0
	
	Field shieldshow:Int=0
	Field shieldtimer:Int=0
	
	
	Field maxspeed
	
	
	Field ai
	Field rot, blau, grun
	Field team
	'Field sready = 0
	
	Field fshowfirst:Int = 1
	
	'Sprite Zeug
	Field Image:TImage
'	Field Image:TAnimImage

	
	Field CurAnimFrame:Int = 0
	' Width and height of sprite
	Field width:Int = 0
	Field Height:Int = 0
	' Animation frame list
'	Field FrameIndices:Int[] = Null
	'Field FrameIndices:Int[]
	' Animation timer vars
	Field AnimDelay:Int = 0
	Field AnimTime:Int = 1000
	Field CurAnimIndex:Int = 0
	Field dead:Int = 0

	'Field killed:Int = 0 'für Ausscheidungskampf
	Field DeathmatchDies:Int = 0 'selber kaputt
	Field DeathmatchFrags:Int = 0 'andere gefragt
	
	Field ausgeteilterSchaden:Int = 0
	Field eingesteckterSChaden:Int = 0


	Field stime:Int=0
	Field etime:Int=0
	
	Field LuaScr:ScriptEngine

	
	
	Method inViewport()
		Try
			If (getx()+Image.width > 0) And (getx()-Image.width < gfxOptions.gw) And (gety()+Image.height > 0) And (gety()-Image.height < gfxOptions.gh) Then
			'If GetX() > 0 And GetX() < gfxOptions.gw And GetY() > 0 And GetY() < gfxOptions.gh Then
				Return 1
			Else
				Return 0
			End If
		Catch ex:Object
			RuntimeError(ex.ToString() + " TShip-TShip-inViewport)")	
		End Try
	End Method	
	
	
	Method checkDead()
		Try
			If (life < 1) And (dead=0) Then
				'explosions.AddExplosion (TExplosion.create(sh.x,sh.y))
				'partikles.AddPartikel(P2Sonne1.create(sh.getx(),sh.gety()))

				'ships.addShip(Tship.create("UFO6", 500, 2000, 100, 1, 255, 255, 255, 3, 0))
				'ships.addShip(Tship.create("UFO5", 4000, 2000, 100, 1, 255, 255, 255, 8, 0))
			
				'partikles.AddPartikel(TCustomEmitter.createFromFile("partikelIni/explode2.ini",sh.getx(),sh.gety()))
				If GetX() > 0 And GetX() < gfxOptions.gw And GetY() > 0 And GetY() < gfxOptions.gh Then
					'partikles.AddPartikel(TCustomEmitter.createFromFile("partikelIni/explode99.ini",sh.getx(),sh.gety()))
					'partikles.AddPartikel(TCustomEmitter.createFromFile("partikelIni/explode88.ini",sh.getx(),sh.gety()))
					'partikles.AddPartikel(TCustomEmitter.createExplode1(sh.getx(),sh.gety()))
					'partikles.AddPartikel(TCustomEmitter.createExplode2(sh.getx(),sh.gety()))
										
					explode1.resetEmitter(GetX(),GetY())
					explode2.resetEmitter(GetX(),GetY())
					'explode1.resetEmitter(x,Y)
					'explode2.resetEmitter(x,Y)
					
					partikles.AddPartikel(explode1)
					partikles.AddPartikel(explode2)
					 
					playeffect explo
				End If		
				
				'Wegfindung zurücksetzen
				geheweg = Null
				pnow = 0
				
				
				dead=1	
				If ai <> 99 Then
					fshowfirst=1	
				End If

				'x = -8000
				
			
				
				Local iview = inViewport()
				If iview=1 Then
					'...playsound explo
				End If
				
				'ListRemove( sh_list, sh )
				'FlushMem()
			End If		
		Catch ex:Object
			RuntimeError(ex.ToString() + " TShip-TShip-checkdead)")	
		End Try
	End Method
	
	
	
	' Load sprite
	Method LoadImageR()'(URL:Object, TileWidth:Int, TileHeight:Int, FirstTile:Int, NumTiles:Int)
	
		Try
			Local url:String
			url = gleiter.ImagePath
			
											
			If ai <> 99 And ai <> 98 Then 'wenn es keine Raumstation/Tower ist
				
				'Local tileheight:Int = 56'80
				'Local tilewidth:Int = 56'80
				
				
				Local testimage:TImage = LoadImage(url)
				
				Local tileheight = testimage.height
				Local tilewidth = testimage.width/11
				
				
				testimage = Null

				Local firstTile:Int = 0
				Local NumTiles:Int = 11
		
				' Load image
				'SetMaskcolor(0,0,0)
				Local i
				'AutoMidHandle(True)
			
				'Image.Load(URL, TileWidth, TileHeight, FirstTile, NumTiles, MASKEDIMAGE|MIPMAPPEDIMAGE)
				'Image = LoadAnimImage(URL, TileWidth, TileHeight, FirstTile, NumTiles, MASKEDIMAGE|MIPMAPPEDIMAGE)
				
				
				Image = LoadAnimImage(URL, TileWidth, TileHeight, FirstTile, NumTiles, FILTEREDIMAGE)
				
				
				If image <> Null Then
					MidHandleImage(Image)
				End If
				'SetImageHandle(Image,Image.width,Image.Height)
			          
				'Image = superimage 'LoadAnimImage(URL, TileWidth, TileHeight, FirstTile, NumTiles)
				' Save dimensions
			
				width = TileWidth
				Height = TileHeight
		
				' Set cur anim frame
				CurAnimFrame = 0
				AnimDelay = 60
				'winkel=90
		
				'Frame-Abgrenzungen
				MaxStandAnim = 0'5
				StartLinks = 1 
				StartRechts = 6
				EndLinks = 5
				EndRechts = 10
				Direction = 0
				'FrameIndices = 
				'for i = 0 to EndRechts-1
				'next
			Else
				'debugstop
				'AutoMidHandle
										
				Image = LoadImage(url, FILTEREDIMAGE)
				'Image = LoadAnimImage(URL, 10, 10, 0, 1, FILTEREDIMAGE)
				If ai = 99 Then
					MidHandleImage(Image)
				Else
					MidHandleImage(Image)

					'Türme sollen sich richtig drehen
'					DebugStop
					'AutoMidHandle(false)
					'SetImageHandle(image,500,500)						
				End If
				
				width = image.width
				height = image.height
			End If
			
		Catch ex:Object
			RuntimeError(ex.ToString() + " TShip-TShip-loadimageR)")	
		End Try
	End Method
	'---
		
	Method GetX:Int()
		Try
			If ai > 0 Then
				Return  x#-ViewX   '-graphicsWidth()/2
			Else If ai = 0 Then
				If splitscreen = 0 Then
					Return  GraphicsWidth()/2
				Else
					Return  GraphicsWidth()/4
				End If
			Else If ai = -1 Then
					Return  GraphicsWidth()/2 + GraphicsWidth()/4
			End If
		Catch ex:Object
			RuntimeError(ex.ToString() + " TShip-TShip-getx)")	
		End Try
	End Method
	
	Method GetY:Int()
		Try
			If ai > 0 Then
				Return Y#-ViewY    '-graphicsHeight()/2
			Else
				Return GraphicsHeight()/2
			End If
		Catch ex:Object
			RuntimeError(ex.ToString() + " TShip-TShip-gety)")	
		End Try
	End Method



	Method GetX2:Int()
		Try
			Return  x#-ViewX2  '-graphicsWidth()/2
		Catch ex:Object
			RuntimeError(ex.ToString() + " TShip-TShip-getx2)")	
		End Try
	End Method
	
	
	Method GetY2:Int()
		Try
			Return Y#-ViewY2    '-graphicsHeight()/2
		Catch ex:Object
			RuntimeError(ex.ToString() + " TShip-TShip-gety2)")	
		End Try
	End Method






	Method RouteClearToEnemy:Int()
		If meinfeind <> Null Then
			Local i:Int
			Local j:Int
			For i = 0 To Len(aktuellerlevel.arena.tilesg)-1
				Local tx = aktuellerlevel.arena.tilesg[i].tx
				Local ty = aktuellerlevel.arena.tilesg[i].ty
		    	Local tw = aktuellerlevel.arena.tilesg[i].tilewidth
				Local th = aktuellerlevel.arena.tilesg[i].tileheight
				Local trot = aktuellerlevel.arena.tilesg[i].rotation

				Local endX = tx + Cos(trot) * tw
				Local endY = ty + Sin(trot) * th
				
				'Strecke zwischen schiff und feind berechnen
				'x -> meinfeind.x
				'y -> meinfeind.y
				Local mfx = meinfeind.x
				Local mfy = meinfeind.y
				Local ax = x
				Local ay = y
				
				Local axbigger:Int=0
				Local aybigger:Int=0
				
				While (ax <> mfx) Or (ay <> mfy)
									
					If mfx > ax Then
						'nicht ändern: sonst gibts Endlosschleife
						ax:+1
					Else If mfx < ax Then
						ax:-1
					End If

					If mfy > ay Then
						ay:+1
					Else If mfy < ay Then
						ay:-1
					End If

					If (ax >= tx) And (ax <= endx) And (ay >= ty) And (ay <= endy) Then
						Return 0
					End If
				Wend
			Next
		End If	
		Return 1
	End Method
	
	
	
	Method RouteClearToWinkel:Int(winkel:Int)
			Local i:Int
			Local j:Int
			For i = 0 To Len(aktuellerlevel.arena.tilesg)-1
				Local tx = aktuellerlevel.arena.tilesg[i].tx
				Local ty = aktuellerlevel.arena.tilesg[i].ty
		    	Local tw = aktuellerlevel.arena.tilesg[i].tilewidth
				Local th = aktuellerlevel.arena.tilesg[i].tileheight
				Local trot = aktuellerlevel.arena.tilesg[i].rotation

				Local endX = tx + Cos(trot) * tw
				Local endY = ty + Sin(trot) * th
				
				'Strecke zwischen schiff und feind berechnen
				'x -> meinfeind.x
				'y -> meinfeind.y
				Local mfx = x+Cos(winkel) * 100' meinfeind.x
				Local mfy = y+Sin(winkel) * 100'meinfeind.y
				Local ax = x
				Local ay = y
				
				Local axbigger:Int=0
				Local aybigger:Int=0
				
				While (ax <> mfx) Or (ay <> mfy)
									
					If mfx > ax Then
						'nicht ändern: sonst gibts Endlosschleife
						ax:+1
					Else If mfx < ax Then
						ax:-1
					End If

					If mfy > ay Then
						ay:+1
					Else If mfy < ay Then
						ay:-1
					End If

					If (ax >= tx) And (ax <= endx) And (ay >= ty) And (ay <= endy) Then
						Return 0
					End If
				Wend
			Next
		
		Return 1
	End Method
	
	
	
	
	Method show()
		Try
			If (fshowfirst = 1) Then
				showfirst()
			Else		
		
				resetgfx()
				SetRotation(mwinkel#)
		        SetBlend ALPHABLEND
				Rem
				'Schatten zeichnen
	    		SetBlend ALPHABLEND
				SetColor 0,0,0
			    SetAlpha 1
		
	'			setscale 0.2,0.2
		
				'DrawImage (image, getX()+8, getY()+8, CurAnimFrame)
				SetColor 255,255,255
				SetAlpha 1
				SetBlend MASKBLEND
				end rem
				'-------------------------
			
				'If ai > 0 Then
				'	SetColor rot,grun,blau
				'End If		
		
			    'SetAlpha 1
				'SetMaskColor 0,0,0
		        'SetBlend MASKBLEND
'				SetAlpha 0
    			'SetColor 255,255,255
		
				SetScale mainscale, mainscale
				'x = mainscale*x
				'y = mainscale*y
				
	           'DrawImage (image, getX(), getY(), CurAnimFrame)
				 
'				Local backer:Int = 30
				Local backer:Int = 50
				Local backer2:Int = backer*2
								
				'Local hx = x
				'Local hy = y
				
				'If splitscreen = 1 Then
					'hx = hx/2
					'hy = hy/2
				'End If
				
				
				If CollideImage(Image,x+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0) Then
					'LINKS
					x = x - Sin(mwinkel)*-backer
					Y = Y + Cos(mwinkel)*-backer
						
						If CollideImage(Image,x+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)						
						'RECHTS
						x = x - Sin(mwinkel)*backer2
						Y = Y + Cos(mwinkel)*backer2

						If CollideImage(Image,x+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
							'AUSGANGSPOSITION
							x = x - Sin(mwinkel)*-backer
							Y = Y + Cos(mwinkel)*-backer
				
							'If CollideImage(Image,GetX()+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, GetY()+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
							If CollideImage(Image,X+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
								If ai > 0 Then 
									'mwinkel = mwinkel - 45
									mwinkel = mwinkel + 180
									'mwinkel = mwinkel + 45

									'goMWinkel = '
									pnow = 0
									'geheweg = Null							
								End If
								'mwinkel = mwinkel + GameManager.FPS_Val(round(winkelSpeed*3))
								'speed = 0
								'subspeed(50)
					
								'RÜCKWÄRTS
								x = x + Cos(mwinkel+180)*-backer
								Y = Y + Sin(mwinkel+180)*-backer

								If CollideImage(Image,x+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
									'VORWÄRTS
									x = x + Cos(mwinkel)*-backer2
									Y = Y + Sin(mwinkel)*-backer2
					
									If CollideImage(Image,x+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
										'AUSGANGSPOSITION
										
										'If ai <= 0 Then DebugStop
										x = x + Cos(mwinkel+180)*-backer
										Y = Y + Sin(mwinkel+180)*-backer
									End If
								End If				
							End If
						End If						
					End If
				End If


				
								
												
'			Original:															
Rem
				If CollideImage(Image,hx-viewx+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, hY-viewy+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
					x = x - Sin(mwinkel)*-backer
					Y = Y + Cos(mwinkel)*-backer
					               
					If CollideImage(Image,hx-viewx+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, hY-viewy+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
						x = x - Sin(mwinkel)*backer2
						Y = Y + Cos(mwinkel)*backer2

						If CollideImage(Image,hx-viewx+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, hY-viewy+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
							x = x - Sin(mwinkel)*-backer
								Y = Y + Cos(mwinkel)*-backer
				
								'If CollideImage(Image,GetX()+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, GetY()+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
								If CollideImage(Image,hX+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, hY+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
									If ai <> 0 Then 
										'mwinkel = mwinkel - 45
										mwinkel = mwinkel + 180
										'mwinkel = mwinkel + 45

										'goMWinkel = '
										pnow = 0
										'geheweg = Null							
										End If
									'mwinkel = mwinkel + GameManager.FPS_Val(round(winkelSpeed*3))
									'speed = 0
									subspeed(50)
					
									x = x + Cos(mwinkel+180)*-backer
									Y = Y + Sin(mwinkel+180)*-backer

										If CollideImage(Image,hx-viewx+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, hY-viewy+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
											x = x + Cos(mwinkel)*-backer2
											Y = Y + Sin(mwinkel)*-backer2
					
											If CollideImage(Image,hx-viewx+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, hY-viewy+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
												x = x + Cos(mwinkel+180)*-backer
												Y = Y + Sin(mwinkel+180)*-backer
							
											End If
										End If				
									End If
								End If						
							End If
						End If
End Rem
												
																		
																				
																								
																																
				
Rem				
				If CollideImage(Image,GetX()+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, GetY()+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
					If ai <> 0 Then 
						'mwinkel = mwinkel - 45
						mwinkel = mwinkel + 180
						'mwinkel = mwinkel + 45

						'goMWinkel = '
						pnow = 0
						geheweg = Null							
					End If
					'mwinkel = mwinkel + GameManager.FPS_Val(round(winkelSpeed*3))
					
					
					'speed = 0
					subspeed(50)
					
					x = x + Cos(mwinkel+180)*-backer
					Y = Y + Sin(mwinkel+180)*-backer

					If CollideImage(Image,x-viewx+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y-viewy+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
						x = x + Cos(mwinkel)*-backer2
						Y = Y + Sin(mwinkel)*-backer2
					
						If CollideImage(Image,x-viewx+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y-viewy+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
							x = x + Cos(mwinkel+180)*-backer
							Y = Y + Sin(mwinkel+180)*-backer
							
							If CollideImage(Image,x-viewx+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y-viewy+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
								x = x - Sin(mwinkel)*-backer
								Y = Y + Cos(mwinkel)*-backer
							               
								If CollideImage(Image,x-viewx+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y-viewy+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
									x = x - Sin(mwinkel)*backer2
									Y = Y + Cos(mwinkel)*backer2

									If CollideImage(Image,x-viewx+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y-viewy+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame, 1, 0)
										x = x - Sin(mwinkel)*-backer
										Y = Y + Cos(mwinkel)*-backer
									End If						
								End If
							End If
						End If
					End If				
					
					
					'If ai > 0 Then mwinkel = mwinkel + 90
					
					'trampolin
					'speed = speed * 2 
					'mwinkel = mwinkel + 180
				End If
End Rem				
				
				
	'			ResetCollisions
					
				'setscale 1,1
		
		'		setalpha 1
				'x = x + ViewX
				'y = y + ViewY
				
				If ai = 0 Then
					ViewX = x-GraphicsWidth()/2
					ViewY = Y-GraphicsHeight()/2
					
					If splitscreen = 1 Then
						ViewX = x-GraphicsWidth()/4
						'ViewY = Y-GraphicsHeight()/3
						'viewx2 = x+GraphicsWidth()/2
						'viewy2 = y+GraphicsHeight()/2
					End If
					
					viewSpeed = speed
					viewWinkel = mwinkel
				End If
			
			
				If ai = -1 Then
					
					ViewX2 = x-GraphicsWidth()/2-GraphicsWidth()/4
					ViewY2 = Y-GraphicsHeight()/2
					'viewx2 = x+GraphicsWidth()/2
					'viewy2 = y+GraphicsHeight()/2
					
					viewSpeed2 = speed
					viewWinkel2 = mwinkel
				End If
			
			
				Local check:Int = inViewport()
				If check = 1 Then 
					'Image.draw(GetX(),GetY(),Image.Image.width,Image.Image.Height,CurAnimFrame)
					'getx()+Cos(mwinkel)*(-10)-Sin(mwinkel)*-10,   GetY()+Sin(mwinkel)*(-10)+Cos(mwinkel)*-10
					'DrawImage (Image, GetX(), GetY(), CurAnimFrame)
					'SetBlend LIGHTBLEND
					
					'Raumschiff blitten
					
					If splitscreen = 1 Then
						If ai > 0 Then
							SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()
							DrawImage (Image, GetX()+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, GetY()+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame)
							SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()
							DrawImage (Image, GetX2()+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, GetY2()+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame)
							SetViewport 0,0, GraphicsWidth(), GraphicsHeight()
						Else
							DrawImage (Image, GetX()+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, GetY()+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame)
							
							If ai = 0 Then
								SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()								
								DrawImage (Image, x-viewx2+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y-viewy2+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame)
							Else If ai = -1 Then
								SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()								
								DrawImage (Image, X-viewx+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, Y-viewy+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame)
							End If
							SetViewport 0,0, GraphicsWidth(), GraphicsHeight()

						End If
					Else If splitscreen = 0 Then
						DrawImage (Image, GetX()+Cos(mwinkel)*(-1)-Sin(mwinkel)*11, GetY()+Sin(mwinkel)*(-1)+Cos(mwinkel)*11, CurAnimFrame)
					End If
					'Antrieb.updateAll(GetX()+Cos(mwinkel)*(-15)-Sin(mwinkel)*-1, GetY()+Sin(mwinkel)*(-15)+Cos(mwinkel)*-1 , mwinkel)
				    
					'hhh
					'Items anzeigen (Waffen/Munition/Schild/Radar/...)
					If ai=0 Then	                 
						'Schildenergie unten anzeigen
						'SetImageFont gamefont
						setsuperfont()					
						Local texta = TextWidth((String(life))+"A")

						SetRotation MilliSecs()
						SetBlend LIGHTBLEND	
						SetAlpha 0.6
						SetScale 1,1                  
						
						DrawImage schild,30*gfxOptions.getscalefactor()+texta,720*gfxOptions.Getscalefactor()
						SetRotation 0
						
						DrawSuper(life,30*gfxOptions.getscalefactor(),700*gfxOptions.getscalefactor())
                                	
						If zeigeXY = 1 Then
							DrawSuper("X=" + x + "  " + "Y=" + y,getx(),gety())
						End If
   
                                          
						'Zusatzschildenergie unten anzeigen
						If schildStufe > 0 Then
							setsuperfont()					
							Local texta = TextWidth((String(schildEnergie))+"A")
							SetRotation MilliSecs()
							SetBlend LIGHTBLEND	
							SetAlpha 0.6
							SetScale 1,1        
							DrawImage zusatzschild,200*gfxOptions.getscalefactor()+texta,720*gfxOptions.Getscalefactor()
							SetRotation 0							          
							DrawSuper(schildEnergie,200*gfxOptions.getscalefactor(),700*gfxOptions.getscalefactor())
						End If

						If waffenTimer = 0 Then 
							waffenTimer = MilliSecs()
						Else
							If MilliSecs() > waffenTimer + 5 Then
								wRot = wRot + 1
								waffenTimer=0
							End If
						End If
						
						'Waffe/Munition anzeigen
						If waffenArsenal[waffe] = 1 Then
                        	If (waffenMun[waffe] > -1) Or (waffenMun[waffe] = -5) Then  
								setsuperfont()
								Local texta = TextWidth((String(waffenMun[waffe]))+"A")

                        		SetAlpha 0.6
                        		SetRotation wRot   
                        		SetBlend ALPHABLEND
                        		'SetImageFont gamefont
								
								DrawImage TSchussart(schussarten.schuesse.ValueAtIndex(waffe-1)).simagelevel, 350*gfxOptions.getscalefactor()+texta,720*gfxOptions.Getscalefactor()
								SetRotation 0    						
								
								Local amun:String = "-"
								If waffenMun[waffe] <> -5 Then
									DrawSuper(waffenMun[waffe],350*gfxOptions.getscalefactor(),700*gfxOptions.getscalefactor())
								Else
									DrawSuper(amun,350*gfxOptions.getscalefactor(),700*gfxOptions.getscalefactor())
								End If
							End If
						End If
						
						
						'Boosterenergie anzeigen
						If boosterEnergie > 0 Then
							setsuperfont()
							texta = TextWidth(Int(boosterenergie)+"A")
							
                       		SetAlpha 0.6
                       		SetRotation wRot
                       		SetBlend ALPHABLEND
                       		SetImageFont gamefont
							DrawImage(iBoosterItem,500*gfxOptions.getscalefactor()+texta,720*gfxOptions.Getscalefactor())
							SetRotation 0
							DrawSuper(Int(boosterenergie),500*gfxOptions.getscalefactor(),700*gfxOptions.getscalefactor())
						End If
												
						
						'Towers anzeigen
						If (towers[0] > 0) Then
							Local anzahl1:Int = towers[0]
														
							setsuperfont()
							texta = TextWidth(Int(anzahl1)+"A")
							
                       		SetAlpha 0.6
                       		SetRotation wRot
                       		SetBlend ALPHABLEND
                       		SetImageFont gamefont

							DrawImage(iTowerItem1,650*gfxOptions.getscalefactor()+texta,720*gfxOptions.Getscalefactor())
							SetRotation 0
							DrawSuper(Int(anzahl1),650*gfxOptions.getscalefactor(),700*gfxOptions.getscalefactor())
						End If
						
						
						If (towers[1] > 0) Then
							Local anzahl1 = towers[1]
														
							setsuperfont()
							texta = TextWidth(Int(anzahl1)+"A")
							
                       		SetAlpha 0.6
                       		SetRotation wRot
                       		SetBlend ALPHABLEND
                       		SetImageFont gamefont

							DrawImage(iTowerItem2,800*gfxOptions.getscalefactor()+texta,720*gfxOptions.Getscalefactor())
							SetRotation 0
							DrawSuper(Int(anzahl1),800*gfxOptions.getscalefactor(),700*gfxOptions.getscalefactor())
						End If
						
						
					
					    SetRotation 0
					End If   
				
				'DrawText name +", "+life, getX()+10,getY()+10
				'DrawText "Speed: " + speed,getX()+30,getY()+30
				'drawtext "Maxspeed:" + maxspeed,getX()+30,getY()+40
				'DrawText "SpeedGM: " + gamemanager.FPS_Val(speed),getX()+30,getY()+50
				'drawtext "MaxspeedGM:" + gamemanager.FPS_Val(maxspeed),getX()+30,getY()+60
			
				'Plot x#, y#			
			
				If shieldshow > 0 Then
					SetColor 255,255,255
				
					SetBlend LIGHTBLEND
					SetAlpha 0.7
					SetRotation MilliSecs()
					
					'DrawImage(schild, GetX()+Cos(mwinkel)*(-10)-Sin(mwinkel)*1,   GetY()+Sin(mwinkel)*(-10)+Cos(mwinkel)*1)		
					If schildStufe > 0 Then
					
						If ai > 0 Then
							If splitscreen = 0 Then
								DrawImage(zusatzschild, GetX()+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo,   GetY()+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)		
							Else
								SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()
								DrawImage(zusatzschild, GetX()+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo,   GetY()+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)		
								SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()								
								DrawImage(zusatzschild, GetX2()+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo,   GetY2()+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)		
								SetViewport 0,0, GraphicsWidth(), GraphicsHeight()
							End If				
						End If
						
						If ai = 0 Or ai = -1 Then
							SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()								
							DrawImage (zusatzschild, x-viewx2+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo, Y-viewy2+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)
						'Else If ai = -1 Then
							SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()								
							DrawImage (zusatzschild, X-viewx+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo, Y-viewy+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)
						End If
						SetViewport 0,0, GraphicsWidth(), GraphicsHeight()
							
						
					
					Else
						If ai = 99 Then
							SetScale 3,3
							SetAlpha 0.5
							
							If splitscreen = 0 Then 
								DrawImage(schild, GetX()+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo,   GetY()-20+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)		
							Else
								SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()
								DrawImage(schild, GetX()+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo,   GetY()-20+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)		
								SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()								
								DrawImage(schild, GetX2()+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo,   GetY2()-20+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)		
								SetViewport 0,0, GraphicsWidth(), GraphicsHeight()
							End If
						Else

							If ai > 0 Then
								If splitscreen = 0 Then
									DrawImage(schild, GetX()+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo,   GetY()+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)		
								Else
									SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()
									DrawImage(schild, GetX()+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo,   GetY()-20+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)		
									SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()								
									DrawImage(schild, GetX2()+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo,   GetY2()-20+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)		
									SetViewport 0,0, GraphicsWidth(), GraphicsHeight()
								End If
							Else
								If ai = 0 Or ai = -1 Then
									SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()								
									DrawImage (schild, x-viewx2+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo, Y-viewy2+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)
								'Else If ai = -1 Then
									SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()								
									DrawImage (schild, X-viewx+Cos(mwinkel)*(gleiter.EffektPositionen.SchildVert)-Sin(mwinkel)*gleiter.EffektPositionen.SchildHo, Y-viewy+Sin(mwinkel)*(gleiter.EffektPositionen.SchildVert)+Cos(mwinkel)*gleiter.EffektPositionen.SchildHo)
								End If
								SetViewport 0,0, GraphicsWidth(), GraphicsHeight()

														
							End If
						End If
						resetgfx()
					End If
					
					'stopuhr
					'shieldshow:+1
					'if shieldshow>10 then shieldshow=0
					If shieldtimer = 0 Then
						shieldtimer = MilliSecs()
					Else
						If MilliSecs() > shieldtimer+300 Then 
							shieldtimer = 0
							shieldshow = 0
						End If
					End If
				
					SetRotation 0
					SetBlend MASKBLEND
					SetAlpha 1
				End If
			
			
			
			
				'Antrieb.updateAll(GetX()+Cos(mwinkel)*(-15)-Sin(mwinkel)*-1, GetY()+Sin(mwinkel)*(-15)+Cos(mwinkel)*-1 , mwinkel)
				
				If ai <> 99 And ai <> 98 Then
					Antrieb.updateAll(GetX()+Cos(mwinkel)*(gleiter.EffektPositionen.AntriebVert)-Sin(mwinkel)*gleiter.EffektPositionen.AntriebHo, GetY()+Sin(mwinkel)*(gleiter.EffektPositionen.AntriebVert)+Cos(mwinkel)*gleiter.EffektPositionen.AntriebHo , mwinkel)
				End If
				
					
				If muendungsfeuer.aktiv = 1 Then
					'Muendungsfeuer.updateAll(getX()+cos(mwinkel)*(-35)-sin(mwinkel)*27, getY()+sin(mwinkel)*(-35)+cos(mwinkel)*27 , mwinkel)
					'ohne FPS: Muendungsfeuer.updateAll(getX()+cos(mwinkel)*(-35)-sin(mwinkel)*-10,   getY()+sin(mwinkel)*(-35)+cos(mwinkel)*-10 , mwinkel)
					'Muendungsfeuer.updateAll(getX()+cos(mwinkel)*(-50)-sin(mwinkel)*-40,   getY()+sin(mwinkel)*(-50)+cos(mwinkel)*-40 , mwinkel)
	
	
	'			getX()+cos(mwinkel)*(-30)-sin(mwinkel)*-12,   getY()+sin(mwinkel)*(-30)+cos(mwinkel)*-12
	'									vertikel        horizontal										
	'									 -vor				-rechts
	'									 +zurück			+links	
				End If
		
		
				
				'Optische Anpassung des Antriebs		
				'If ai = 0 Then
					'antrieb.dodelta((cos(mwinkel)*speed) - sin(mwinkel)*mwinkel/360, (sin(mwinkel)*speed) + cos(mwinkel)*mwinkel/360)
					'antrieb.moveparticles(antrieb.x + cos(mwinkel)*speed/1, antrieb.y + sin(mwinkel)*speed/1)
					'antrieb.moveparticles(antrieb.x + cos(mwinkel) * 0 - sin(mwinkel) * mwinkel, antrieb.y + sin(mwinkel) * 0 + cos(mwinkel) * mwinkel)
					'local x1 = ax + cos(awinkel) * 0 - sin(awinkel) * delta
					'local y1 = ay + sin(awinkel) * 0 + cos(awinkel) * delta

				'End If
		
		Local kwinkel:Float = Self.mwinkel
		
				If ai > 0  And ai <> 99 And ai <> 98 Then
					'antrieb.dodelta((cos(mwinkel)*speed*2) - sin(mwinkel)*mwinkel/360, (sin(mwinkel)*speed*2) + cos(mwinkel)*mwinkel/360)
			
					
			
					'antrieb.dodelta((cos(kwinkel)*(-speed+viewspeed)) - sin(kwinkel)*(0), (sin(kwinkel)*(-speed+viewspeed)) + cos(kwinkel)*(0))			
			
			
					'an eigene Geschwindigkeit anpassen
					Antrieb.dodelta( ( Cos(kwinkel)*(-GameManager.FPS_Val(speed)) ) - Sin(kwinkel)*(0), ( Sin(kwinkel)*(GameManager.FPS_Val(-speed)) + Cos(kwinkel)*(0)))			
					'an ViewWinkel und ViewSpeed anpassen
					Antrieb.dodelta( ( Cos(viewWinkel)*(GameManager.FPS_Val(viewSpeed))) - Sin(viewWinkel)*viewWinkel/360, (Sin(viewWinkel)*(GameManager.FPS_Val(viewSpeed)) + Cos(viewWinkel)*viewWinkel/360))			
			
'					explode1.dodelta( ( Cos(viewWinkel)*-(GameManager.FPS_Val(viewSpeed))) - Sin(viewWinkel+180)*viewWinkel/360, (Sin(viewWinkel)*-(GameManager.FPS_Val(viewSpeed)) + Cos(-viewWinkel)*viewWinkel/360))						
'					explode2.dodelta( ( Cos(viewWinkel)*-(GameManager.FPS_Val(viewSpeed))) - Sin(viewWinkel+180)*viewWinkel/360, (Sin(viewWinkel)*-(GameManager.FPS_Val(viewSpeed)) + Cos(-viewWinkel)*viewWinkel/360))						
					'explode1.dodelta( ( Cos(viewWinkel)*(GameManager.FPS_Val(viewSpeed))), (Sin(viewWinkel+180)*(GameManager.FPS_Val(viewSpeed)) ))						
					'explode2.dodelta( ( Cos(viewWinkel)*(GameManager.FPS_Val(viewSpeed))), (Sin(viewWinkel+180)*(GameManager.FPS_Val(viewSpeed)) ))						
                    'explode1.Move(5090,5090)
					'explode2.Move(5900,5900)

					
					'antrieb.dodelta(-getx()*300, -gety()*300)
					'antrieb.moveparticles(antrieb.x + cos(winkel)*speed, antrieb.y + sin(winkel)*speed)
					'antrieb.dodelta((cos(mwinkel+180)*speed), (sin(mwinkel+180)*speed))
					'antrieb.dodelta(20,20)
					'local x1 = ax + cos(awinkel) * 0 - sin(awinkel) * delta
	  				'local y1 = ay + sin(awinkel) * 0 + cos(awinkel) * delta

			
					'Schildposition updaten
					Rem 
					if schild.aktiv = 1 then
						'schild.updateAll(getX()+cos(mwinkel)*(-25)-sin(mwinkel)*-35, getY()+sin(mwinkel)*(-25)+cos(mwinkel)*-35 , mwinkel)
						schild.updateall(getX()+cos(mwinkel)*(-30)-sin(mwinkel)*-15,   getY()+sin(mwinkel)*(-30)+cos(mwinkel)*-15 , mwinkel)
					end if
					'an eigene Geschwindigkeit anpassen
					schild.dodelta((cos(kwinkel)*(-speed)) - sin(kwinkel)*(0), (sin(kwinkel)*(-speed)) + cos(kwinkel)*(0))			
					'an ViewWinkel und ViewSpeed anpassen
					schild.dodelta((cos(viewWinkel)*(viewSpeed)) - sin(viewWinkel)*viewWinkel/360, (sin(viewWinkel)*(viewSpeed)) + cos(viewWinkel)*viewWinkel/360)			
					End Rem 
					'local hx = getx() +   (cos(mwinkel)*(-10)-sin(mwinkel)*-15)   +   (cos(kwinkel)*(-speed)-sin(kwinkel)*(0))   +   (cos(viewWinkel)*(viewSpeed)-sin(viewWinkel)*viewWinkel/360)
					'local hy = gety() +   (sin(mwinkel)*(-10)+cos(mwinkel)*-15)   +   (sin(kwinkel)*(-speed)+cos(kwinkel)*(0))   +   (sin(viewWinkel)*(viewSpeed)+cos(viewWinkel)*viewWinkel/360)
					'schild.updateall(hx,hy,mwinkel)
				End If
			
			
				If ai > 0 And ai <> 99 Then
					'Muendungsfeuer updaten
					If muendungsfeuer.aktiv = 1 Then
						
					
					'an eigene Geschwindigkeit anpassen
						muendungsfeuer.dodelta((Cos(kwinkel)*(-GameManager.FPS_Val(speed))) - Sin(kwinkel)*(0), (Sin(kwinkel)*(-GameManager.FPS_Val(speed))) + Cos(kwinkel)*(0))			
					'an ViewWinkel und ViewSpeed anpassen
						muendungsfeuer.dodelta((Cos(viewWinkel)*(GameManager.FPS_Val(viewSpeed))) - Sin(viewWinkel)*viewWinkel/360, (Sin(viewWinkel)*(GameManager.FPS_Val(viewSpeed))) + Cos(viewWinkel)*viewWinkel/360)			
					End If
			
				End If

			End If 

			
			'Raumstation-Energie anzeigen
			If ai = 99 Then
				'SetImageFont gamefont
				setsuperfont()
				Local texta = TextWidth((String(life))+"A")				
				
				'SetRotation MilliSecs()
				SetBlend LIGHTBLEND	
				SetAlpha 0.8
				SetScale 0.3,0.3                  
				
				DrawImage image,420*gfxOptions.getscalefactor()+texta,55*gfxOptions.Getscalefactor()
				'SetRotation 0
				SetScale 1,1                  
				DrawSuper(life,420*gfxOptions.getscalefactor(),40*gfxOptions.getscalefactor())
			End If			


			'lebensenergie-balken anzeigen
	
				resetgfx()
				Local goy:Int=0
				
				Local xwidth:Int=0
				Local ywidth:Int=0 
				Local ywidth2:Int=0 
				Local xwidth2:Int=0
				Local xwidth3:Int=0

				
				If ai = 99 Then 
					goy = 80
					ywidth = 2
					xwidth = 10
					xwidth2 = 100
					ywidth2 = 2
					xwidth3 = 10
					'SetScale 4,2
				End If
				If ai = 98 Then goy = 10
				
				
				
			If ai > 0 Then				
				'Method DrawHealthbar(hx,hy,xwidth,ywidth,xwidth2,ywidth2,xwidth3,goy)
				
				If splitscreen = 0 Then				
					DrawHealthbar(getx(),gety(),xwidth,ywidth,xwidth2,ywidth2,xwidth3,goy)
				Else
					SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()													
					DrawHealthbar(getx(),gety(),xwidth,ywidth,xwidth2,ywidth2,xwidth3,goy)
					SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()												
					DrawHealthbar(getx2(),gety(),xwidth,ywidth,xwidth2,ywidth2,xwidth3,goy)
					SetViewport 0,0, GraphicsWidth(), GraphicsHeight()					
				End If			
				'DrawText life + "/" + urlife, getx(), gety()+100
			End If


			If ai = 0 Then
				SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()								
				DrawHealthbar(x-viewx2, Y-viewy2, xwidth,ywidth,xwidth2,ywidth2,xwidth3,goy)
			Else If ai = -1 Then
				SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()								
				DrawHealthbar(X-viewx, Y-viewy, xwidth,ywidth,xwidth2,ywidth2,xwidth3,goy)
			End If
			SetViewport 0,0, GraphicsWidth(), GraphicsHeight()




			End If  'fshowfirst
			SetRotation 0
		Catch ex:Object
			RuntimeError(ex.ToString() + " TShip-TShip-show)")	
		End Try
	
	End Method
	
	
	
	Method DrawHealthbar(hx,hy,xwidth,ywidth,xwidth2,ywidth2,xwidth3,goy)
		Local i:Int
			
			
		'Standardschild				
		SetColor 170,170,170
		DrawRect hx-21, hy+39+goy, 62+xwidth2, 5+ywidth2
				
		SetColor 0,0,0
		DrawRect hx-20, hy+40+goy, 60+xwidth2, 3+ywidth2
		SetColor 255,0,0

		Local urlife2:Float = urlife
		Local life2:Float = life
				
		Local prozent:Float = (100/urlife2) * life2
		Local proz = prozent/10				
				
		For i = 0 To proz
			If i > 9 Then Exit
			DrawRect hx-20 + i*(6+xwidth), hy+40+goy, 6+xwidth3, 3+ywidth2 
		Next
				
		'Bonusschild
		If schildenergie > 0 Then
			SetColor 170,170,170
			DrawRect hx-21, hy+44, 62, 5
				
			SetColor 0,0,0
			DrawRect hx-20, hy+45, 60, 3

			SetColor 200,200,0
		
			urlife2:Float = 50
			life2:Float = schildenergie
				
			Local prozent:Float = (100/urlife2) * life2
			Local proz = prozent/10				
				
			For i = 0 To proz
				If i > 9 Then Exit
				DrawRect hx-20 + i*6, hy+45, 6, 3 
			Next								
		End If
							
	End Method				
	
	
	
	Method showAntrieb()
		Try
				'Antrieb.pAlphaDelta = -0.0499999982
				Antrieb.pAlphaDelta = -0.08'-0.0799999982
	'			Antrieb.SetColor(150,150,0)
				'30,80,230
				
				'If ai = 99 Then 
			'		Antrieb.pAlphaDelta = -1
		'		End If
			
		Catch ex:Object
			RuntimeError(ex.ToString() + " TShip-TShip-showantrieb)")	
		End Try
	End Method
		
		
	Method hideAntrieb()
		Try
			Antrieb.pAlphaDelta = -1		
		Catch ex:Object
			RuntimeError(ex.ToString() + " TShip-TShip-hideAntrieb)")	
		End Try
	End Method
		
		
	Method showfirst()
		Try
			If ai<=0 Then
				If dead=1 Then
					viewSpeed = 0
					viewWinkel = 0
					
					resetgfx()
'					setcolor 255,0,0
					'DrawSuper(" YOU ARE DEAD",GraphicsWidth()/2-200*gfxOptions.getscalefactor(), GraphicsHeight()/2-200*gfxOptions.getscalefactor())

					'drawtext("Use Cursor Keys",graphicswidth()/2, graphicsheight()/2+50)

					If stime=0 Then stime=MilliSecs()
					etime=MilliSecs()	
				
					If etime-stime < 500 Then
						DrawSuper(getlang("- DRÜCKE ENTER -"),GraphicsWidth()/2-200*gfxOptions.getscalefactor(), GraphicsHeight()/2+50-200*gfxOptions.getscalefactor())
					Else If etime-stime > 1000 Then
						stime = 0
					End If
								
					Rem 
					local vs:int = 400
					viewspeed = 0
					if keydown(KEY_UP) then 
						viewy:-GameManager.FPS_Val(vs)
						viewspeed = vs
					end if
				
					if keydown(KEY_DOWN) then 
						viewy:+GameManager.FPS_Val(vs)
						viewspeed = vs
					end if
				
					if keydown(KEY_LEFT) then 
						viewx:-GameManager.FPS_Val(vs)
						viewspeed = vs
					end if
				
					if keydown(KEY_RIGHT) then 
						viewx:+GameManager.FPS_Val(vs)
						viewspeed = vs
					end if
					end rem										
						
					If KeyDown(KEY_ENTER) Then
						stime=0
						'x = rand(200, arena1.lwidth-200)
						'y = rand(200, arena1.lheight-200)
						x = startx
						y = starty
						erscheinung.resetEmitter(GetX()+Cos(mwinkel)*(-6)-Sin(mwinkel)*-15,   GetY()+Sin(mwinkel)*(-6)+Cos(mwinkel)*-15)
						partikles.AddPartikel(erscheinung)
						dead=0
						life=gleiter.life
						fshowfirst=0
						playeffect shipSpawn

						'flushkeys()
					End If	
				
				Else                 
					x = startX
					Y = startY
					erscheinung.resetEmitter(GetX()+Cos(mwinkel)*(-6)-Sin(mwinkel)*-15,   GetY()+Sin(mwinkel)*(-6)+Cos(mwinkel)*-15)
					partikles.AddPartikel(erscheinung)
					dead=0
					life=urlife 'gleiter.life
					fshowfirst=0		
					playeffect shipSpawn
				End If
		
		   'COMPUTER
			Else
				If autoSpawn = 1 Then
					dead=0
					life = urlife 'gleiter.life
					
					x = startX
					Y = startY
					If GetX() > 0 And GetX() < gfxOptions.gw And GetY() > 0 And GetY() < gfxOptions.gh Then
						erscheinung.resetEmitter(GetX()+Cos(mwinkel)*(-6)-Sin(mwinkel)*-15,   GetY()+Sin(mwinkel)*(-6)+Cos(mwinkel)*-15)
						partikles.AddPartikel(erscheinung)
						playeffect shipSpawn
					End If		
					fshowfirst = 0
					SetDronenWaffe()					
				End If
			End If
		
	
	
	
		
		Rem	
		local aa:float = 10
		global bb:float = 0
		SetBlend alphablend

		while bb < 1
			cls
			SetColor 255,255,255
			setalpha 1
			tileimage image1,-viewx,-viewy
		    'SetAlpha 0.5
			'setscale aa,aa
			'setrotation bb
			setalpha bb
			DrawImage (image, getX()+12, getY()+12, CurAnimFrame)
			flip
			flushmem()
			aa = aa - 0.1
			bb = bb + 0.01
			if keyhit(KEY_ESCAPE) exit
		wend
		
		setalpha 1
		setscale 1,1
		SetColor 255,255,255
		fshowfirst = 1
		end rem 
		
		Catch ex:Object
			RuntimeError(ex.ToString() + " TShip-TShip-showfirst)")	
		End Try
	End Method

	

	
	Method spawn(winkel:Int=0)
		If dead = 1 Then
			dead=0								
			life = urlife 'gleiter.life
			x = startX
			Y = startY
			If GetX() > 0 And GetX() < gfxOptions.gw And GetY() > 0 And GetY() < gfxOptions.gh Then
				erscheinung.resetEmitter(GetX()+Cos(mwinkel)*(-6)-Sin(mwinkel)*-15,   GetY()+Sin(mwinkel)*(-6)+Cos(mwinkel)*-15)
				partikles.AddPartikel(erscheinung)
				playeffect shipSpawn
			End If		
			mwinkel=winkel
			fshowfirst = 0    
			SetDronenWaffe()
		End If
	End Method

	
	Method shoot() 

		Try
			If waffe = 0 Then
				If waffenmun[0] > 0 Then
					'..
				End If
			Else
		
				If (waffenMun[waffe] > 0) Or (waffenMun[waffe] = -5) Then						                                                  
		
					If shoottimer = 0 Then
						shoottimer = MilliSecs()
				
						Local iview = inViewport()
						If iview=1 Then
							'PlayEffect shoots
							PlayEffect TSchussart(schussarten.schuesse.ValueAtIndex(waffe-1)).sSound
						End If
				
							'bullets.AddBullet(TBullet1.create(ax+cos(awinkel)*15, ay+sin(awinkel)*15, awinkel, 20, 250/4, 10, pteam, 255, 255, 255))

							Local delta2:Int = -30 'vorne hinten
							Local delta:Int = 3 'links rechts

	'			  			Local x1 = x + Cos(mwinkel) * delta2 - Sin(mwinkel) * delta
	'						Local y1 = Y + Sin(mwinkel) * delta2 + Cos(mwinkel) * delta
				  			Local x1 = x + Cos(mwinkel) * gleiter.EffektPositionen.MuendungVert - Sin(mwinkel) * gleiter.EffektPositionen.MuendungHo
							Local y1 = Y + Sin(mwinkel) * gleiter.EffektPositionen.MuendungVert + Cos(mwinkel) * gleiter.EffektPositionen.MuendungHo
		                                       
								TSchussart(schussarten.schuesse.ValueAtIndex(waffe-1)).ShootMe(x1,y1,mwinkel,team,Self)
								If waffenMun[waffe] > 0 Then
									waffenMun[waffe] = waffenMun[waffe] - 1
								End If
					
						'bullets.AddBullet(TBullet1.create(x2, y2, awinkel, 20, 250/4, 10, pteam, 255, 255, 255))
						
						'muendungsfeuer.resetEmitter(GetX()+Cos(mwinkel)*(-17)-Sin(mwinkel)*1,   GetY()+Sin(mwinkel)*(-17)+Cos(mwinkel)*1)
						
						
						muendungsfeuer.resetEmitter(GetX()+Cos(mwinkel)*(gleiter.EffektPositionen.MuendungVert)-Sin(mwinkel)*gleiter.EffektPositionen.MuendungHo,   GetY()+Sin(mwinkel)*(gleiter.EffektPositionen.MuendungVert)+Cos(mwinkel)*gleiter.EffektPositionen.MuendungHo)
						partiklesOver.AddPartikel(muendungsfeuer)
						
						'Mündungsfeuer-Ansatz:
						'setcolor 255,0,0
						'setblend lightblend
						'setalpha 0.8
					
						'drawimage schussmuendung, x1-viewx,y1-viewy
						'drawimage schussmuendung, x2-viewx,y2-viewy
						
						'setalpha 1
						'setcolor 255,255,255
						'setblend maskblend		
					
					'bullets.AddBullet(TBullet1.create(ax+atan(awinkel)*15, ay+atan(awinkel)*15, awinkel, 20, 250/4, 10, pteam, 255, 255, 255))
					'(posx#, posy#, pwinkel#, pdmg, plifetime, pspeed#, pTeam#, prot, pblau, pgrun)
					'sready = 10
			
					Else
						If MilliSecs() > shoottimer+TSchussart(schussarten.schuesse.ValueAtIndex(waffe-1)).sdelay Then 
							shoottimer = 0
						End If
					End If
			
				End If        
			End If

		Catch ex:Object
			RuntimeError(ex.ToString() + " TShip-TShip-shoot)")	
		End Try
	End Method
	
	
	
	Method Update(DeltaTime:Int)
	Try                               
	    'Waffenauswahl
	    '	Field waffe:Int=1    
		'	Field waffenArsenal[] = (0,1,1,0,0,0,0,0,0,0)

		If (antrieb <> Null) And (ai <> 99) And (ai <> 98)Then
			Antrieb.SetColor(30,80,230)		'Antrieb auf Standardfarbe setzen
		End If

		
		If ai = 0 Then
			Local i:Int
			For i = 0 To waffenArsenal.length-1
				If KeyHit(48+i) Then
					If waffenArsenal[i] = 1 Then
						playeffect(sGetGun)
						waffe = i					
					End If
				End If
			Next
	    End If
		
	
	
		'--- Animation
		'speed = speed * DeltaTime
        'y = y + (vely * DeltaTime)

		'If (FrameIndices)
			AnimTime = AnimTime + DeltaTime
			If (AnimTime > AnimDelay)
				AnimTime = 0
		
				'Animation
				If Direction = 0 Then ' NORMAL
					'If (CurAnimIndex < (FrameIndices.length-1))	
					If CurAnimIndex < MaxStandAnim
						CurAnimIndex = CurAnimIndex + 1
					End If
					
					If CurAnimIndex = MaxStandAnim
						CurAnimIndex = 0					
					End If
											
					If (CurAnimIndex > StartLinks) And (CurAnimIndex <= EndLinks)
						CurAnimIndex = CurAnimIndex - 1
					End If
										
					If (CurAnimIndex > StartRechts) And (CurAnimIndex <= EndRechts)
						CurAnimIndex = CurAnimIndex - 1
					EndIf
					
					If (CurAnimIndex = StartRechts) Or (CurAnimIndex = StartLinks)
						CurAnimIndex = 0					
					End If
					
					
					'CurAnimFrame = FrameIndices[CurAnimIndex]
					CurAnimFrame = CurAnimIndex
				Else If Direction = 1 Then ' LINKS
					If (CurAnimIndex >= StartLinks) And (CurAnimIndex < EndLinks) Then
						CurAnimIndex = CurAnimIndex + 1
					End If
										
					If CurAnimIndex < StartLinks Then CurAnimIndex = StartLinks
					If CurAnimIndex > EndLinks Then CurAnimIndex = StartLinks
					'CurAnimFrame = FrameIndices[CurAnimIndex]
					CurAnimFrame = CurAnimIndex
				Else If Direction = 2 Then ' RECHTS
					If (CurAnimIndex >= StartRechts) And (CurAnimIndex < EndRechts) Then
						CurAnimIndex = CurAnimIndex + 1
					End If
										
					If CurAnimIndex < StartRechts Then CurAnimIndex = StartRechts
					If CurAnimIndex > EndRechts Then CurAnimIndex = EndRechts
					'CurAnimFrame = FrameIndices[CurAnimIndex]
					CurAnimFrame = CurAnimIndex
				End If

			End If
		'end if
		'---
		
		
		If (ai=0) And (fshowfirst=0) Then
			Direction = 0
			hideAntrieb

'			If KeyDown ( _KS ) And sready < 0 Then bullets.AddBullet(TBullet1.create(graphicsWidth()/2, graphicsHeight()/2, mwinkel#, 20, 250/4, 10, team, rot, blau, grun)) ; sready = 10
			
			MouseXSpeed = MouseXSpeed+MouseX()-GraphicsWidth()/2
			MouseYSpeed = MouseY()-GraphicsHeight()/2
			MoveMouse(GraphicsWidth()/2, GraphicsHeight()/2)

			If MouseXSpeed > 50 Then MouseXSpeed = 50
			If MouseXSpeed < -50 Then MouseXSpeed = -50
				
			If MouseXSpeed > 0 Then MouseXSpeed:-1
			If MouseXSpeed < 0 Then MouseXSpeed:+1
						
			If MouseDown(1) Then shoot
			If MouseDown(2) Then 
				AddSpeed() 'speed# = speed# + 50'gamemanager.FPS_Val(1000)
				'Antrieb.pAlphaDelta = -0.0499999982
				'showAntrieb
				playeffect motor
			End If

			If MouseXSpeed < 0 Then
				mwinkel# = mwinkel# - gamemanager.FPS_Val(200)
				If mwinkel < 0 Then mwinkel = 360
				Direction = 1			
			End If
			
			If MouseXSpeed > 0 Then
				If mwinkel > 360 Then mwinkel = 0
				mwinkel# = mwinkel# + gamemanager.FPS_Val(200)
				Direction = 2				
			End If
						
			If KeyHit(KEY_V) Then 'Tower ablegen
				If towers[0] > 0 Then
				'	Method spawnTower(x,y,winkel,index:Int)
					aktuellerLevel.gegner.spawntower(x,y,mwinkel,0)
					towers[0] :- 1				
				Else If towers[1] > 0 Then
					aktuellerLevel.gegner.spawntower(x,y,mwinkel,1)
					towers[1] :- 1
				End If
			End If
						

			If KeyDown ( _KS ) Then shoot

			'antrieb.pAlphaDelta = -1
			If KeyDown ( _KU ) Then 
				AddSpeed()
				'speed = maxspeed
				'speed# = speed# + 50   'gamemanager.FPS_Val(1000)
				'Antrieb.pAlphaDelta = -0.0499999982
				showAntrieb
				playeffect motor
			End If
			
			If KeyDown ( _KD ) Then 
				speed = -(maxspeed/2)
				'speed# = speed# - 50'gamemanager.FPS_Val(1000)
			End If

			If KeyDown ( _KR ) Then 			
				mwinkel# = mwinkel# + GameManager.FPS_Val(winkelSpeed)
				'mwinkel = turn(GameManager.FPS_Val(200))
				If mwinkel > 360 Then mwinkel = 0 + mwinkel-360
				Direction = 2
			End If			                                                      
			'hier
			If KeyDown ( _KL ) Then 
				mwinkel# = mwinkel# - GameManager.FPS_Val(winkelSpeed)
				'mwinkel = turn(GameManager.FPS_Val(-200))
				If mwinkel < 0 Then mwinkel = 360 + mwinkel
				Direction = 1
			End If
						
			
			'BOOSTER hier
			If KeyDown(KEY_LALT) Then
				If KeyDown(KEY_UP) Then
					turbo()
				End If
			End If


			'Waffe wechseln hier
			If KeyHit(KEY_C) Then
				Local a:Int = waffe
				While True
					If a < 8 Then a:+1 Else a = 1
					If waffenArsenal[a] = 1 Then
						playeffect(sGetGun)
						waffe = a
						Exit
					End If
				Wend
				
			End If
			

		End If
		

		

				
								
												
																
		'Splitscreen Spieler 2															
		If (ai=-1) And (fshowfirst=0) Then
			Direction = 0
			hideAntrieb

						
			If KeyHit(KEY_V) Then 'Tower ablegen
				If towers[0] > 0 Then
				'	Method spawnTower(x,y,winkel,index:Int)
					aktuellerLevel.gegner.spawntower(x,y,mwinkel,0)
					towers[0] :- 1				
				Else If towers[1] > 0 Then
					aktuellerLevel.gegner.spawntower(x,y,mwinkel,1)
					towers[1] :- 1
				End If
			End If
						

			If KeyDown (KEY_Q) Then shoot

			'antrieb.pAlphaDelta = -1
			If KeyDown (KEY_W) Then 
				AddSpeed()
				'speed = maxspeed
				'speed# = speed# + 50   'gamemanager.FPS_Val(1000)
				'Antrieb.pAlphaDelta = -0.0499999982
				showAntrieb
				playeffect motor
			End If
			
			If KeyDown (KEY_S) Then 
				speed = -(maxspeed/2)
				'speed# = speed# - 50'gamemanager.FPS_Val(1000)
			End If

			If KeyDown (KEY_D) Then 			
				mwinkel# = mwinkel# + GameManager.FPS_Val(winkelSpeed)
				'mwinkel = turn(GameManager.FPS_Val(200))
				If mwinkel > 360 Then mwinkel = 0 + mwinkel-360
				Direction = 2
			End If		
				                                                      
			'hier
			If KeyDown (KEY_A) Then 
				mwinkel# = mwinkel# - GameManager.FPS_Val(winkelSpeed)
				'mwinkel = turn(GameManager.FPS_Val(-200))
				If mwinkel < 0 Then mwinkel = 360 + mwinkel
				Direction = 1
			End If
						
			'BOOSTER hier
			If KeyDown(KEY_R) Then
				If KeyDown(KEY_W) Then
					turbo()
				End If
			End If


			'Waffe wechseln hier
			If KeyHit(KEY_E) Then
				Local a:Int = waffe
				While True
					If a < 8 Then a:+1 Else a = 1
					If waffenArsenal[a] = 1 Then
						playeffect(sGetGun)
						waffe = a
						Exit
					End If
				Wend
				
			End If
			

		End If
								
												
		
		
		'Speed regeln
		If speed# > 0 Then speed# = speed# - maxspeed/40 'Else speed = 0 'gamemanager.FPS_Val(5) Else speed# = 0
		
		'If speed# > maxspeed Then speed = maxspeed 'gamemanager.FPS_Val(maxspeed) Then speed = gamemanager.FPS_Val(maxspeed)
		If speed < 0 Then speed = speed + 50
		
		If speed < -(maxspeed/2) Then speed = -(maxspeed/2)
		'If speed > maxspeed Then speed = speed - 50 'wegen booster nicht direkt auf maxspeed setzen
		
		
'		If x# > GH Then x# = 0
'		If x# < 0 Then x# = GH
'		If y# > GW Then y# = 0
'		If y# < 0 Then y# = GW
		

		'stopuhr
		'sready = sready - 1
		'If sready < -1 Then sready = -1 
		'SetRotation 180
		Y# = Y# - Sin(mwinkel#) * GameManager.FPS_Val(speed#)
		x# = x# - Cos(mwinkel#) * GameManager.FPS_Val(speed#)

		
	
		'checkcollision()
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-update)")	
	End Try
		
	End Method
		
	
	Method turbo:Int()
		If boosterenergie > 0 Then
'			Antrieb.SetColor(30,80,230)		
			speed = maxspeed + 250
			If inViewport()=1
				playeffect sBoost
			End If
			boosterenergie :- GameManager.FPS_Val(10)
			Antrieb.SetColor(255,255,100)
			Return 1
		Else
			Return 0
		End If
	End Method
	
	
	Method turn(toturn#)
	Try
		winkel# = winkel# Mod 360
		winkel# = toturn# + winkel#
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-turn)")	
	End Try
	End Method 
	                        
	
	Method SetKeineWaffen()
		waffe=1    
        Local i:Int
		For i = 0 To waffenArsenal.length-1
			waffenArsenal[i] = 0
			waffenMun[i] = 0
		Next                
		waffenArsenal[1] = 1
		waffenMun[1] = -5
		
		'Field waffenArsenal[] = [0,1,0,0,0,0,0,0,0,0]
		'Field waffenMun[] = [0,-5,0,0,0,0,0,0,0,0]
	End Method 




	Method getFeindWinkel:Float()
	Try
		If meinfeind <> Null Then
		
'			Local divx# = GetX() - meinfeind.getx()
'			Local divy# = GetY() - meinfeind.gety()

			Local divx# = x - meinfeind.x
			Local divy# = y - meinfeind.y

			Local backw:Float=(ATan2(divy,divx)+360) Mod 360 

			Return backw
		Else
			Return mwinkel+90
		End If
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-getfeindwinkel")	
	End Try
	End Method


	
	Method Lookat(posx#,posy#)
	Try

		If gomwinkel > 0 Then
			gomwinkel :- 1	
			Return supertowinkel
		Else
								
			Local divx# = GetX() - posx#
			Local divy# = GetY() - posy#
			Local weg2# = ( divx# * divx# ) + ( divy# * divy# )
			weg2# = Sqr(weg2#)
			'DrawText "Divx#: "+divx#+" Divy#: "+divy#+ " Weg: "+weg#,x+50,y+50
			'Local toWinkel#=(ATan2(divy#,divx#)+360) Mod 360 
				
			Local toWinkel#=(ATan2(divy#,divx#)+360) Mod 360 
			'Local toWinkel#=ATan2(divy#,divx#)
		
			If towinkel > 360-GameManager.FPS_Val(winkelSpeed)-10 And towinkel <= 360 Then towinkel = 0
			If towinkel <= GameManager.FPS_Val(winkelSpeed)+10 Then towinkel = 0
		
			'If towinkel > 330 And towinkel <= 360 Then towinkel = 0
	'		If towinkel > 340 And towinkel <= 360 Then towinkel = 0
	'		If towinkel < 100 towinkel = 0

			supertowinkel = towinkel
			
			If posx = 0 And posy = 0 Then Return 400
			
			Return toWinkel#
		End If
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-lookat)")	
	End Try
	End Method
		
		
	Method damageCheck:Int(pdmg)
	Try    
		'return 1 = lebt noch
		'return 0 = tot
		Local testlife
		If schildStufe > 0 Then
			Return 1
		Else
			testlife = life - pdmg
			If testlife < 1 Then Return 0
		End If
		Return 1
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-damagecheck)")	
	End Try
	
		
	End Method	
	
		
		
	Method takedmg(pdmg)
	Try    
		If schildStufe > 0 Then
			schildEnergie = schildEnergie - pdmg
			If schildEnergie <= 0 Then schildStufe = 0
		Else
			life = life - pdmg
		End If
		If life > 0 Then
			If GetX() > 0 And GetX() < gfxOptions.gw And GetY() > 0 And GetY() < gfxOptions.gh Then
				'partikles.AddPartikel(TCustomEmitter.createFromFile("partikelIni/explode99.ini",sh.getx(),sh.gety()))
				'partikles.AddPartikel(TCustomEmitter.createFromFile("partikelIni/explode88.ini",sh.getx(),sh.gety()))
				'partikles.AddPartikel(TCustomEmitter.createExplode1(sh.getx(),sh.gety()))
				'partikles.AddPartikel(TCustomEmitter.createExplode2(sh.getx(),sh.gety()))
				Rem 
				schild.resetEmitter(getX()+cos(mwinkel)*(-6)-sin(mwinkel)*-15,   getY()+sin(mwinkel)*(-6)+cos(mwinkel)*-15)
				'schild.updateAll(getX()+cos(mwinkel)*(-25)-sin(mwinkel)*-10, getY()+sin(mwinkel)*(-25)+cos(mwinkel)*-10 , mwinkel)
				partikles.AddPartikel(schild)
				end rem 
				shieldshow=1
			End If		
		End If
		
		If life <= 0 Then
			SetKeineWaffen
			boosterEnergie = 0
		End If
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-takedmg)")	
	End Try
	End Method
	
	
	
	
	Method AddSpeed(delta#=0)
	Try
		showAntrieb
		speed = speed + maxspeed/8
		'speed = speed + delta	
		
		If ai > 0 Then speed = maxspeed
		
		If speed > maxspeed Then speed = speed - maxspeed/7
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-addSpeed)")	
	End Try
	End Method
	
	
	
	
	Method SubSpeed2(delta#=0)
	Try
		'speed = speed - delta
'		Drawsuper "subspeed",400,400 
		speed = 0
		If speed < -(maxspeed/2) Then speed = -(maxspeed/2)
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-subspeed2")	
	End Try
	End Method


	Method SubSpeed3(delta#=0)
	Try
		'speed = speed - delta
'		Drawsuper "subspeed",400,400 
		speed = speed - (maxspeed/2)
		If speed < (maxspeed/2) Then speed = (maxspeed/2)
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-subspeed2")	
	End Try
	End Method
		
	
		
	Method SubSpeed(delta#=0)
	Try
		'speed = speed - delta
'		Drawsuper "subspeed",400,400 
		speed = -(maxspeed/2)
		If speed < -(maxspeed/2) Then speed = -(maxspeed/2)
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-subspeed)")	
	End Try
	End Method

		 
	Method releaseShip()
	Try
		LuaScr.ShutDown()
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-releaseShip)")	
	End Try
	End Method
                         


	Method addlife(bon:Int)
		life = life + bon
		If life > urlife Then life = urlife
	End Method



	Method Updateai(shipList:TList)
	Try   
		If (dead = 0) And (fshowfirst = 0) Then
	
		Local sh:TShip
		Local tweg#
		Local tdivx#, tdivy#
	
		'weg = 30000
		
			' keine auslagerung:nur einmal durchlaufen und variablen speichern

			For sh:TShip = EachIn shiplist
				If sh <> Null Then
					If (sh.team <> team) And (sh.dead=0) Then
						'Local tdivx# = x# - sh.x#
						'Local tdivy# = y# - sh.y#
						tdivx# = GetX() - sh.GetX()
						tdivy# = GetY() - sh.GetY()
					
						'Abstandsgerade berechnen
						tweg# = (tdivx# * tdivx#) + (tdivy# * tdivy#)
						tweg# = Sqr(tweg#)
					
						'If tweg# < weg# Then
							weg# = tweg#
							tox# = sh.GetX()
							toy# = sh.GetY()
						'End If
						MeinFeind=sh
					End If 				
				End If
			Next
			
			For sh:TShip = EachIn shiplist
				If sh<>Null Then
					If (sh.team <> team) And (sh.dead=0) Then
						'Local tdivx# = x# - sh.x#
						'Local tdivy# = y# - sh.y#
						tdivx# = GetX() - sh.GetX()
						tdivy# = GetY() - sh.GetY()
					
						'Abstandsgerade berechnen
						tweg# = (tdivx# * tdivx#) + (tdivy# * tdivy#)
						tweg# = Sqr(tweg#)
					
						If tweg# < weg# Then
							weg# = tweg#
							tox# = sh.GetX()
							toy# = sh.GetY()
							MeinFeind=sh
						End If
					End If
				End If
			Next
		            
			toWinkel# = Lookat(tox#,toy#)
                                         
'			MeinFeind=sh

			
		If ai > 0 And ai <> 99 Then     
			
			Direction = 0
			
			
			AktuellerGegner=Self
			'lua_getglobal(LuaScr.m_lua_state, Self.name)
			lua_getglobal(LuaScr.m_lua_state, Self.name.toCString())
			
			
			SetRotation 0 'hier
			LuaScr.RunScript()
			
			'LuaScr.RunScriptFile("TestKI.lua") 
			AktuellerGegner=Null

			'Wegsuche-------------------
			If geheweg <> Null Then

				'Alle 20 Sekunden resetten um Problemen vorzubeugen
				If ASternZeit = 0 Then
					ASternZeit = MilliSecs()		
				Else
					If MilliSecs() > ASternZeit + 2000 Then 
						pnow = 0
						geheweg = Null							
						ASternZeit = 0
					End If
				End If
				'------------------------------------------
				
				
				If geheweg <> Null Then
			
	'				If (pnow < Len(geheWeg)-1) And (geheweg[pnow] <> Null) Then
					Local tox2:Float
					Local toy2:Float
					Local towinkel2:Float

					If (pnow <= aktuellerLevel.length) Then
						AddSpeed()
						
						'If pnow = 0 Then pnow = 1
									
						tox2 = (geheweg[pnow].x * aktuellerLevel.feldsize) - viewx
						toy2 = (geheweg[pnow].y * aktuellerLevel.feldsize) - viewy
						toWinkel2# = Lookat(tox2#,toy2#)
					
						'addspeed(50)
											
						'If (towinkel# > mwinkel# + GameManager.FPS_Val(winkelSpeed)) Or (towinkel# < mwinkel# - GameManager.FPS_Val(winkelSpeed)) Then 
						'	mwinkel# = mwinkel# + GameManager.FPS_Val(winkelSpeed)'1.5
						'	Direction = 2
						'End If

						Rem

						If towinkel2# > mwinkel# + 1 Then'+ GameManager.FPS_Val(winkelSpeed) Then '+GameManager.FPS_Val(winkelSpeed)+5 Then 
							mwinkel# = mwinkel# + GameManager.FPS_Val(inkelSpeed)'1.5
							If mwinkel > towinkel2 Then 
								mwinkel = towinkel2
							End If
							Direction = 2
							subspeed2()
						Else If towinkel2# < mwinkel# - 1 Then'- GameManager.FPS_Val(winkelSpeed) Then '-GameManager.FPS_Val(winkelSpeed)-5 Then 
							mwinkel# = mwinkel# - GameManager.FPS_Val(winkelSpeed)'1.5
							If mwinkel < towinkel2 Then
								mwinkel = towinkel2
							End If
							Direction = 1
							subspeed2()
						End If
						End Rem

						mwinkel = towinkel2

						'wenn sich gleiter in bereich +- 50 Pixel befindet eine pos weiterschalten
						If Sqr((geheweg[pnow].x*aktuellerLevel.feldsize - getx()-viewx) * (geheweg[pnow].x*aktuellerLevel.feldsize - getx()-viewx)) < 70 And Sqr((geheweg[pnow].y*aktuellerLevel.feldsize - gety()-viewy) * (geheweg[pnow].y*aktuellerLevel.feldsize - gety()-viewy)) < 70 Then
							pnow:+1
						End If
						
						'If aktuellerlevel.showpath = 1 Then
							'resetgfx()
							'SetColor 255,0,0
							'DrawText towinkel2, 500,500
							'DrawText mwinkel, 500,450
							'SetColor 255,255,255
						'End If
					Else
						pnow = 0
						geheweg = Null		
					End If		
					If towinkel2 > 360 Then towinkel2 = 0 + towinkel2 - 360
					If towinkel2 < 0 Then towinkel2 = 360 + towinkel2				
				End If
			End If

			'---------------------------

			If mwinkel > 360 Then mwinkel = 0 + mwinkel - 360
			If mwinkel < 0 Then mwinkel = 360 + mwinkel

			If towinkel > 360 Then towinkel = 0 + towinkel - 360
			If towinkel < 0 Then towinkel = 360 + towinkel

			


            Rem

			'-----------------------
			'Einfache State Machine
			'-----------------------
			
			
			Direction = 0
			
			'Einfache KI: wenn man hinter ihr ist hat man gewonnen
			
			If towinkel# > mwinkel# Then 
				mwinkel# = mwinkel# + GameManager.FPS_Val(winkelSpeed)'1.5
				Direction = 2
			End If
			
			If towinkel# < mwinkel# Then 
				mwinkel# = mwinkel# -GameManager.FPS_Val(winkelSpeed)'1.5
				Direction = 1	
			End If

			If mwinkel > 360 Then mwinkel = 0
			If mwinkel < 0 Then mwinkel = 360
			
			
			'SCHIESSEN
			If (towinkel# > mwinkel# - 10) and (towinkel# < mwinkel# + 10) and (weg# < 500) Then 
				'bullets.addbullet(Tbullet1.create(X, Y, mwinkel#, 20, 250/4, 10, team, rot, blau, grun))
				shoot
			End If

			hideAntrieb
			speed = maxspeed
					
			If weg# >= 150 Then
				AddSpeed(50)
			End If
			
			If weg# <= 150 and speed# > 2 Then 
				'subspeed(rnd(.05,1))  'speed# = speed# - Rnd(.05,.1)
			End If

			If weg# <= 150 and speed# < 2 Then 
				AddSpeed(Rnd(10,50))
			End If
			
			End Rem
			
		End If
		End If
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-updateai)")	
	End Try

	End Method
	                    
	
	
	
	Method LevelEnde(status:Int) '0=verloren, 1=gewonnen
		'AUFGABE ERFÜLLT	
		Try
		If levelschluss = 0 Then
			levelschluss = 1
		
			muckechannel.stop()
			If status = 1 Then
				'PlayEffect() 'WOHOOO oder sowas
				playeffect(LevelEndeS)

			Else If status = 0 Then
				'PlayEffect() 'möööööp
				'playeffect(scheissesound)
				playeffect(LevelEndeS)
			Else If status = 3 Then 'Spiel durchgespielt
				playeffect(LevelEndeS)											
			End If
						
					
			Local start = MilliSecs()
			While Not KeyHit(KEY_p)
    	        Cls
				setsuperfont()

				If status = 1 Then
					DrawMiddleX(getlang("AUFTRAG ERFUELLT"),GraphicsHeight()/2-50)
					'DrawMiddleX("ENTER DRUECKEN",GraphicsHeight()/2)
										
					levelFortschritt.setlevel(aktuellerLevel.id, gdifficulty+2)
					
					If istdemoversion = 1 Then
						If aktuellerlevel.id = 5 Then
							FlushKeys()
							FlushMouse()
							GameManager.PauseAndNew(New TMenuState, 99)
							
							While True
								Cls
								DrawMiddleX(getlang("DEMOVERSION ERFOLGREICH DURCHGESPIELT"),GraphicsHeight()/2-50)							
								If MilliSecs() > start + 3000 Then Exit
								Flip
							Wend
														
							Return
						End If
					End If
					
					
					If aktuellerLevel.id < 30 Then
						If istdemoversion=0 Then 
							levelFortschritt.openlevel(aktuellerLevel.id+1)
						Else
							If aktuellerLevel.id < 5 Then
								levelFortschritt.openlevel(aktuellerLevel.id+1)
							End If
						End If
					Else If aktuellerlevel.id = 30 Then
						resetgfx()
						Local height:Int
						If gfxoptions.getScaleFactor() = 1 Then
							SetImageFont levelfontg2
							height = levelfontg.height()
						Else
							SetImageFont levelfontg3
							height = levelfont.height()
						End If
									
						Local background:TImage = LoadImage("images/menutest_f.jpg")
						
									
						While Not MouseHit(1) 
							Cls			
							
							resetgfx()
							SetBlend lightblend
							SetAlpha 0.7#
							SetScale gfxOptions.getscaleFactor(),gfxOptions.getscaleFactor()
							DrawImage background,0,0
						
							resetgfx()
							SetColor 0,0,0
							SetBlend alphablend
							SetAlpha 0.5
						
							'DrawRect 0, 0, gfxoptions.scale(1024), gfxoptions.scale(768)
									
							resetgfx()
							Local start = 200
							DrawMiddleX(getlang("Herzlichen Glückwunsch!"),gfxoptions.scale(start))		
							DrawMiddleX(getlang("Du hast alle Herausforderungen bewältigt und bist der neue Champion."),gfxoptions.scale(start+50))		
							DrawMiddleX(getlang("Auf www.workisover.de wartet noch mehr Action auf Dich."),gfxoptions.scale(start+100))		
							DrawMiddleX(getlang("Es wird immer fleissig an Updates mit kostenlosen Zusatzlevels,"),gfxoptions.scale(start+150))		
							DrawMiddleX(getlang("Raumschiffen, Waffen und Bonus-Items gearbeitet. Wenn Du Ideen für"),gfxoptions.scale(start+200))		
							DrawMiddleX(getlang("neue Levels, Waffen usw hast, wären wir erfreut, wenn Du uns diese"),gfxoptions.scale(start+250))		
 							DrawMiddleX(getlang("mitteilst. Nur so können wir das Spiel verbessern."),gfxoptions.scale(start+300))		
							DrawMiddleX("",gfxoptions.scale(450))		

							DrawMiddleX(getlang("Klicke mit der Maus, um zum Spiel zurückzukehren"),gfxoptions.scale(start+400))		
															
							Flip																				
						Wend
						
						FlushKeys()
						FlushMouse()
						GameManager.PauseAndNew(New TMenuState,2)
						Return
					End If
					
				Else If status = 0 Then
					'levelFortschritt.openlevel(5)
												
					DrawMiddleX(getlang("AUFTRAG FEHLGESCHLAGEN"),GraphicsHeight()/2-50)
					'DrawMiddleX("ENTER DRUECKEN",GraphicsHeight()/2)
					
				Else If status = 3 Then
					'..
				End If  
			
				If MilliSecs() > start + 3500 Then Exit
			
				'FlushMem()
				Flip
			Wend		                               
		
			'zurück zum Menü
			'GameManager.NewGameState(New TMenuState,2)  
			
			GameManager.PauseAndNew(New TMenuState,2)

					   
		End If	
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TShip-LevelEnde")	
		End Try		
		
	End Method
	        
		
	
	
	'Schiff mit Startwerten neu initialisieren
	Method InitShip()
		Local aa:Int
		For aa:Int = EachIn towers
			aa = 0		
		Next
		
		DeathmatchDies = 0
		DeathmatchFrags = 0
		
		ausgeteilterSchaden = 0
		eingesteckterSChaden = 0

		
		dead = 0
		If autoSpawn = 0 Then 
			dead = 1
			fshowfirst = 1
		End If

		x = startx
		y = starty
		life = urlife 'gleiter.life
		
		SetDronenWaffe()
				
		'Aktueller Feind
		meinfeind = Null
				
		'Wegfindung
		geheweg = Null
		pnow = 0
				
		If ai = 0 Then
			If splitscreen = 1 Then
				ViewX = x-GraphicsWidth()/3
			Else
				ViewX = x-GraphicsWidth()/2
			End If
			ViewY = y-GraphicsHeight()/2
			viewSpeed = speed
			viewWinkel = mwinkel
		End If		
		
		
		If ai = -1 Then
			ViewX2 = x+GraphicsWidth()/2
			ViewY2 = y-GraphicsHeight()/2
			viewSpeed2 = speed
			viewWinkel2 = mwinkel
		End If
	End Method
		
	
		
			
	'Function Create:TShip(pname$,posx#,posy#,plife,pai,prot,pblau,pgrun,pteam,pschiff)
	Function Create:TShip(pname$,posx#,posy#,pteam,pai,pschiff:TGleiter, autoSpawn:Int, kiscript:String="ki/testKI.lua")
	Try
		'pai: 0 = Spieler
		
		'FlushMem()
		Local t:TShip = New TShip
	    t.gleiter = pschiff
		
		t.DeathmatchDies = 0
		t.DeathmatchFrags = 0
		t.ausgeteilterSchaden = 0
		t.eingesteckterSChaden = 0

		Local aa:Int
		For aa:Int = EachIn t.towers
			aa = 0		
		Next
		
						
		'hier
		If pai>0 And pai <> 99 Then
			t.LuaScr:ScriptEngine = New ScriptEngine
			t.LuaScr.AddFunction(KI_SHOOT, "shoot")
			t.LuaScr.AddFunction(KI_AddSpeed, "addspeed")
			t.LuaScr.AddFunction(KI_SubSpeed, "subspeed")     
			t.LuaScr.AddFunction(KI_Stop, "stop")     
			t.LuaScr.AddFunction(KI_GoLeft, "goleft")
			t.LuaScr.AddFunction(KI_GoRight, "goright")

			t.LuaScr.AddFunction(KI_GetX, "getx")
			t.LuaScr.AddFunction(KI_GetY, "gety")
			
			t.LuaScr.AddFunction(KI_GetVar, "getvar")
			t.LuaScr.AddFunction(KI_SetVar, "setvar")
			
			
			t.LuaScr.AddFunction(KI_GetEnemyDif, "getenemydif")
			t.LuaScr.AddFunction(KI_GetGegnerX, "getenemyx")
			t.LuaScr.AddFunction(KI_GetGegnerY, "getenemyy")
			t.LuaScr.AddFunction(KI_GetGegnerWinkel, "getenemywinkel")
			t.LuaScr.AddFunction(KI_GetWinkel, "getwinkel")
			t.LuaScr.AddFunction(KI_GetWeaponAmmo, "getweaponammo")
			t.LuaScr.AddFunction(KI_GetActualWeapon, "getactualweapon")
								  			    
			t.LuaScr.AddFunction(KI_GetWeaponRange, "getweaponrange")
			t.LuaScr.AddFunction(KI_GetShieldEnergy, "getshieldenergy")
			t.LuaScr.AddFunction(KI_GetBonusShieldEnergy, "getbonusshieldenergy")

			t.LuaScr.AddFunction(KI_GetStandardShield, "getstandardshield")
			t.LuaScr.AddFunction(KI_GetStandardBonusShield, "getstandardbonusshield")

			t.LuaScr.AddFunction(KI_GetEnemyShieldEnergy, "getenemyshieldenergy")
			t.LuaScr.AddFunction(KI_HaveWeapon, "haveweapon")
			t.LuaScr.AddFunction(KI_SetWeapon, "setweapon")

			t.LuaScr.AddFunction(KI_UseBooster, "usebooster")
			t.LuaScr.AddFunction(KI_GetBoosterEnergy, "getboosterenergy")


			t.LuaScr.AddFunction(KI_RouteClearToEnemy, "routecleartoenemy")
			t.LuaScr.AddFunction(KI_RouteClearToWinkel, "routecleartowinkel")

			t.LuaScr.AddFunction(KI_AStarOnline, "astaronline")
			t.LuaScr.AddFunction(KI_GOXY, "goxy")
			t.LuaScr.AddFunction(KI_GOITEM, "goitem")
			t.LuaScr.AddFunction(KI_GOENEMY, "goenemy")
			t.LuaScr.AddFunction(KI_StopGoing, "stopgoing")
			
			t.LuaScr.AddFunction(KI_ItemInLevel, "iteminlevel")
			t.LuaScr.AddFunction(KI_ItemVisible, "itemvisible")

			
			'script einladen
			Local filename:String = kiscript '"testKI.lua"
				
			Local file:TStream = ReadFile(filename)
			Local text:String=""
			If Not file Throw "could not open file " + filename
			Local temps:String=""
			While Not Eof(file)
				temps = ReadLine(file)
				temps = temps.tolower()
				temps = temps.Trim()

				If Chr(temps[0]) <> "/" Then
					text :+ temps + " "
				End If
			Wend
			CloseFile file
			
			
'	CreateFile ("kitestfile.txt")
'	Local file2:TStream
'	file2 = OpenFile ("kitestfile.txt")
'	WriteLine ( file2, text )
			
			
			t.LuaScr.SetScriptText(text, pname)
			
			lua_setglobal(t.LuaScr.m_lua_state, pname.tocString())
		End If
		
		't.entity = LoadImage("media/player1.png")
		't.schiff = pschiff
		
		t.autoSpawn = autoSpawn
		If t.autoSpawn = 0 Then 
			t.dead = 1
			t.fshowfirst = 1
		End If

		t.name = pname
		t.startX# = posx#
		t.startY# = posy#
		
		
		t.urlife = t.gleiter.life
		
		If (pai > 0) And (pai <> 99) And (pai <> 98) Then
		  If gdifficulty = 0 Then  
			t.life= t.gleiter.life/2
			t.urlife = t.life
		  Else If gdifficulty = 1 Then
			t.life = t.gleiter.life
			t.urlife = t.life
		  Else If gdifficulty = 2 Then
			t.life = t.gleiter.life+t.gleiter.life/2
			t.urlife = t.life
		  End If
		Else
			t.life = t.gleiter.life
			t.urlife = t.life
		End If
		
		
		
		t.ai = pai
		't.rot = prot
		't.blau = pblau
		't.grun = pgrun
		t.team = pteam
		
		
		
		If (pai > 0) And (pai <> 99) And (pai <> 98) Then
		  If gdifficulty = 0 Then  
			t.maxspeed = t.gleiter.maxspeed/1.5
		  Else If gdifficulty = 1 Then
			t.maxspeed = t.gleiter.maxspeed
		  Else If gdifficulty = 2 Then
			t.maxspeed = t.gleiter.maxspeed+t.gleiter.maxspeed/3
		  End If
		Else
			t.maxspeed = t.gleiter.maxspeed
		End If
		
		
		If (pai > 0) And (pai <> 99) And (pai <> 98) Then
		  If gdifficulty = 0 Then  
			t.winkelspeed = t.gleiter.winkelspeed/1.5
		  Else If gdifficulty = 1 Then
			t.winkelspeed= t.gleiter.winkelspeed
		  Else If gdifficulty = 2 Then
			t.winkelspeed= t.gleiter.winkelspeed+t.gleiter.winkelspeed/2
		  End If
		Else
			t.winkelspeed= t.gleiter.winkelspeed
		End If
		
		
		
		t.LoadImageR()
					
	
		t.geheweg = Null
		t.pnow = 0
	
	
		t.schild:TImage = LoadImage("images/schildi.png") 
		MidHandleImage(t.schild)
		
		
		
		'SetLineWidth(3)
		'DrawLine 5, 10, 15, 5
		'DrawLine 5, 10, 15, 15
		'DrawOval 2, 2, 8, 8
		'Plot 5,0
		'GrabImage t.entity, 0, 0
		'Cls
		'Flip
		
		SetImageHandle(t.Image, 38, 38)
		'SetScale 1,1
		
'		ListAddLast sh_list, t
'		If pschiff = 0 Then
'			t.Antrieb:TCustomEmitter = TCustomEmitter.createFromFile("partikelini/antrieb2.ini",t.GetX(),t.GetY())
'		Else If pschiff = 1 Then
'			t.Antrieb:TCustomEmitter = TCustomEmitter.createFromFile("partikelini/antrieb2.ini",t.GetX(),t.GetY())
'		Else If pschiff = 2 Then
'			t.Antrieb:TCustomEmitter = TCustomEmitter.createFromFile("partikelini/antrieb2.ini",t.GetX(),t.GetY())
'		Else
			
		
		If t.ai <> 99 And t.ai <> 98 Then
			t.Antrieb:TCustomEmitter = TCustomEmitter.createFromFile("partikelini/antrieb2.ini",t.GetX()+Cos(0)*(-15)-Sin(0)*-11, t.GetY()+Sin(0)*(-15)+Cos(0)*-11)		
		End If
			'Antrieb.updateAll(GetX()+Cos(mwinkel)*(-15)-Sin(mwinkel)*-11, GetY()+Sin(mwinkel)*(-15)+Cos(mwinkel)*-11 , mwinkel)

'		End If
		
		t.explode1 = TCustomEmitter.createFromFile("partikelIni/explode999.ini",t.GetX(),t.GetY())
		t.explode2 = TCustomEmitter.createFromFile("partikelIni/explode88.ini",t.GetX(),t.GetY())
		
		If t.ai > 0 Then
			't.schild = TCustomEmitter.createFromFile("partikelIni/schild1.ini",t.getx(),t.gety())
		Else
			't.schild = TCustomEmitter.createFromFile("partikelIni/schild1.ini",t.getx(),t.gety())
		End If	
		
		t.erscheinung = TCustomEmitter.createFromFile("partikelIni/erscheinung.ini",t.GetX(),t.GetY())
		t.muendungsfeuer = TCustomEmitter.createFromFile("partikelIni/muendung1.ini",t.GetX(),t.GetY())
       		
		t.SetDronenWaffe()
				
		If t.ai = 0 Then
			If splitscreen = 0 Then
				ViewX = t.x-GraphicsWidth()/2
			Else
				ViewX = t.x-GraphicsWidth()/3
			End If
			
			ViewY = t.y-GraphicsHeight()/2
			viewSpeed = t.speed
			viewWinkel = t.mwinkel
		End If		
			
		If t.ai = -1 Then
			ViewX2 = t.x+GraphicsWidth()/3
			ViewY2 = t.y-GraphicsHeight()/2
			viewSpeed2 = t.speed
			viewWinkel2 = t.mwinkel
		End If		
			
			
		Return t
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShip-create)")	
	End Try
	End Function



	Method SetDronenWaffe()
		'Drone1 hat Laser
		'Drone2 (7) hat Powerlaser
		
		If gleiter.gleiterID = 7 Then 'Powerlaser
			waffenArsenal[2] = 1
			waffenMun[2] = -5
			waffe = 2
		End If

		If gleiter.gleiterID = 15 Then 'Tower 2
			waffenArsenal[2] = 1
			waffenMun[2] = -5
			waffe = 2
		End If
										
		If gleiter.gleiterID = 9 Then 'Triplelaser
			waffenArsenal[3] = 1
			waffenMun[3] = -5
			waffe = 3
		End If
		
		If gleiter.gleiterID = 10 Then 'Flamer
			waffenArsenal[5] = 1
			waffenMun[5] = -5
			waffe = 5
		End If

		If gleiter.gleiterID = 11 Then 'Target Gun
			waffenArsenal[7] = 1
			waffenMun[7] = -5
			waffe = 7
		End If
		
	End Method

End Type

            



Type TShips
	Field sh_list:TList
	
	Function Create:TShips()
	Try
		Local s:TShips = New TShips                  
		s.sh_list = CreateList()
		Return s
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShips-create)")	
	End Try
	End Function
	
	
	Method spawnTower(x,y,winkel,index:Int)
		'id 14 und 15
		Local ss:TShip
		For ss:TShip = EachIn sh_list
			If index = 0 Then
				If ss.gleiter.gleiterid = 14 And ss.dead=1
					ss.startx = x
					ss.starty = y
					ss.spawn(winkel)
					Return
				End If
			Else If index = 1 Then
				If ss.gleiter.gleiterid = 15 And ss.dead=1
					ss.startx = x
					ss.starty = y
					ss.spawn(winkel)
					Return
				End If
			End If
		Next
	End Method
	
	
	
	Method releaseAllShips()
	Try
		sh_list.Clear
		'FlushMem()
		Rem 
		local sh:TShip
		For sh:tship = EachIn sh_list
			ListRemove(sh_list, sh)
			FlushMem()
		next
		end rem 
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShips-releaseAllShips)")	
	End Try
	End Method
	
	
	Method AddShip(ship:TShip)
	Try
		ListAddLast sh_list, ship
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShips-AddShip)")	
	End Try
	End Method
	
	
	Method Update(DeltaTime:Int)
	Try
		Local sh:TShip
		Local sh2:TShip
		For sh:TShip = EachIn sh_list
			
			If (sh<>Null) And (sh.ai <> 99) Then
				
							
				If (sh.dead=0) And (sh.fshowfirst=0) Then
					sh.Update(DeltaTime:Int)
					sh.Updateai(sh_list)
					sh.checkDead()
					
					If aktuellerLevel.showradar = 1 Then
						'Radar-Test für eine Arena-Größe von 3000*3000
						Local xx:Double
						Local yy:Double
			
						Local divx:Double
						Local divy:Double
		'				if sh.x > 0 then xx = (sh.x/30)+100 else xx = (sh.x/30)+100
	'					if sh.y > 0 then yy = (sh.y/30)+100 else yy = (sh.y/30)+100

						divx = aktuellerLevel.arena.lwidth/100
						divy = aktuellerLevel.arena.lheight/100
						xx = sh.x/divx + radarDeltaX
						yy = sh.y/divx + radarDeltaY
						
						SetColor 255,255,255
						If sh.ai > 0 And sh.ai <> 99  And sh.ai <> 98 Then SetColor 255,0,0
						
						'setcolor sh.rot,sh.grun,sh.blau
						SetAlpha 1
						SetRotation 0
						DrawOval xx,yy,4,4
						'-------
					End If
					
			
					'Abgrenzung einhalten
					If sh.x > aktuellerLevel.arena.lwidth-170 Then 
						'sh.x = aktuellerLevel.arena.lwidth-100
						sh.x = aktuellerLevel.arena.lwidth-170
					End If
					
					If sh.Y > aktuellerLevel.arena.lheight-215 Then
						'sh.Y = aktuellerLevel.arena.lheight-100
						sh.Y = aktuellerLevel.arena.lheight-215
					End If
					
					If sh.x < 145 Then
						'sh.x = 100
						sh.x = 145
					End If
					
					If sh.Y < 105 Then 
						'sh.Y = 100
						sh.Y = 105
					End If
					
				End If						            
						
				sh.show()
										
				'FlushMem()
			End If
 		Next
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShips-update)")	
	End Try
 	End Method



	Method Update99(DeltaTime:Int) '
	Try
		Local sh:TShip
		Local sh2:TShip
		For sh:TShip = EachIn sh_list
			
			If (sh<>Null) And (sh.ai = 99) Then
				
							
				If (sh.dead=0) And (sh.fshowfirst=0) Then
					sh.Update(DeltaTime:Int)
					sh.Updateai(sh_list)
					sh.checkDead()
					
					
					If aktuellerLevel.showradar = 1 Then
						'Radar-Test für eine Arena-Größe von 3000*3000
						Local xx:Double
						Local yy:Double
			
						Local divx:Double
						Local divy:Double
		'				if sh.x > 0 then xx = (sh.x/30)+100 else xx = (sh.x/30)+100
	'					if sh.y > 0 then yy = (sh.y/30)+100 else yy = (sh.y/30)+100

						divx = aktuellerLevel.arena.lwidth/100
						divy = aktuellerLevel.arena.lheight/100
						xx = sh.x/divx + radarDeltaX
						yy = sh.y/divx + radarDeltaY
						
						SetColor 255,255,255
						If sh.ai > 0 And sh.ai <> 99 Then SetColor 255,0,0
						'setcolor sh.rot,sh.grun,sh.blau
						SetAlpha 1
						SetRotation 0
						DrawOval xx,yy,4,4
						'-------
					End If
					
			
					'Abgrenzung einhalten
					If sh.x > aktuellerLevel.arena.lwidth sh.x = aktuellerLevel.arena.lwidth-100
					If sh.Y > aktuellerLevel.arena.lheight sh.Y = aktuellerLevel.arena.lheight-100
					If sh.x < 55 sh.x = 100
					If sh.Y < 55 sh.Y = 100
				End If						            
						    
						
				sh.show()
										
				'FlushMem()
			End If
 		Next
	Catch ex:Object
		RuntimeError(ex.ToString() + " TShip-TShips-update)")	
	End Try
 	End Method
End Type
       




       
	            


	
         
  

Rem 
type TExplosion
	field x
	field y
	field lifetime	
	field gamespeed
		
	function create:TExplosion(ax,ay, alifetime:Int)
		local ex:TExplosion = new TExplosion
		ex.x = ax
		ex.y = ay
		ex.lifetime = alifetime	
		return ex
	End Function

	method getlife:Int()
		return lifetime
	End Method
	
	
	method update()
		GameSpeed = GetGameSpeed(60)
		SetEmitterPosition(raumschiff,x-viewx,y-viewy)
		PlayEmitter(raumschiff)
'		SetEmitterPosition(implusion1,x-viewx,y-viewy)
'		PlayEmitter(implusion1)
		IdleEmitters(gamespeed)
		lifetime = lifetime - 1
		ResetStates()
	End Method
End type


type TExplosions
	field exp_list:TList
	
	function create:TExplosions()
		local s:TExplosions = new TExplosions
		s.exp_list = CreateList()
		return s
	End Function
	
	method AddExplosion(Explosion:TExplosion)
		ListAddLast exp_list, explosion
	End Method
	
	method update()
		local ex:TExplosion
		For ex:TExplosion = EachIn exp_list
			'ex.checkCollision(ships.sh_list)
			ex.update()
			'ex.draw()
			If ex.getlife() < 0 Then
				ListRemove(exp_list, ex)
				FlushMem()
			End If
 		Next
 	End Method
End type

end rem 
           
                 
Function DrawMiddleX(text:String,Y:Int)  
    Local ax:Int=0
	Local diff:Int = GraphicsWidth() - TextWidth(text)
	If diff > 0 Then
		ax = ax + diff/2
	End If              
	DrawText(text,ax,Y)
End Function    
           
Function DrawMiddle(text:String,x,Y, length:Int)    
	'SetImageFont superfont
	Local ax = x
	Local diff:Int = text.length - TextWidth(text)
	If diff > 0 Then
		ax = ax + diff/2
	End If              
	DrawText(text,ax,Y)
End Function         
           
                 
'Function setSuperFont()
'	resetgfx()
'	SetImageFont gamefont
'End Function         


Function setsuperfont(scaler:Int = 1)
	resetgfx()
	If scaler = 2 Then SetScale 1.5,1.5
	If gfxoptions.getscalefactor() = 1 Then
		SetImageFont gamefont
	Else
		SetImageFont gamefont8
	End If
End Function

           
Function DrawSuper(t$, x, Y,red=0)
	resetgfx()
	If red=1 Then 
		SetScale 1,1
	Else If red = 2 Then
		SetScale 1.5,1.5
	End If
	If gfxoptions.getscalefactor() = 1 Then
		SetImageFont gamefont
	Else
		SetImageFont gamefont8
	End If
    SetColor 0, 0, 0
    DrawText t$, x + 6, Y + 6
	SetColor 255,255,255
	If red = 2 Then SetColor 255,0,0
	SetBlend LIGHTBLEND
	DrawText t,x,Y
End Function


Function DrawShadowText (t$, x, Y)
      SetColor 0, 0, 0
      DrawText t$, x + 5, Y + 5
      SetColor 255, 255, 255
      DrawText t$, x, Y
	  
	  'zurücksetzen
	  'setcolor
	  '
End Function

