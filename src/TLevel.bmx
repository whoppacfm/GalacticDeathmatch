
'


'global testIm:TImage = loadimage("images/stationn.png")

'TSpielmodus -> TLevel -> TArena -> TTile                                   
             
            
Type TSpielmodi
	Field modi:TList  
	Function Create:TSpielmodi()
		Local Spielmodi:TSpielmodi = New TSpielmodi
		spielmodi.modi = CreateList() 
		Return Spielmodi
	End Function    
	
	Method AddSpielmodus(modus:TSpielmodus)
		modi.AddLast(modus)
	End Method
End Type         
              

Type TSpielmodus 
	Field Bezeichnung:String
	Field Levels:TList 'TLevel
	Field Beschreibung:String                           
	
	Function Create:TSpielmodus(Bezeichnung:String,Beschreibung:String)
		Local Spielmodus:TSpielmodus = New TSpielmodus
		spielmodus.Levels = CreateList() 
		spielmodus.Beschreibung = Beschreibung
		spielmodus.Bezeichnung = Bezeichnung 
		
		Return Spielmodus
	End Function      
		
	Method AddLevel(level:TLevel)
		Levels.AddLast(level)
	End Method	
End Type
                  
    
    

Type TLevel 
	Field id:Int  
	Field f1away:Int
	Field Bezeichnung:String     
	Field Beschreibung:String     
	Field Arena:TArena    
	Field arenaFilename:String
	Field Gegner:TShips 
	Field Items:TBonusItems    
	Field stand:Int
	Field startZeit:Int
	Field DrawLevel:String 'String der in der Mitte, Oben am Bildschirm gemalt wird
	Field DrawTraining:String[12]
	Field drawtrainingB:Int
	Field drawlevelx:Int
	Field drawlevely:Int
	Field drawred:Int
	Field showradar:Int
	
	Field playerx:Int
	Field playery:Int

	
	
	'Wegsuche
	Field pathFinder:TAStar
	Field path:TPosition[]
	Field length:Int
	Field length2:Int
	Field showPath:Int=0
	Field feldsize:Int=50
	'---


		
	'Jedem Level wird Update-Funktion mitgegeben, die besagt was im Level passiert
	Field updateLevel:Byte Ptr
	Method DoUpdateLevel(lev:TLevel)
		If startzeit=0 Then startzeit = MilliSecs()
		Local locfunc(lev:TLevel)=updateLevel
		locfunc(Self)
		
		If KeyHit(key_o) Then
			TShip(gegner.sh_list.Last()).LevelEnde(1)		
		End If
		
	EndMethod			
	'Wird von jedem Level implementiert----------------------

		
	'Jedem Level wird Init-Funktion mitgegeben für enemies und items
	Field initLevel:Byte Ptr
	Method DoInitLevel(lev:TLevel)
		Local locfunc(lev:TLevel)=initLevel
		locfunc(Self)
	EndMethod			
	'Wird von jedem Level implementiert----------------------
		
		
	Method freeDrawTraining()
		Local i
		For i = 0 To Len(drawtraining)-1
			drawtraining[i] = ""		
		Next
	End Method
		
			
	Function Create:TLevel(id:Int,Bezeichnung:String,Beschreibung:String,ArenaFile:String,updateF:Byte Ptr, initL:Byte Ptr)
		Local level:TLevel = New TLevel
		level.updateLevel = updateF
		level.initLevel = initL
		level.Bezeichnung = Bezeichnung
		level.Beschreibung = Beschreibung
		level.arenaFilename = ArenaFile
		level.stand = 0
		level.startZeit = 0
		level.drawlevel = ""
		level.freeDrawTraining()
		level.id = id
		
		level.drawred = 0
		
		level.playerx = 200
		level.playery = 200
		Return level
	End Function
	            
	
	Method freeLevel()	
		partiklesOver.exp_list.clear()
		partikles.exp_list.clear()
		bullets.bu_list.clear()
		
		items.bonusitems.clear()
		gegner.sh_list.clear()

		Arena.freearena()  
		pathFinder=Null
		path=Null
		
		'FlushMem()
	End Method
	
	
	'Für Start initialisieren
	Method Init()
		mainscale = 1

		drawtrainingb = 0
		f1away=0

		levelschluss = 0
		Gegner = TShips.Create()
		Items = TBonusItems.Create()
	
		DrawLevel = ""
		freeDrawTraining()
		DrawRed = 0
	
		DoInitLevel(Self)
		


		showradar = 0
		
		stand = 0
		startZeit = 0
		Arena = TArena.createFromFile(arenaFilename)
		stand = 0

		Local bi:TBonusitem
		For bi:TBonusitem = EachIn items.bonusitems
			bi.show = 1
		Next

		Local sh:TShip
		For sh:TShip = EachIn gegner.sh_list
			sh.initship()
		Next
		
		lastcall = 0
		bullets.clear()
		
		initAStar(round(arena.lwidth/feldsize))
	End Method



	Method DrawPath()
		If showpath = 1 Then
			resetgfx()	
			SetBlend alphablend
			SetAlpha 0.6
			Local i,j
			For i = 0 To MAPSIZE-1
				For j = 0 To MAPSIZE-1
					'SetAlpha 0.5
					'SetColor 255-map[i,j],255-map[i,j],255-map[i,j]
					'DrawRect ((i*feldsize)-viewx,(j*feldsize)-viewy,feldsize,feldsize)
					'SetAlpha 1
					'DrawText map[i,j], (i*feldsize)-viewx, (j*feldsize)-viewy
					
					'SetScale 0.1,0.1
					'DrawText i + "/" + j, (i*feldsize)-viewx, (j*feldsize)-viewy

					'Const MARKED_NONE = 0
					'Const MARKED_OPEN = 1
					'Const MARKED_CLOSE = 2
					
					
					If marked[i,j] = 1 Then
						SetColor 0,255,0
						DrawOval((i*feldsize)-viewx, (j*feldsize)-viewy,10,10)
					Else If marked[i,j] = 2 Then
						SetColor 0,0,255
						DrawOval((i*feldsize)-viewx, (j*feldsize)-viewy,10,10)
					End If
					
					resetgfx()	
					SetBlend alphablend
					SetAlpha 0.6
					
					If map[i,j] = 255 Then
						'SetAlpha 0.4
						DrawRect (i*feldsize)-viewx, (j*feldsize)-viewy, feldsize,feldsize
						'SetAlpha 1
					End If
				Next
			Next
			
			SetColor 255,0,0
			'DrawOval(200-viewx,500-viewy,30,30)	
			Local posi:TPosition
			Local start=0
			For posi:TPosition = EachIn path
				If start = 0 Then
					SetColor 0,255,0
					SetScale 2,2
					start=1
				Else
					SetScale 1,1
					SetColor 255,0,0
				End If
				DrawOval((posi.x*feldsize)-viewx, (posi.y*feldsize)-viewy,30,30)				
			Next
			SetAlpha 1
		End If
	End Method
		



	Method initAStar(msize:Int)
		If pathfinder <> Null Then
			pathfinder.pqueue = Null
			pathfinder.masternodelist = Null
		End If
		pathFinder=Null
		path=Null
		length=0
		length2=0
		showPath=0
			
		mapsize = msize
		map = New Byte[msize,msize]
		marked = New Byte[msize,msize]
	
	'  - rotation miteinrechnen
	'  - 255 und 0 werden in AStern umgekehrt? stimmt das so?
	
		pathfinder = TAStar.create2()
		'mapsize = Int(arena.lwidth/Feldsize)
		
		Local i:Int
		Local j:Int
		Local k:Int

		'Frei machen -> auf 23 setzen
		For i = 0 To MAPSIZE-1
			For j = 0 To MAPSIZE-1
				map[i,j] = 23
			Next
		Next

		'Prüfen welche Felder belegt sind		
		For i = 0 To Len(arena.tilesG) - 1
			'TTile(arena.tilesG[i]).rotation		

			'Alle Pixel prüfen 
			Local gx:Int = TTile(arena.tilesG[i]).tx '- round(TTile(arena.tilesG[i]).tilewidth/2)
			Local gy:Int = TTile(arena.tilesG[i]).ty '- round(TTile(arena.tilesG[i]).tileheight/2)
			Local gwidth:Int = TTile(arena.tilesG[i]).tilewidth
			Local gheight:Int = TTile(arena.tilesG[i]).tileheight
			
'			map[round(gx/Feldsize), round(gy/Feldsize)] = 255	

'			For j = gx To gx + gwidth + 100
'				map[round(j/Feldsize), round(gy/Feldsize)] = 255	
'			Next 

			
			For j = gx To gx + gwidth 
				For k = gy To gy + gheight

					'j und k mit Rotation berechnen
					Local rot = TTile(arena.tilesG[i]).rotation

					Local b = j '+ round(TTile(arena.tilesG[i]).tilewidth/2)
					Local n = k '+ round(TTile(arena.tilesG[i]).tileheight/2)

'					Local b = j + Cos(rot) * round(TTile(arena.tilesG[i]).tilewidth/2)

'					Local n = k + Sin(rot) * round(TTile(arena.tilesG[i]).tileheight/2)

					'rot = 90
					
'					b = b + Cos(rot) * (b-gx)'(b-gx+round(gwidth/2)) '- Sin(rot)* (n-gy+round(gheight/2))
'					n = n + Sin(rot) * (n-gy)'(n-gy+round(gheight/2)) '+ Cos(rot)* (b-gx+round(gwidth/2))

					'b = b + Cos(rot) * (b-gx) - Sin(rot) * (b-gx)
					'n = n + Sin(rot) * (n-gy) + Cos(rot) * (n-gy)
						
					'Abstand von b/n zu gx/gy
					'Local abstand:Int = Sqr(((b - gx)*(b - gx)) + ((n - gy)*(n - gy)))
					
'					If rot > 0 Then
						'Abstand des zu rotierenden Pixels vom Rotationszentrum berechnen

						
					Local abstand:Int = Sqr(((b - gx - round(gwidth/2))*(b - gx- round(gwidth/2))) + ((n - gy - round(gheight/2))*(n - gy - round(gheight/2))))
					'Local abstand:Int = Sqr(((b - gx)*(b - gx)) + ((n - gy)*(n - gy)))



'						Local abstand:Int = Sqr(((b - gx)*(b - gx)) + ((n - gy)*(n - gy)))
						
'						Local abstand:Int = Sqr(((b - gx - round(gwidth/2))*(b - gx- round(gwidth/2))))
'						Local abstand2:Int = Sqr(((n - gy - round(gheight/2))*(n - gy - round(gheight/2))))


' 						Local abstand:Int = Sqr(((b - gx - round(gwidth/2))*(b - gx- round(gwidth/2))))
'						Local abstand2:Int = Sqr(((n - gy - round(gheight/2))*(n - gy - round(gheight/2))))


						'b = b + Cos(rot) * (-round(TTile(arena.tilesG[i]).tilewidth)) + Sin(rot) * (-round(TTile(arena.tilesG[i]).tilewidth))
						'n = n - Sin(rot) * round(TTile(arena.tilesG[i]).tileheight)


'						todo:						
'						rotation:  0 -> muss weiter nach links
'						rotation: 90 -> muss weiter nach rechts
'										muss weiter nach oben

							
						b = gx + Cos(rot) * abstand
						n = gy + Sin(rot) * abstand
						
						
							If rot = 0 Then 
								b = b - 50
								n = n + 15
							End If
							
							If rot = 90 Then 
								n = n - 50
								b = b + 1
							End If

'						n = n - Sin(rot) * round(TTile(arena.tilesG[i]).tileheight)
					
						
						'Problem warum nur eine mittlere reihe: ich hab b und n
						'nicht mit eingerechnet-> gingen verloren -> von gx aus gerechnet !!!
																		
'						b = gx + Cos(rot) * abstand
'						n = gy + Sin(rot) * abstand2
						'b = gx + Cos(rot) * abstand - Sin(rot) * abstand
						'n = gy + Sin(rot) * abstand + Cos(rot) * abstand
						'n = n - 50
						
						
'					End If

					'Auf Feldkoordinaten umrechnen und auf "belegt" setzen
					Local ax = round(b/Feldsize)
					Local ay = round(n/Feldsize)
					
					
					'ax = round(j/feldsize)
					'ay = round(k/feldsize)
					'If ax >= 0 And ax < mapsize And ay >= 0 And ay < mapsize Then
					'map[ax,ay] = 255
					'End If
					'Continue
					
					
					If ax >= 0 And ax < mapsize And ay >= 0 And ay < mapsize Then
						map[ax,ay] = 255
					End If
					
					If ax+1 >= 0 And ax+1 < mapsize And ay >= 0 And ay < mapsize Then
						map[ax+1,ay] = 255
					End If						
	
					If ax >= 0 And ax < mapsize And ay+1 >= 0 And ay+1 < mapsize Then
						map[ax,ay+1] = 255
					End If
									
					If ax+1 >= 0 And ax+1 < mapsize And ay+1 >= 0 And ay+1 < mapsize Then
						map[ax+1,ay+1] = 255
					End If

					If ax-1 >= 0 And ax-1 < mapsize And ay >= 0 And ay < mapsize Then
						map[ax-1,ay] = 255
					End If
															
					If ax >= 0 And ax < mapsize And ay-1 >= 0 And ay-1 < mapsize Then
						map[ax,ay-1] = 255
					End If				

					If ax-1 >= 0 And ax-1 < mapsize And ay-1 >= 0 And ay-1 < mapsize Then
						map[ax-1,ay-1] = 255
					End If
										
					If ax+1 >= 0 And ax+1 < mapsize And ay-1 >= 0 And ay-1 < mapsize Then
						map[ax+1,ay-1] = 255
					End If
											
					If ax-1 >= 0 And ax-1 < mapsize And ay+1 >= 0 And ay+1 < mapsize Then
						map[ax-1,ay+1] = 255
					End If						

				Next
			Next
			
		Next
	End Method


	'Pfad berechnen -> zurückliefern
	Method GetPath:TPosition[](start1:TPosition,End1:TPosition)
		'Local start:TPosition = New TPosition
		'start.x = 30
		'start.y = 30
		'Local end1:TPosition = New TPosition
		'end1.x = 1
		'end1.y = 1

		'Wenn Zielknoten nicht begehbar ist, soll A* überhaupt nicht suchen
		'sonst würde es alle möglichen Knoten im Level expandieren -> Ruckelorgie
		If map[End1.x,End1.y] = 255 Then Return Null
		
		

		If showpath = 1 Then
			Local i
			Local j
			For i = 0 To MAPSIZE-1
				For j = 0 To MAPSIZE-1
					marked[i,j] = 0			
				Next
			Next
		End If				
		
		Local pa:TPosition[]
		
		If (start1.x >= 0) And (start1.x < mapsize) And (end1.x >= 0) And (end1.x < mapsize) And (start1.y >= 0) And (start1.y < mapsize) And (end1.y >= 0) And (end1.y < mapsize) Then

			pathFinder.init(start1,end1)

			length = pathfinder.searchpath()

			If length <> -1 Then
				'pfad gefunden
				pa = New TPosition[length+2]      'path = New Position[ length + 2 ];
				length = pathfinder.getpath(pa)
				path = pa
				'path2 = 
				'length = pathfinder.reducepath(path2,path,length)
				
				
				Return pa
			Else
				Return Null
			End If
		Else
			Return Null
		End If
	End Method		
	
	
	
	'Pfad berechnen -> in Variable "path" ablegen
	Method SetPath(start:TPosition,End1:TPosition)
		'Local start:TPosition = New TPosition
		'start.x = 30
		'start.y = 30
		'Local end1:TPosition = New TPosition
		'end1.x = 1
		'end1.y = 1

				If showpath = 1 Then
					Local i
					Local j
					For i = 0 To MAPSIZE-1
						For j = 0 To MAPSIZE-1
							marked[i,j] = 0			
						Next
					Next
				End If

	
		
				
		pathFinder.init(start,end1)
		length = pathfinder.searchpath()
			
		If length <> -1 Then
			'pfad gefunden
			path = New TPosition[length+2]      'path = New Position[ length + 2 ];
			length = pathfinder.getpath(path)

			'path2 = 
			'length = pathfinder.reducepath(path2,path,length)
		End If
	End Method	
	
End Type
             
	

Type TArena
	Field lwidth:Int 'pixelbreite
	Field lheight:Int 'pixelhöhe
	Field tilesB:TTile[]
	Field tilesU:TTile[]
	Field tilesG:TTile[]
	Field tilesO:TTile[]
	Field backgroundPath:String
	Field backgroundimage:TImage
	Field showSterne:Int=0 '0/1
		
	
	Method freeArena()
		tilesB=Null
		tilesU=Null
		tilesG=Null
		tilesO=Null
		backgroundimage = Null
	End Method
		
		
	Function createFromFile:TArena(filename:String)
		Local level:TArena = New TArena
		'array: dynamisch länge ändern? 
		'sonst: erst zeilen zählen die <> "" und bei denen [0] <> / und zum schluss - 1
	
		Local file:TStream = ReadFile(filename)
		If Not file Throw "could not open file " + filename

		Local counter:Int = 0
		While Not Eof(file)
			Local feld$ = ReadLine(file)
			Local Strip:String[]

			'erste zeile einlesen
			If counter = 0 Then
				Strip = Return_Strip(feld,",")
				level.lwidth = Int(strip[0])
				level.lheight = Int(strip[1])
				level.backgroundPath = strip[2]
				level.backgroundimage = LoadImage(level.backgroundPath)				
				counter = 2						
				Continue				
			End If
								
			If feld.Trim() = "" Then Continue 
			If feld.Trim() = " " Then Continue 
			If feld.find("/",0) = 0 Then Continue
			
			Strip = Return_Strip(feld,",")
			
			
			'DrawCage
			If strip[0].tolower() = "drawcage" Then
				'function create:TTile(imagepath:string, lage, alpha#, blend, rot, gruen, blau, rotation, animiert, tilewidth, tileheight, tilemax, scalex#, scaley#, tx,ty)
				'						imagepath animiert tilewidth tileheight tilemax scaleX scaleY lage alpha blend rot gruen blau rotation tx ty rotationspeed
				'							0		 1			2		3			4 		5	  6 	7	  8		9	10	11    12   13      14 15 			16
				Local i,j:Int
				Local erg:Int
				
				'vertikale tiles erstellen
				erg = level.lheight/Int(strip[15])
				'level.tilesg =level.tilesg[..Len(level.tilesg)+1]
				For i = 0 To erg-1
					level.tilesG =level.tilesG[..Len(level.tilesG)+1]
					level.tilesG[Len(level.tilesG)-1] = TTile.Create(strip[1],Int(strip[8]),Float(strip[9]),Int(strip[10]),Int(strip[11]),Int(strip[12]),Int(strip[13]),Int(strip[14])+90,Int(strip[2]),Int(strip[3]),Int(strip[4]),Int(strip[5]),Float(strip[6]),Float(strip[7]),Int(strip[16]),i*Int(strip[15]),0)
					level.tilesG =level.tilesG[..Len(level.tilesG)+1]
					level.tilesG[Len(level.tilesG)-1] = TTile.Create(strip[1],Int(strip[8]),Float(strip[9]),Int(strip[10]),Int(strip[11]),Int(strip[12]),Int(strip[13]),Int(strip[14])+90,Int(strip[2]),Int(strip[3]),Int(strip[4]),Int(strip[5]),Float(strip[6]),Float(strip[7]),level.lwidth-Int(strip[16]),i*Int(strip[15]),0)
				Next				

				'horizontale tiles erstellen
				erg = level.lwidth/Int(strip[15])
				'level.tilesg =level.tilesg[..Len(level.tilesg)+1]
				For i = 0 To erg-1
					level.tilesG =level.tilesG[..Len(level.tilesG)+1]
					level.tilesG[Len(level.tilesG)-1] = TTile.Create(strip[1],Int(strip[8]),Float(strip[9]),Int(strip[10]),Int(strip[11]),Int(strip[12]),Int(strip[13]),Int(strip[14]),Int(strip[2]),Int(strip[3]),Int(strip[4]),Int(strip[5]),Float(strip[6]),Float(strip[7]),i*Int(strip[15]), 0,0)
					level.tilesG =level.tilesG[..Len(level.tilesG)+1]
					level.tilesG[Len(level.tilesG)-1] = TTile.Create(strip[1],Int(strip[8]),Float(strip[9]),Int(strip[10]),Int(strip[11]),Int(strip[12]),Int(strip[13]),Int(strip[14]),Int(strip[2]),Int(strip[3]),Int(strip[4]),Int(strip[5]),Float(strip[6]),Float(strip[7]),i*Int(strip[15]),level.lheight,0)
				Next				
				
						
			'Die Höhenlagen		
			Else If strip[7] = 0 Then
				level.tilesU =level.tilesU[..Len(level.tilesU)+1]
				'function create:TTile(imagepath:string, lage, alpha#, blend, rot, gruen, blau, rotation, animiert, tilewidth, tileheight, tilemax, scalex#, scaley#, tx,ty)
				'						imagepath animiert tilewidth tileheight tilemax scaleX scaleY lage alpha blend rot gruen blau rotation tx ty 
				'							0		 1			2		3			4 		5	  6 	7	  8		9	10	11    12   13      14 15 			
				level.tilesU[Len(level.tilesU)-1] = TTile.Create(strip[0],Int(strip[7]),Float(strip[8]),Int(strip[9]),Int(strip[10]),Int(strip[11]),Int(strip[12]),Float(strip[13]),Int(strip[1]),Int(strip[2]),Int(strip[3]),Int(strip[4]),Float(strip[5]),Float(strip[6]),Int(strip[14]),Int(strip[15]),Float(strip[16]))
			Else If strip[7] = 1 Then
				level.tilesG =level.tilesG[..Len(level.tilesG)+1]
				'function create:TTile(imagepath:string, lage, alpha#, blend, rot, gruen, blau, rotation, animiert, tilewidth, tileheight, tilemax, scalex#, scaley#, tx,ty)
				'						imagepath animiert tilewidth tileheight tilemax scaleX scaleY lage alpha blend rot gruen blau rotation tx ty 
				'							0		 1			2		3			4 		5	  6 	7	  8		9	10	11    12   13      14 15 			
				level.tilesG[Len(level.tilesG)-1] = TTile.Create(strip[0],Int(strip[7]),Float(strip[8]),Int(strip[9]),Int(strip[10]),Int(strip[11]),Int(strip[12]),Float(strip[13]),Int(strip[1]),Int(strip[2]),Int(strip[3]),Int(strip[4]),Float(strip[5]),Float(strip[6]),Int(strip[14]),Int(strip[15]),Float(strip[16]))
			Else If strip[7] = 2 Then
				level.tilesO = level.tilesO[..Len(level.tilesO)+1]
				'function create:TTile(imagepath:string, lage, alpha#, blend, rot, gruen, blau, rotation, animiert, tilewidth, tileheight, tilemax, scalex#, scaley#, tx,ty)
				'						imagepath animiert tilewidth tileheight tilemax scaleX scaleY lage alpha blend rot gruen blau rotation tx ty 
				'							0		 1			2		3			4 		5	  6 	7	  8		9	10	11    12   13      14 15 			
				level.tilesO[Len(level.tilesO)-1] = TTile.Create(strip[0],Int(strip[7]),Float(strip[8]),Int(strip[9]),Int(strip[10]),Int(strip[11]),Int(strip[12]),Float(strip[13]),Int(strip[1]),Int(strip[2]),Int(strip[3]),Int(strip[4]),Float(strip[5]),Float(strip[6]),Int(strip[14]),Int(strip[15]),Float(strip[16]))
			Else If strip[7] < 0 Then
				level.tilesB = level.tilesB[..Len(level.tilesB)+1]
				'function create:TTile(imagepath:string, lage, alpha#, blend, rot, gruen, blau, rotation, animiert, tilewidth, tileheight, tilemax, scalex#, scaley#, tx,ty)
				'						imagepath animiert tilewidth tileheight tilemax scaleX scaleY lage alpha blend rot gruen blau rotation tx ty 
				'							0		 1			2		3			4 		5	  6 	7	  8		9	10	11    12   13      14 15 			
				level.tilesB[Len(level.tilesB)-1] = TTile.Create(strip[0],Int(strip[7]),Float(strip[8]),Int(strip[9]),Int(strip[10]),Int(strip[11]),Int(strip[12]),Float(strip[13]),Int(strip[1]),Int(strip[2]),Int(strip[3]),Int(strip[4]),Float(strip[5]),Float(strip[6]),Int(strip[14]),Int(strip[15]),Float(strip[16]))
			End If
							
			'local index% = feld.find("=")
			'local value1$ = feld[index+1..]
			'feld = feld[..index]
		Wend	
		
		CloseFile file
	
		Return level
	End Function
	
	
	
	Method saveToFile(filename:String)
		Local file:TStream = OpenFile(filename)
		Local found
		If Not file Then
			CreateFile filename'throw "could not open file " + filename
			file:TStream = OpenFile(filename)
		End If
		
		WriteLine(file, lwidth + "," + lheight + "," + backgroundPath)
		Local t:String
		Local i:Int

		For i = 0 To tilesU.length-1
			t = tilesU[i].imagepath 
			t = t + "," 
			t = t + tilesU[i].animiert 
			t = t + "," 
			t = t + tilesU[i].tilewidth 
			t = t + "," 
			t = t + tilesU[i].tileheight
			t = t + "," 
			t = t + tilesU[i].tilemax
			t = t + "," 
			t = t + tilesU[i].scaleX
			t = t + "," 
			t = t + tilesU[i].scaleY
			t = t + "," 
			t = t + tilesU[i].lage
			t = t + "," 
			t = t + tilesU[i].alpha
			t = t + "," 
			t = t + tilesU[i].blend
			t = t + "," 
			t = t + tilesU[i].rot
			t = t + "," 
			t = t + tilesU[i].gruen
			t = t + "," 
			t = t + tilesU[i].blau
			t = t + "," 
			t = t + tilesU[i].rotation
			t = t + "," 
			t = t + tilesU[i].tx
			t = t + "," 
			t = t + tilesU[i].ty
			
			WriteLine(file, t)
		Next
				
		For i = 0 To tilesG.length-1
			t = tilesU[i].imagepath 
			t = t + "," 
			t = t + tilesU[i].animiert 
			t = t + "," 
			t = t + tilesG[i].tilewidth 
			t = t + "," 
			t = t + tilesG[i].tileheight
			t = t + "," 
			t = t + tilesG[i].tilemax
			t = t + "," 
			t = t + tilesG[i].scaleX
			t = t + "," 
			t = t + tilesG[i].scaleY
			t = t + "," 
			t = t + tilesG[i].lage
			t = t + "," 
			t = t + tilesG[i].alpha
			t = t + "," 
			t = t + tilesG[i].blend
			t = t + "," 
			t = t + tilesG[i].rot
			t = t + "," 
			t = t + tilesG[i].gruen
			t = t + "," 
			t = t + tilesG[i].blau
			t = t + "," 
			t = t + tilesG[i].rotation
			t = t + "," 
			t = t + tilesG[i].tx
			t = t + "," 
			t = t + tilesG[i].ty
			
			WriteLine(file, t)
		Next		
		
		
		For i = 0 To tilesO.length-1
			t = tilesU[i].imagepath 
			t = t + "," 
			t = t + tilesU[i].animiert 
			t = t + "," 
			t = t + tilesO[i].tilewidth 
			t = t + "," 
			t = t + tilesO[i].tileheight
			t = t + "," 
			t = t + tilesO[i].tilemax
			t = t + "," 
			t = t + tilesO[i].scaleX
			t = t + "," 
			t = t + tilesO[i].scaleY
			t = t + "," 
			t = t + tilesO[i].lage
			t = t + "," 
			t = t + tilesO[i].alpha
			t = t + "," 
			t = t + tilesO[i].blend
			t = t + "," 
			t = t + tilesO[i].rot
			t = t + "," 
			t = t + tilesO[i].gruen
			t = t + "," 
			t = t + tilesO[i].blau
			t = t + "," 
			t = t + tilesO[i].rotation
			t = t + "," 
			t = t + tilesO[i].tx
			t = t + "," 
			t = t + tilesO[i].ty
			
			WriteLine(file, t)
		Next
		
		CloseFile (file)
	End Method

	Method drawB()
		'setblend lightblend  'kostet 35 Frames
		SetAlpha 1
		SetColor 200, 200, 255
		
		'tileimage kostet 100 frames
		
		If splitscreen = 0 Then
			TileImage backgroundimage,-(viewx/3),-(viewy/3)
		
		Else If splitscreen = 1 Then
		
			SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()
			TileImage backgroundimage,-(viewx/3),-(viewy/3)
		
			SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()
			TileImage backgroundimage,-(viewx2/3),-(viewy2/3)

			SetViewport 0,0, GraphicsWidth(), GraphicsHeight()
		End If
		
		
		Local i:Int
		For i=0 To tilesB.length - 1 
			If tilesB[i]<>Null Then
				tilesB[i].Draw()
			End If
		Next
	End Method
		
	Method drawU()
		Local i:Int
		For i=0 To tilesU.length - 1 
			If tilesU[i]<>Null Then
				tilesU[i].Draw()
			End If
		Next
	End Method
	
		
	Method drawG()
		Local i:Int
		For i=0 To tilesG.length - 1 
			If tilesG[i]<>Null Then
				tilesG[i].Draw()
			End If
		Next
	End Method

		
	Method drawO()
		Local i:Int
		For i=0 To tilesO.length - 1 
			If tilesO[i]<> Null Then
				tilesO[i].Draw()
			End If
		Next
	End Method
	
End Type	   




Type TTile
	Field Image:TImage
	Field imagepath:String
	Field animiert:Int '0/1
    	Field tilewidth:Int
	    Field tileheight:Int
		Field tilemax:Int 'max-frame
		Field aframe:Int=0 'aktuelles frame
		Field animTime:Int=0
		Field deltatime:Int=0
	Field scaleX:Float
	Field scaleY:Float
	Field lage:Int '0=unter spieler, 1=gleiche höhe, 2=über Spieler
	Field alpha:Float 'alpha-transparenz 0.0-1.0
	Field blend:Int	'blend modus
	Field rot:Int
	Field gruen:Int
	Field blau:Int
	Field rotation:Float 'winkel für rotation
	Field tx:Int
	Field ty:Int
'	field longestSide:Int
	Field rotationSpeed:Float
		
	Function Create:TTile(imagepath:String, lage, alpha#, blend, rot, gruen, blau, rotation#, animiert, tilewidth, tileheight, tilemax, scaleX#, scaleY#, tx,ty,rotationSpeed#)
		Local tile:TTile = New TTile
		tile.imagepath = imagepath
		
		If animiert = 1 Then
			tile.Image:TImage = LoadAnimImage(imagepath, tilewidth, tileheight, 0, tilemax, MASKEDIMAGE|MIPMAPPEDIMAGE)
		Else                       
			tile.Image:TImage = LoadImage(imagepath,MASKEDIMAGE|MIPMAPPEDIMAGE)
		End If
		
		'tile.image:TImage = testIm
		MidHandleImage(tile.Image)
		
		tile.rotationSpeed = rotationSpeed
		tile.tx = tx
		tile.ty = ty
		tile.scaleX = scaleX
		tile.scaleY = scaleY
		tile.lage = lage
		tile.alpha = alpha
		tile.blend = blend
		tile.rot = rot
		tile.gruen = gruen
		tile.blau = blau
		tile.rotation = rotation
		tile.animiert = animiert

		If animiert = 1 Then
			tile.tilewidth = tilewidth
			tile.tileheight = tileheight
		Else
			tile.tilewidth = tile.Image.width
			tile.tileheight = tile.Image.height
		End If
		tile.tilemax = tilemax
		
		
		Return tile
	End Function
	
	Method getx1()
		Local bb

		If lage > -1 Then
			bb = (tx - viewx)*mainscale		
		Else If lage = -1 Then
			bb = (tx - viewx/1.5)*mainscale
		Else If lage = -2 Then
			bb = (tx - viewx/2.5)*mainscale
		End If
		
		Return bb '+ 200
	End Method

	Method getx2()
		Local bb

		If lage > -1 Then
			bb = (tx - viewx2)*mainscale		
		Else If lage = -1 Then
			bb = (tx - viewx2/1.5)*mainscale
		Else If lage = -2 Then
			bb = (tx - viewx2/2.5)*mainscale
		End If
		
		Return bb '+ 200
	End Method
	
			
	Method gety1()
		Local bb
		If lage > -1 Then
			bb = (ty - viewy)*mainscale	
		Else If lage = -1 Then
			bb = (ty - viewy/1.5)*mainscale
		Else If lage = -2 Then
			bb = (ty - viewy/2.5)*mainscale
		End If
		Return bb '+ 200
	End Method
	
	Method gety2()
		Local bb
		If lage > -1 Then
			bb = (ty - viewy2)*mainscale	
		Else If lage = -1 Then
			bb = (ty - viewy2/1.5)*mainscale
		Else If lage = -2 Then
			bb = (ty - viewy2/2.5)*mainscale
		End If
		Return bb '+ 200
	End Method
	
	Method Draw(drawleft:Int=0) '0=normal,1=links,2=rechts
			
			SetAlpha alpha
			
			'SetScale scaleX, scaleY
						
			Local ssx:Float = (scalex + mainscale)/2	
			Local ssy:Float = (scaley + mainscale)/2	
				
			SetScale ssx,ssy
				
			SetColor rot, gruen, blau
			SetBlend blend
			SetRotation rotation
			
			rotation = rotation + gamemanager.fps_val(rotationSpeed)
			If rotation > 360 Then rotation = 0
		
		
		If splitscreen = 0 Then
			If (getx1()+Image.width > 0) And (getx1()-Image.width < gfxOptions.gw) And (gety1()+Image.height > 0) And (gety1()-Image.height < gfxOptions.gh) Then
				DrawImage Image, getx1(), gety1(), aframe
			End If
			
		Else
		
			SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()
			'If (getx1()+Image.width > 0) And (getx1()-Image.width < gfxOptions.gw/2) And (gety1()+Image.height > 0) And (gety1()-Image.height < gfxOptions.gh) Then
				DrawImage Image, getx1(), gety1(), aframe
			'End If
								
			SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()
			'If (getx2()+Image.width > gfxoptions.gw/2) And (getx2()-Image.width < gfxOptions.gw) And (gety2()+Image.height > 0) And (gety2()-Image.height < gfxOptions.gh) Then
				DrawImage Image, getx2(), gety2(), aframe
			'End If

			SetViewport 0,0, GraphicsWidth(), GraphicsHeight()

			'collide auf viewx2
			'wenn auf spieler-lage
			'If lage = 1 Then
			'	CollideImage Image, rx, gety(), aframe,0,1
			'End If					
			
		End If
		

		'wenn auf spieler-lage
		If lage = 1 Then
			CollideImage Image, tx, ty, aframe,0,1
		End If					
		
		
		Rem	
		local divx:Double
		local divy:Double
		local xx:Double
		local yy:Double	
		divx = arena1.lwidth/100
		divy = arena1.lheight/100
		xx = tx/divx
		yy = ty/divx
			
		setcolor 0,0,200
		setblend alphablend
		setscale 1,1
		setrotation 0
		setalpha 1
		DrawRect xx,yy,4,4
		end rem 
		
		deltatime = deltatime + MilliSecs()-animTime
		If  deltatime > 50 Then
			If animiert = 1 Then
				aframe = aframe + 1
				If aframe = tilemax Then aframe = 0
			End If
			deltatime = 0
		End If	
		
		animTime = MilliSecs()
	End Method
End Type






'Welche Levels sind freigeschaltet und können gespielt werden?
Type TLevelFortschritt

	'0 = nicht spielbar
	'1 = spielbar
	'2 = geschafft auf s0
	'3 = geschafft auf s1
	'4 = geschafft auf s2
	
	Field levels[]
'	Field rekord[]

	Field datei:String = "init/config.dat"
						
						
	Method openLevel(level:Int)
			If istdemoversion = 0 Then
				If levels[level-1] = 0 Then
					levels[level-1] = 1
					save()
				End If
			Else
				If (level-1) < 7 Then
					If levels[level-1] = 0 Then
						levels[level-1] = 1
						save()
					End If
				End If
			
			
				'Kaufbildschirm anzeigen, nur hier oder bei set
			End If
	End Method


	Method setLevel(level:Int, diff:Int)
			'If istdemoversion = 0 Then
				If levels[level-1] < diff Then
					levels[level-1] = diff
					save()
				End If
			'Else
				'Kaufbildschirm anzeigen
			'End If
	End Method
						
						
	Function create:TLevelfortschritt()
	
		Local lf:TLevelfortschritt = New TLevelfortschritt
		unshitfile(lf.datei)

		lf.levels = New Int[30]
			
		Local file:TStream = ReadFile(lf.datei)
		If Not file Throw "could not open file " + lf.datei

		Local counter:Int = 0
		While Not Eof(file)
			Local feld$ = ReadLine(file)
			Local Strip:String[]

			'erste zeile einlesen
			'If counter = 0 Then
			'	Strip = Return_Strip(feld,",")
			'	level.lwidth = Int(strip[0])
			'	level.lheight = Int(strip[1])
			'	counter = 2						
			'	Continue				
			'End If
								
			If feld.Trim() = "" Then Continue 
			If feld.Trim() = " " Then Continue 
			If feld.find("/",0) = 0 Then Continue
		
			lf.levels[counter] = Int(feld)
				
			'Strip = Return_Strip(feld,",")
			counter:+1	
		Wend
		shitfile(lf.datei)
		Return lf
	End Function
	
	
	Method save()
'		debugstop
	
		DeleteFile(datei)
		CreateFile(datei)

		Local file:TStream = OpenFile(datei)
	
		'file = OpenFile (datei)
		For Local t:Int = EachIn levels
			WriteLine ( file, t )
		Next
		CloseFile (file)
		
		
		shitfile(datei)
		Return 1
	
	End Method

End Type







'Beste Ergebnisse pro Level
Type TLevelRekord
	Field datei:String = "init/rek.dat"
	Field datei1:String = "init/rek1.dat"
	Field datei2:String = "init/rek2.dat"

	Field dateiart:String = "init/art.dat"
	
	Field levels:String[]
	Field levels1:String[]
	Field levels2:String[]
	
	Field arten:Int[]

	Field art:String[] = [getlang("(Ausgeteilter Schaden minus erlittener Schaden)"),getlang("(Übrige Schildenergie der Raumstation)"),getlang("(Übrige Zeit in Sekunden)"),getlang("(Deine Abschuesse minus Abschuesse des Gegners)")]



'	Field rekord[]
			
'	levelrekord.setrekord("", 0, 1)
	
	Method setrekord(rekord:String,level:Int,art:Int)
			'art: 
			'1  Kampfdronen: Punkte (Differenz Ausgeteilter Schaden - Erlittener Schaden)
	   		'2  Sicherung: Energie der Station -> in Klammer dahinter(Stationsenergie oder so) standard: 0
	        '3  Orientierung: Zeit - standard: 2:00 Minuten (benötigte Zeit)
	 		'4  Zweikampf: Ergebnis 5:1 oder so - standard 0:5 (Ergebnis)Differenz: Deine Abschuesse - Abschuesse des Gegners

			'NUR WENN REKORD BESSER IST !!!
			arten[level-1] = art
					
			Local schreiben:Int = 0

			If gdifficulty = 0 Then 
			
				If Int(rekord) > Int(levels[level-1]) Then
					schreiben = 1
				End If
			
				If schreiben = 1 Then
					levels[level-1] = rekord
					save()
				End If
				
			Else If gdifficulty = 1 Then
				If Int(rekord) > Int(levels1[level-1]) Then
					schreiben = 1
				End If
			
				If schreiben = 1 Then
					levels1[level-1] = rekord
					save()
				End If
			
			Else If gdifficulty = 2 Then
				If Int(rekord) > Int(levels2[level-1]) Then
					schreiben = 1
				End If
			
				If schreiben = 1 Then
					levels2[level-1] = rekord
					save()
				End If
			
			End If
	End Method
	
	
	
	Method loadRekorde(dat:String,lev:String[])
		unshitfile(dat)
		
	
		Local file:TStream = ReadFile(dat)
		If Not file Throw "could not open file " + dat

		Local counter:Int = 0
		While Not Eof(file)
			Local feld$ = ReadLine(file)
			Local Strip:String[]
								
			If feld.Trim() = "" Then Continue 
			If feld.Trim() = " " Then Continue 
			If feld.find("/",0) = 0 Then Continue
		
			lev[counter] = feld 'Int(feld)
			arten[counter] = 0
				
			'Strip = Return_Strip(feld,",")
			counter:+1	
		Wend
		
		unshitfile(dateiart)
		counter:Int = 0
		file:TStream = ReadFile(dateiart)
		If Not file Throw "could not open file " + dateiart
		While Not Eof(file)
			Local feld$ = ReadLine(file)
			Local Strip:String[]
								
			If feld.Trim() = "" Then Continue 
			If feld.Trim() = " " Then Continue 
			If feld.find("/",0) = 0 Then Continue
		
			'lf.levels[counter] = feld 'Int(feld)
			arten[counter] = Int(feld)
				
			'Strip = Return_Strip(feld,",")
			counter:+1	
		Wend
	
	
		shitfile(dat)
		shitfile(dateiart)
	End Method
	
	
		
	Function create:TLevelRekord()
		Local lf:TLevelRekord= New TLevelRekord
		lf.levels = New String[30]
		lf.levels1 = New String[30]
		lf.levels2 = New String[30]
		lf.arten = New Int[30]
		
		lf.loadRekorde(lf.datei, lf.levels)
		lf.loadRekorde(lf.datei1, lf.levels1)
		lf.loadRekorde(lf.datei2, lf.levels2)
				
		Return lf
	End Function
	
			
	Method save()
		saverekord(datei,levels)
		saverekord(datei1,levels1)
		saverekord(datei2,levels2)
	End Method
	
	
	Method saveRekord(dat:String, lev:String[])

		DeleteFile(dat)
		DeleteFile(dateiart)

		CreateFile(dat)
		CreateFile(dateiart)


		Local file:TStream = OpenFile(dat)
			
		'file = OpenFile (datei)
		For Local t$ = EachIn lev
			WriteLine ( file, t )
		Next
		CloseFile (file)

		file:TStream = OpenFile(dateiart)
			
		'file = OpenFile (datei)
		For Local t$ = EachIn arten
			WriteLine ( file, t )
		Next
		CloseFile (file)
				
		
						
		shitfile(dat)
		shitfile(dateiart)												
		Return 1
	End Method
End Type

  

