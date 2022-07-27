Strict


'Global iPtr = LoadLibraryA("OpenURL.dll")
'Global OpenURL(url:Byte Ptr)"win32"=GetProcAddress(iPtr,"OpenURL")


'Import PUB.FreeProcess 
'Global superProc:TProcess

'If proc.Status()
'  Notify "Yup. Notpad is alive!"
'else
'  notepad tot
'EndIf
'proc.Terminate


Global debugit:Int = 0  'für Releases auf 0 setzen !!!

Global IstDemoversion:Int = 0

Global language:Int = 0
'0 = deutsch
'1 = englisch


Global appversion:String
If istdemoversion = 1 Then
	AppVersion:String = "DEMO 1.0"
	AppTitle$ = "Galactic Deathmatch - Demo"	
Else
	AppVersion:String = "1.0"
	AppTitle$ = "Galactic Deathmatch"	
End If


Include "languageRes.bmx"
Include "Tshitfile.bmx"                        

  
'--------------------------------------------------
	'Zentrale Unit des Spiels 
	'GALACTIC DEATHMATCH
	'Christian Merz 2005
'---------------------------------------------------

'Benötigte Sounds und Graphiken an Exe-Datei anhängen


	'Booster-Item
'	Incbin "images/booster_final.png"
	Global iboosterItem:TImage
	iboosteritem = LoadImage("images/booster_final.png")
	
	MidHandleImage(iboosteritem)
	'Radar-Item
'	Incbin "images/radar.png"

                                                     
	'ITEM-SOUNDS
	'Incbin "sfx/boost.ogg"
'	Incbin "sfx/motor9.wav"
	Global sBoost:TSound = LoadSound ("sfx/motor9.wav")

'	Incbin "sfx/GetBooster.ogg"
	Global sGetBooster:TSound = LoadSound ("sfx/GetBooster.ogg")

'	Incbin "sfx/radar.ogg"
	Global sGetRadar:TSound = LoadSound ("sfx/radar.ogg")


'	Incbin "sfx/sgetGun.wav" '=changeGun
	Global sGetGun:TSound = LoadSound ("sfx/sgetGun.wav")
'	Incbin "sfx/sgetMun.wav"
	Global sGetMun:TSound = LoadSound ("sfx/sgetMun.wav")
'	Incbin "sfx/sgetSchild.wav"
	Global sGetSchild:TSound = LoadSound ("sfx/sgetSchild.wav")              

'	Incbin "sfx/GetColItem.wav"
	Global GetColItem:TSound= LoadSound ("sfx/GetColItem.wav")              


	'Zeit läuft ab
	'Incbin "sfx/Ding.wav"
	Global sDing:TSound= LoadSound ("sfx/Ding.wav")              

	'Incbin "sfx/LevelEndeS.ogg"
	Global LevelEndeS:TSound = LoadSound ("sfx/LevelEndeS.ogg")
	'Incbin "sfx/scheisse.wav"
	'Global scheisseSound = LoadSound ("incbin::sfx/scheisse.wav")              

	'IncBin "sfx/getBooster"
	'IncBin "sfx/getRadar"

	'Incbin "sfx/laser4.wav"
	'Global shoots = LoadSound ("incbin::sfx/laser4.wav")
                   
	'Incbin "sfx/mine.wav"
    '    
	'Incbin "sfx/uzi.wav"
	'Global uzi = LoadSound ("incbin::sfx/uzi.wav")

	'Incbin "sfx/deathbullet.wav"

	
	'Incbin "sfx/lifebonus.ogg"
	Global slifebonus:TSound = LoadSound("sfx/lifebonus.ogg")


	'Incbin "sfx/flame.wav"

	'Incbin "sfx/motor5.wav"
	Global motor:TSound = LoadSound ("sfx/motor5.wav")

	'Incbin "sfx/explosion.ogg"
	Global explo:TSound = LoadSound("sfx/explosion.ogg")

	'Incbin "sfx/damage3.wav"
	Global damage:TSound = LoadSound("sfx/damage3.wav")
	'incbin "sfx/damage4.wav"
	'global damage = loadsound("sfx/damage4.wav")

	'Incbin "sfx/over.ogg"
	Global mover:TSound = LoadSound("sfx/over.ogg")
	'Incbin "sfx/down.ogg"
	Global mdown:TSound = LoadSound("sfx/down.ogg")


	'Incbin "sfx/spawn.ogg"
	Global shipSpawn:TSound = LoadSound("sfx/spawn.ogg")
						'	as.ttf add.ttf 
	
	
	'Global fontdatei:String = "images/bio.ttf"
	Global fontdatei:String = "images/transist.ttf"
	Global fontdatei2:String = "images/transist.ttf"
	Global fontdatei3:String = "images/tahoma.ttf"

'bio
'impact
'aaa
'alexg


	Global superfont:TImageFont = LoadImageFont(fontdatei,30,SMOOTHFONT)
	Global superfont8:TImageFont = LoadImageFont(fontdatei,24,SMOOTHFONT)

'	Global levelFont:TImageFont = LoadImageFont(fontdatei2,14,SMOOTHFONT)
	Global levelFont:TImageFont = LoadImageFont(fontdatei2,19,SMOOTHFONT)
	Global levelFontg:TImageFont = LoadImageFont(fontdatei2,25,SMOOTHFONT)

	Global levelFontg2:TImageFont = LoadImageFont(fontdatei3,26,SMOOTHFONT)
	Global levelFontg3:TImageFont = LoadImageFont(fontdatei3,20,SMOOTHFONT)


	Global minifont:TImageFont = LoadImageFont(fontdatei,20,SMOOTHFONT)
	Global gamefont:TImageFont = LoadImageFont(fontdatei,50,SMOOTHFONT)
	Global gamefont8:TImageFont = LoadImageFont(fontdatei,39,SMOOTHFONT)

	Global playFont:TImageFont = LoadImageFont(fontdatei,16,SMOOTHFONT)


	'Incbin "images/menutest_f.jpg"
		
	'Incbin "images/anim2.png"
	'Incbin "images/cursor2.png"
	'Incbin "images/schrift1.jpg"   
	             
	'Incbin "images/links1.png"         
	'Incbin "images/links2.png"         
	'Incbin "images/rechts1.png"         
	'Incbin "images/rechts2.png"         

	'Incbin "images/trennlinie.png"


'	Incbin "images/ufopower.png"


'Catch ex:Object
'	RuntimeError(ex.ToString() + "Incbin-EXE-Anhang")	
'End Try



'-------------------------------------------------------------

Global lastcall:Int 'Benötigt für Pausenzeit-Aufrechnung

'-------------------------------------------------------------


	'WorkAround für LUA-Methodenproblem
	Global AktuellerGegner:TShip=Null
	'in updateai: aktuellerGegner=self
	'scriptstart
	'aktuellergegner=null
	'in Funktionen: AktuellerGegner
		
'	Global showRadar:Int = 0





Include "TAStern.bmx"				'A* Wegsuche

Include "TIniFiles.bmx"				'Dateizugriffs-Funktionen
Include "TStringFunktionen.bmx"		'Stringverarbeitung
Include "TSoundManager.bmx"    		'Soundeinstellungen
Include "TGFXOptions.bmx"			'Graphikeinstellungen
Include "TBackground.bmx"			'Rotierende Sterne
Include "TSonstiges.bmx"			'Zusatzfunktionen
Include "TPartikel.bmx"				'Partikelsystem
Include "TLevel.bmx"   				'Level
Include "TSchild.bmx"    			'Schutzschild
Include "TSchuss.bmx"				'Schüsse
Include "TBonusItem.bmx"            'Bonusitems
Include "TKIFunktionen.bmx"			'KI-Funktionen - LUA

Include "TShip.bmx"					'Raumschiffe
Include "TMenu.bmx"					'Menüs
Include "TGameManager.bmx"			'Gamemanager

Global radarDeltaX = 0
Global radarDeltaY = 0


'Globale Instanz vom GameManager   
Global GameManager:TGameManager = New TGameManager 
Global zeigeFPS:Int=0
Global zeigeXY:Int=0
                
                
'Variablen für Testspiel                
'Global arena1:TArena                         
'arena1 = TArena.createFromFile("arena2.map")
'Global sternchen:TSterne = TSterne.Create(600,arena1.lwidth/2,arena1.lheight/2)
Global sternchen:TSterne = TSterne.Create(600,1000,1000)

'Global ships:TShips = TShips.Create()
Global bullets:TBullets = TBullets.Create()
Global partikles:TPartikles = TPartikles.Create()
Global partiklesOver:TPartikles = TPartikles.Create() 'partikel über u und unter o und unter schiff
'---------------------------
      

                  
'Schussarten
'-----------
Global schussArten:TSchussarten = TSchussarten.Create()
						'(sID:Int,bezeichnung:String,sImagePath:String,sSoundPath:String,simagelevelpath:string,scalex:Float,scaley:Float,damage:Float,lifetime:Int,speed:Int,sdelay:Int,startmun,itemmun)
schussArten.AddSchussart(TSchussart.Create(1,"Single Laser","images/nebula.png","sfx/uzi.wav","images/Laser.png",0.5,0.5,7,400,1000,100,-5,0))                         
schussArten.AddSchussart(TSchussart.Create(2,"Power Laser","images/powerlaser.png","sfx/laser4.wav","images/powerLaserLevel.png",0.5,0.5,15,600,1000,300,50,50))
schussArten.AddSchussart(TSchussart.Create(3,"Triple Laser","images/nebula.png","sfx/uzi.wav","images/TripleLevel.png",0.5,0.5,7,400,1000,100,50,50))
schussArten.AddSchussart(TSchussart.Create(4,"Allrounder","images/nebula.png","sfx/uzi.wav","images/allrounderlevel.png",0.5,0.5,7,400,1000,100,100,50))
schussArten.AddSchussart(TSchussart.Create(5,"Flamer","images/powerlaser.png","sfx/flame.wav","images/flamerLevel.png",1,1,7,300,1000,10,200,200))
schussArten.AddSchussart(TSchussart.Create(6,"Minen","images/mineLevel.png","sfx/mine.wav","images/mineLevel.png",1,1,50,30000,0,300,5,10))
schussArten.AddSchussart(TSchussart.Create(7,"Target Gun","images/powerlaser.png","sfx/laser4.wav","images/rocketlevel.png",0.5,0.5,12,500,500,300,50,50))
schussArten.AddSchussart(TSchussart.Create(8,"Bullet of Death","images/nebula.png","sfx/deathbullet.wav","images/deathlevel.png",0.5,0.5,1500,600,1500,600,5,50))
schussArten.AddSchussart(TSchussart.Create(9,"Ultragun","images/powerlaser.png","sfx/laser4.wav","images/ultragun.png",0.5,0.5,15,700,1000,300,50,50))

'schussArten.AddSchussart(TSchussart.Create(0,"Tower1","images/t1level.png","sfx/laser4.wav","images/t1level.png",0.5,0.5,15,700,1000,300,50,50))




'					Reichweite	Schaden		Delay	      Speed
'------------------------------------------------------------------------------------
'1 Single Laser......	mittel	 klein		 kurz		mittel
'2 Powerlaser........   hoch	 mittel		 mittel		mittel

'3 Triple Laser......	mittel	 klein		 kurz		mittel
'4 Allrounder........   mittel	 klein		 kurz		mittel

'5 Flamer............   klein	 hoch		 sehr kurz	mittel
'6 Minen.............	  -		 sehr hoch	 -		    -

'7 Target Gun........   mittel	 mittel		 mittel		langsam
'8 Bullet of Death...   hoch	 sehr hoch	 lang		sehr schnell
'9 Ultra Gun.........   hoch 	 hoch		 mittel		mittel		
'0 
'--------------------------------------------------------------------------------------------                        

'Reichweite: 
'30000 = unsterblich
'  600 = weit
'  400 = mittel
'  200 = kurz
'   50 = Rammbock 

'Schaden
'  5 = wenig
' 10 = mittel
' 50 = hoch
'100 = sehr hoch

'Delay
' 10 = sehr kurz
'100 = kurz
'300 = mittel
'600 = lang

'Speed
' 500 = langsam
'1000 = mittel
'1500 = schnell




                          
'Gleitersammlung
'---------------                   
Global gleiterSammlung:TGleiters = TGleiters.Create()  
										'(id,bezeichnung,ImagePath:String,imagePathAnim:String,life:Float,maxspeed,winkelSpeed)

Global gleiterSchlecht:Int = 180 
Global gleiterNormal:Int = 220
Global gleiterGut:Int = 260
Global gleiterSuper:Int = 300
Global gleiterMega:Int = 340

Global gleiterSchlechtS:Int = 300 
Global gleiterNormalS:Int = 400
Global gleiterGutS:Int = 500
Global gleiterSuperS:Int = 600
Global gleiterMegaS:Int = 700

'Global gleiterSchlechtW:Int = 100 
'Global gleiterNormalW:Int = 130
'Global gleiterGutW:Int = 160
'Global gleiterSuperW:Int = 190
'Global gleiterMegaW:Int = 220

Global gleiterSchlechtW:Int = 200
Global gleiterNormalW:Int = 240
Global gleiterGutW:Int = 280
Global gleiterSuperW:Int = 320
Global gleiterMegaW:Int = 360

'Global gleiterSchlechtW:Int = 230 
'Global gleiterNormalW:Int = 290
'Global gleiterGutW:Int = 350
'Global gleiterSuperW:Int = 410
'Global gleiterMegaW:Int = 550




Function getlifepower:Int(val:Int)
	Select val 
		Case gleiterSchlecht Return 1
		Case gleiterNormal Return 2
		Case gleiterGut Return 3
		Case gleiterSuper Return 4
		Case gleiterMega Return 5
	End Select
End Function

Function getwinkelspeedpower:Int(val:Int)
	Select val 
		Case gleiterSchlechtW Return 1
		Case gleiterNormalW Return 2
		Case gleiterGutW Return 3
		Case gleiterSuperW Return 4
		Case gleiterMegaW Return 5
	End Select
End Function

Function getmaxspeedpower:Int(val:Int)
	Select val 
		Case gleiterSchlechtS Return 1
		Case gleiterNormalS Return 2
		Case gleiterGutS Return 3
		Case gleiterSuperS Return 4
		Case gleiterMegaS Return 5
	End Select
End Function
 

'Global gleiterGiga:Int = 600
'Global gleiterUltra:Int = 700


'Spieler-Gleiter																							'  life         speed       winkelspeed
gleiterSammlung.addgleiter(TGleiter.Create(0,"Battle Shuttle","images/finalshuttle.png","images/shuttle.png",gleitersuper,gleiterGutS,gleiterGutW))
gleiterSammlung.addgleiter(TGleiter.Create(5,"Scout","images/finalscout.png","images/scout.png",gleiterNormal,gleiterSuperS,gleiterSuperW))
'gleiterSammlung.addgleiter(TGleiter.Create(5,"Scout","images/finalscout.png","images/scout.png",gleiterSchlecht,gleiterSchlechtS,gleiterSchlechtW))

gleiterSammlung.addgleiter(TGleiter.Create(1,"Ice Tiger","images/icetigerfinal.png","images/icetiger.png",gleitergut,gleiterSuperS,gleitergutW))
gleiterSammlung.addgleiter(TGleiter.Create(4,"Beast","images/finalfish.png","images/daemon.png",gleiternormal,gleiterMegaS,gleitergutW))
gleiterSammlung.addgleiter(TGleiter.Create(2,"Monster Bat","images/finalshark.png","images/shark.png",gleitersuper,gleiternormalS,gleitersuperW))
gleiterSammlung.addgleiter(TGleiter.Create(3,"Devil","images/finaldevil.png","images/devil.png",gleiterMega,gleitergutS,gleiternormalW))

gleiterSammlung.addgleiter(TGleiter.Create(12,"Ultra Fighter","images/Ultrafighter.png","images/Ultrafighter.png",gleitermega,gleitermegaS,gleitermegaW))


'gleiterSammlung.addgleiter(TGleiter.Create(3,"a","finaldevil.png","devil.png",gleiterMega,gleiterSuper,gleiterNormal))
'gleiterSammlung.addgleiter(TGleiter.Create(3,"b","finaldevil.png","devil.png",gleiterMega,gleiterSuper,gleiterNormal))
'gleiterSammlung.addgleiter(TGleiter.Create(3,"c","finaldevil.png","devil.png",gleiterMega,gleiterSuper,gleiterNormal))
'gleiterSammlung.addgleiter(TGleiter.Create(3,"d","finaldevil.png","devil.png",gleiterMega,gleiterSuper,gleiterNormal))

'Dronen
gleiterSammlung.addgleiter(TGleiter.Create(6,"Drone1","images/Drone1.png","images/Drone1.png", 15, 100, 70))
gleiterSammlung.addgleiter(TGleiter.Create(7,"Drone2","images/Drone2.png","images/Drone2.png", 20, 180, 140))
gleiterSammlung.addgleiter(TGleiter.Create(9,"Drone3","images/Drone3.png","images/Drone3.png", 30, 230, 190))
gleiterSammlung.addgleiter(TGleiter.Create(10,"Drone4","images/Drone4.png","images/Drone4.png", 40, 280, 230))
gleiterSammlung.addgleiter(TGleiter.Create(11,"Drone5","images/Drone5.png","images/Drone5.png", 50, 330, 270))


' schlecht - normal - gut - super - mega

'					speed		winkelspeed		life
'-------------------------------------------------------------------

'Battle Shuttle.....OOO			OOO				OOOO

'Ice Tiger..........OOOO 		OOO 			OOO

'Scout..............OOOO		OOOOO 			O

'Beast..............OOOOO 		OOO 			OO

'Monster Bat........OO  		OOOO			OOOO

'Devil..............OO		    OOO				OOOOO


'3 * 1-5

'1..................
'2..................
'3..................
'4..................
'5..................
'6..................
'7..................
'8..................
'9..................
'10.................






'Raumstationen
gleiterSammlung.addgleiter(TGleiter.Create(8,"Station1","images/sStation1.png","images/sStation1.png", 3000, 0, 0))

'Towers
gleiterSammlung.addgleiter(TGleiter.Create(14,"Tower1","images/t1shoot.png","images/t1shoot.png", 80, 0, 80))
gleiterSammlung.addgleiter(TGleiter.Create(15,"Tower2","images/t2shoot.png","images/t2shoot.png", 120, 0, 120))

Global iTowerItem1:TImage = LoadImage("images/t1level.png")
MidHandleImage(itoweritem1)

Global iTowerItem2:TImage = LoadImage("images/t2level.png")
MidHandleImage(itoweritem2)



'---------------------------------------------                      
                                               
                          
'Schilde                  
'--------        
Global Schildersammlung:TSchilde = TSchilde.Create()
Schildersammlung.AddSchild(TSchild.Create(50, "images/schildi2.png"))
Schildersammlung.AddSchild(TSchild.Create(100, "images/schildi2.png"))
Schildersammlung.AddSchild(TSchild.Create(200, "images/schildi2.png"))
'----------------------------------------------
                          
                      



    
'Spielmodi/Levels/Gegner erstellen
'--------------------------------    
'Ausscheidungskämpfe zwischendurch:Byte neue Raumschiffe sollten nicht so oft da sein
	'Ausscheidungskampf gegen den Abgesandten der Podonen
    'Ausscheidungskampf gegen den Abgesandten der Niveda

'1 Trainingslevel
'Gas geben, links, rechts, bremsen
'Waffenitems anfliegen und aufnehmen, Waffen benutzen, Waffen wechseln
'Radaritem/Boosteritem
'1 Gegner der sich nicht wehrt

Include "gmChapter1.bmx"
Include "gmChapter2.bmx"
'Include "gmChapter3.bmx"
'Include "gmChapter4.bmx"
'Include "gmChapter5.bmx"

Global Spielmodi:TSpielmodi = TSpielmodi.Create()
Spielmodi.AddSpielmodus(gmChapter1)
'Spielmodi.AddSpielmodus(gmChapter2)  
'Spielmodi.AddSpielmodus(gmChapter3)
'Spielmodi.AddSpielmodus(gmChapter4)
'Spielmodi.AddSpielmodus(gmChapter5)
'-------------------------------------------------


Global levelFortschritt:TLevelFortschritt = TLevelFortschritt.create()
Global levelRekord:TLevelRekord = TLevelRekord.create()

'-----------------------------

'Verschiebungsvariablen
Global ViewX:Int = 0
Global ViewY:Int = 0
Global viewSpeed:Int = 0
Global viewWinkel:Float = 0           

Global Splitscreen:Int = 1
Global ViewX2:Int = 0
Global ViewY2:Int = 0
Global viewSpeed2:Int = 0
Global viewWinkel2:Float = 0           



       
Global playerx = 200
Global playery = 200

Global levelschluss:Int = 0

LoadSoundSettings()                            
                           
             
'Graphikmodus initialisieren  
Global gfxOptions:TGFXOptions=New TGfxOptions
gfxOptions.Load()
gfxOptions.Init()


'incbin "sfx/menuLoop.ogg" 
'incbin "sfx/menuStart.ogg" 
'Incbin "sfx/gameMucke1.ogg"  
Global menuStart:TSound = LoadSound("sfx/menuStart.ogg")
Global menuLoop:TSound = LoadSound("sfx/menuLoop.ogg",True)
Global gameMucke1:TSound = LoadSound("sfx/gameMucke1.ogg",True)  
Global menuStartchannel:TChannel
'playMucke(mucke)


HideMouse()
                          
       
'Spiel im Menüstatus starten
Try
	GameManager.InitGameManager(New TMenuState)
Catch ex:Object
	RuntimeError(ex.ToString() + " Main.bmx-gamemanager.InitGameManager(New TMenuState)")	
End Try
                                 
Global playerShip:TGleiter = Null
Global aktuellerLevel:TLevel = Null
Global lastgamemode:TSpielmodus = Null
Global gdifficulty:Int = 0
Function setGameValues(chosenGameMode:TSpielmodus,level:TLevel,ship:TGleiter,difficulty:Int)
	playerShip=ship
	aktuellerLevel=level
	lastgamemode = chosengamemode
	gdifficulty = difficulty
End Function



'----------PLAY STATE-----------------'


Type TPlayState Extends TGameState
	Field StartTime:Int = MilliSecs()
	Field CurTime:Int = StartTime
	Field zeigeFPS:Int=0
	Field stime:Int
	Field Max1:Int = 0
	Field Min1:Int = 1000
	Field y2:Float = 0 'Radar
	
	Method enter(status:Int)
		SetImageFont(playFont)   
		HideMouse() 
		playMucke(gameMucke1)
	End Method


   Method Start()
	Try
        menuStartchannel.Stop
		
		'Spieler adden
        	           'Function create:TShip(pname$,posx#,posy#,pteam,pai,pschiff:TGleiter,autospawn:int)
				
		'erst Spieler entfernen, da vielleicht schon vorhanden
		'von vorigem Spielen
				
		Cls
		setsuperfont()
		DrawMiddleX(GetLang("LADEN..."),gfxoptions.scale(400))
		Flip
		
		aktuellerLevel.Init()
				
		'If aktuellerLevel.gegner.sh_list.Count() > 1 Then
		'	If (TShip(aktuellerlevel.gegner.sh_list.last())).ai = 0 Then
		'		aktuellerLevel.gegner.sh_list.RemoveLast()
		'	End If
		'End If
		
		
		If splitscreen = 1 Then
			aktuellerLevel.gegner.addship(Tship.Create(GetLang("Spieler2"), aktuellerLevel.playerx, aktuellerLevel.playery, 1, -1, playerShip,1))
			(TShip(aktuellerlevel.gegner.sh_list.last())).initship()
		End If
		
		aktuellerLevel.gegner.addship(Tship.Create(GetLang("Spieler1"), aktuellerLevel.playerx, aktuellerLevel.playery, 0, 0, playerShip,1))
		(TShip(aktuellerlevel.gegner.sh_list.last())).initship()

					
															
		'ships.addShip(Tship.Create("UFO1",1000, 850, 1,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(0)) ))
'		ships.addShip(Tship.Create("UFO2", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(1))))
		'ships.addShip(Tship.Create("UFO3", 1000, 850, 3,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(2))))
		'ships.addShip(Tship.Create("UFO4", 1000, 850, 4,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(3))))
        'ships.addShip(Tship.Create("UFO3", 1000, 850, 3,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(4))))
		'ships.addShip(Tship.Create("UFO4", 1000, 850, 4,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(5))))

			'radar3 = LoadImage("incbin::images/radar4.png")
			'hud2 = LoadImage("incbin::images/hud2.png")
	   	Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TPlayState-Start")	
		End Try
	End Method
		
			
	
	Method Process()
		Try
			If KeyHit(KEY_F11) Then 
				If zeigeFPS = 0 Then zeigeFPS = 1 Else zeigeFPS = 0
				'If zeigeXY = 0 Then zeigeXY = 1 Else zeigeXY = 0
			End If
					                   
			If KeyHit(KEY_F7) Then 
				'gfxOptions.gc=16
            	'gfxOptions.gw=800
            	'gfxOptions.gh=600
            	'gfxOptions.Init()
			End If
					
			If KeyHit(KEY_F4) Then
				If debugit = 1 Then				
					If aktuellerLevel.showpath = 1 Then
						aktuellerLevel.showpath = 0
					Else
						aktuellerLevel.showpath = 1
					End If
				End If
			End If
						
			If KeyHit(KEY_ESCAPE) Then
    	     	GameManager.PauseAndNew(New TMenuState,1)
				'gamemanager.PauseAndNew(new )
	        	Return
	    	EndIf


			If KeyHit(KEY_F1) Then
    	     	GameManager.PauseAndNew(New TMenuState,3)
				aktuellerlevel.f1away=1
				'gamemanager.PauseAndNew(new )
	        	Return
	    	EndIf

  
'			If KeyHit(KEY_M) Then
        	 	'GameManager.PauseAndNew(new TMenuState)
'	        	Return
	 '   	EndIf
	
		
			stime = MilliSecs()
			ResetCollisions
			
			
			'If KeyDown(KEY_NUMADD) Then If mainscale < 2 Then mainscale:+0.01
			'If KeyDown(KEY_NUMSUBTRACT) Then If mainscale > -2 Then mainscale:-0.01
			
			
			Cls
			'DrawMap(viewx, viewy)
		                                      
			aktuellerLevel.DoUpdateLevel(aktuellerLevel)
			
		
			If aktuellerLevel <> Null Then
					
			
			
			aktuellerLevel.arena.drawb()
			aktuellerLevel.arena.drawU()
			
			If splitscreen = 0 Then
				sternchen.Draw(ViewX/4,ViewY/4)
			Else
				SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()
				sternchen.Draw(ViewX/4,ViewY/4)
				SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()
				sternchen.Draw(ViewX2/4,ViewY2/4)
				SetViewport 0,0, GraphicsWidth(), GraphicsHeight()
			End If
			
			resetGFX()
			
			aktuellerLevel.arena.drawg()
			
			Local DeltaTime:Int = (MilliSecs() - CurTime);
			CurTime = CurTime + DeltaTime
			'Print MemAlloced()/1000 +"KB"
			partiklesOver.Update()
			aktuellerLevel.Items.Update
		
			'kugeln unter gegner sonst fliegen sie unter minen durch
			aktuellerLevel.gegner.Update99(DeltaTime) '99 aktualisiert station
			
			bullets.Update()
			
			aktuellerLevel.gegner.Update(DeltaTime)
			
			partikles.UpdateGo()				

			aktuellerLevel.arena.drawo()
			
			aktuellerLevel.drawPath() ' Aktuellen A* Pfad zeigen
			

						
			If Splitscreen = 1 Then
				
			
			Else
			
			
			End If			
			
			
			
			If aktuellerlevel.showradar = 1 Then 
				showradar(15,15)
			End If
			
			
			ResetGfx()
			
			
			If splitscreen = 1 Then
				SetColor 255,0,0
				SetBlend lightblend
				DrawRect GraphicsWidth()/2-5,0,10,GraphicsHeight()
				'DrawLine GraphicsWidth()/2,0,GraphicsWidth()/2,GraphicsHeight()
			End If
			
			
			resetgfx()
			
			If zeigeFPS=1 Then
				'DrawShadowText "Gleiter: " + ships.sh_list.count(), 10, 270    
				SetImageFont minifont
				DrawShadowText "FPS1: " + GetFPS(), 10, 300
				DrawShadowText "FPS2: " + GameManager.fps(), 10, 330
		
				If (MilliSecs()-stime) > Max1 Then Max1 = (MilliSecs()-stime)
				If (MilliSecs()-stime) < Min1 Then Min1 = (MilliSecs()-stime)	
				DrawShadowText "Frametime Now: " + (MilliSecs()-stime), 10, 360
				DrawShadowText "Frametime Max: " + Max1, 10, 390
				DrawShadowText "Frametime Min: " + Min1, 10, 420
				DrawShadowText "Memory: " + GCMemAlloced()/1024/1024 +"MB", 10, 450
			End If
		
			'flushmem()
			'Flip		
		
    		  'If KeyHit(KEY_SPACE) Then
		  	 'pausestate = self
			 'GameManager.PauseAndNew(New TMyOtherState)
    	     'GameManager.SetGameState(New TMyOtherState)
	     '    Return
    	  'EndIf
   
	      'x  :+ GameManager.FPS_Val(200.0)
		  'if x > 1000 then x = 0
	  
	      Draw()
	
		  setsuperfont()
		  If aktuellerLevel.drawred = 1 Then 
			  If aktuellerLevel.drawlevelx = -1 Then
			    aktuellerLevel.drawlevelx = (GraphicsWidth() - TextWidth(aktuellerLevel.drawlevel))/2
			  End If
		
			  DrawSuper(aktuellerLevel.drawlevel,gfxoptions.scale(aktuellerLevel.drawlevelx),gfxoptions.scale(aktuellerLevel.drawlevely),2)
		  Else
			  setsuperfont(2)
			  If aktuellerLevel.drawlevelx = -1 Then
			    aktuellerLevel.drawlevelx = (GraphicsWidth() - TextWidth(aktuellerLevel.drawlevel))/2
			  End If

			  DrawSuper(aktuellerLevel.drawlevel,gfxoptions.scale(aktuellerLevel.drawlevelx),gfxoptions.scale(aktuellerLevel.drawlevely),1)
		  End If
			
		
		
		  '->DrawTraining
			If aktuellerLevel.drawtrainingB = 1 Then
				
				resetgfx()
				
				Local height:Int
				If gfxoptions.getScaleFactor() = 1 Then
					SetImageFont levelfontg2
					height = levelfontg.height()
				Else
					SetImageFont levelfontg3
					height = levelfont.height()
				End If
								
				Local i
				Local dx
								
				Local ii:Int=0
				For Local str:String = EachIn aktuellerLevel.drawtraining  
					If str.trim() <> "" Then ii:+1
				Next
				
				
				SetColor 0,0,0
				SetBlend alphablend
				SetAlpha 0.6
				DrawRect gfxoptions.scale(0),gfxoptions.scale(10),gfxoptions.scale(1024),gfxoptions.scale(325)'(ii*(25+height))
				
				
				'rechteck height nach höhe des textes anpassen
				'height und width, sowie x,y an scale anpassen


				resetgfx()
				For Local st:String = EachIn aktuellerLevel.drawtraining  
					Local diff:Int = GraphicsWidth() - TextWidth(st)
					If diff > 0 Then
						dx = diff/2 + gfxoptions.scale(24)
						'If gfxoptions.getscalefactor() <> 1 Then
						'	dx = dx + (dx - Float((gfxoptions.scale(dx)/1.08)))
						'End If
					End If
					DrawText(st, dx, gfxoptions.scale(20)+i*gfxoptions.scale(32))
					i:+1
				Next          
				
'				For i = 0 To Len(aktuellerLevel.drawtraining)-1
'					DrawText(aktuellerlevel.drawtraining[i],gfxoptions.scale(200),gfxoptions.scale(200)+i*20)
'				Next
				
			End If
		  '<-DrawTraining
		
		
		
		  End If
		  resetgfx()
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TPlayState-Process")	
		End Try
		  
   End Method
      
   
   
   
   Method showradar(rx,ry:Int)
   	Try
		radarDeltaX = rx
		radarDeltaY = ry
	
		'radar
		resetgfx()
		
		SetScale 1,1
		
		Local deltax:Int = rx+7
		Local deltay:Int = ry+7
		Local w:Int = 90
		Local h:Int = 90
		
		SetColor 0,0,255
		
		SetAlpha 0.8
		    
		'Viereck um Radar
		DrawLine deltax,deltay,deltax+w,deltay
		DrawLine deltax,deltay,deltax,deltay+h
		DrawLine deltax,deltay+h,deltax+w,deltay+h
		DrawLine deltax+w,deltay,deltax+w,deltay+h
                         
		'Special Lines
		DrawLine deltax-2, deltay-2, deltax+w+2, deltay+2
		DrawLine deltax-2, deltay-2, deltax+2, deltay+h+2
		DrawLine deltax-2, deltay+h-2, deltax+w+2, deltay+h+2
		DrawLine deltax+w-2, deltay-2, deltax+w+2, deltay+h+2

		DrawLine deltax+2, deltay+2, deltax+w-2, deltay-2
		DrawLine deltax+2, deltay+2, deltax-2, deltay+h-2
		DrawLine deltax+2, deltay+h+2, deltax+w-2, deltay+h-2
		DrawLine deltax+w+2, deltay+2, deltax+w-2, deltay+h-2
		
		
		'balken links			
		DrawLine 0,deltay+h/3-3,deltax,deltay+h/3-3
		DrawLine 0,deltay+h/3+3,deltax,deltay+h/3+3
		DrawRect 0,deltay+h/3-1,deltax,3
		
		DrawLine 0,deltay+h/1.5-3,deltax,deltay+h/1.5-3
		DrawLine 0,deltay+h/1.5+3,deltax,deltay+h/1.5+3
		DrawRect 0,deltay+h/1.5-1,deltax,3
						
		SetRotation 0
		SetBlend ALPHABLEND
		SetAlpha 0.2
		SetColor 0,0,255
		DrawRect deltax, deltay, w, h
		
		SetColor 0,0,255
		DrawRect deltax, deltay, w,h
	
		SetColor 0,0,255
	
		
		'Gitternetz malen
		Local k,u:Int=deltax
		'vertikal
		For k = deltax To deltax+w
			DrawLine u,deltay,u,deltay+h
			'drawline deltax,u,deltax+100,deltay
			u:+10
			If u >=deltax+w Then Exit
		Next
		
		u:Int=deltay
		For k = deltay To deltay+w
			'drawline u,deltay,deltax,deltay+100
			DrawLine deltax,u,deltax+w,u
			u:+10
			If u >=deltay+h Then Exit
		Next
	
		
		'lines hoch und runter
		SetAlpha 0.3
		SetScale 1,1
		SetColor 255,255,255
		y2:+GameManager.FPS_Val(50)
		If y2 > 45 Then y2 = 5
		DrawRect deltax,(deltay+h/2)-y2,w,2
		DrawRect deltax,(deltay+h/2)+y2,w,2

			
		'punkte auf linien
		SetAlpha 0.3
		Local y3 = Rand(10,w-10)
		DrawRect deltax+y3, (deltay+h/2)-y2-2, 2, 4
		DrawRect deltax+y3, (deltay+h/2)+y2-23, 2, 4
			
		
		'zittern
		y3 = Rand(10,w-10)
		DrawLine deltax, deltay+y3, deltax+w, deltay+y3+5
	
	
		'y2 = rand(10,90)
		'drawrect 0,y2,100,y2+2
	
		'drawrect  0, 0, 110, 110
	
	
		 Rem 
		linksoben:+4
		setrotation linksoben
		setcolor 255,255,255
		setalpha 0.2
		drawimage media_scan, 130,80
		end rem 
	
		Rem 
		resetgfx()
		'SetScale 0.5,0.5
		setalpha 1
		setscale 1.3,1.3
		setblend alphablend
		DrawImage radar3,deltax-12,deltay-12
		
		setblend alphablend
		setscale 1,1
		
		resetgfx()
		end rem 
	Catch ex:Object
		RuntimeError(ex.ToString() + " Main.bmx-TPlayState-ShowRadar")	
	End Try
   End Method
 
   
   	Method Leave()
		Try
			'aktuellerLevel.gegner.releaseAllShips()
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TPlayState-leave")	
		End Try
	End Method

      
   Method Draw()
   End Method

End Type


  
                           


                            








             
                   

'---------------------------------------------------

'-------------MenuState-----------------------------
                
'---------------------------------------------------



Type TMenuState Extends TGameState
	Field background:TImage
	Field schrift1:TImage
	Field cursor1:TImage
	Field testback:TImage
	Field trennlinie:TImage
	Field ufopow:TImage
	Field f1hilfebild:TImage
	
	Field demoBild:TImage
	
	Field s0:TImage
	Field s1:TImage
	Field s2:TImage
	
	
	
	Field links1:TImage
	Field links2:TImage
	Field rechts1:TImage
	Field rechts2:TImage
	Field keinschiff:TImage
	
	
	Field anim:TImage
	Field animFrame:Int=0
	Field animWait:Int=0
	
	
	Field stern:TSterne
	Field gox:Int=0
	Field goy:Int=0
	               
	Field neuesSpiel:Int=0               
	
	
	'Menüs
	Field MainMenu:TMenu   
	Field GFXMenu:TMenu
	Field PauseMenu:TMenu
	Field F1HelpMenu:TMenu
	Field OptionsMenu:TMenu	
	
	Field demoMenu:TMenu
	
	Field ModusMenu:TMenu
	Field LevelMenu:TMenu
	Field ShipMenu:TMenu
	              
	Field difficultMenu:TMenu            
	
	'Graphikoptionen	                             
	Field agc:Int
	Field agw:Int
	Field agh:Int
	Field aDriver:String
	 
	'Soundoptionen
	Field effectChanger:TVolumeChanger
	Field muckeChanger:TVolumeChanger
	
	      	         
	'Spielpause aktiv = 1	      	      
	Field pauseActive:Int=0 
                  
              
	Field wrot:Int
	Field waffentimer:Int


    'Field menustate[]:String = ["MAINMENU","GFXMENU","PAUSEMENU","OPTIONSMENU","MODUSMENU","LEVELMENU","SHIPMENU"]
      
	Field menuStatus:Int=0 
	'0 UpdateMainMenu()
	'1 UpdateOptionsMenu()   
	'2 updateGFXMenu()       
	'3 UpdatePauseMenu() 
	 
	'4 UpdateSpielmodus()
	
	'5 UpdateLevelAuswahl()
	'6 UpdateSchiffAuswahl()
	'7 F1 Hilfe

	                           
	Field chosenGameMode:TSpielmodus=Null
	Field chosenLevel:TLevel=Null
	Field chosenDifficulty=0
	
'	Field chosenGleiter:TGleiter=Null
	Field shipCounter:Int=0		              


	Field messagetext:String
	Field showmessage1:Int
	Field meldungstart:Int	         
	Method showmessage(meldung$)
		messagetext = meldung
		showmessage1 = 1	
	End Method
	
	
	Method UpdateMainMenu()
		Try
		
			'SetColor 0,0,0
			'SetBlend alphablend
			'SetAlpha 0.6
			'DrawRect 0, gfxOptions.scale(330), gfxOptions.scale(1200),gfxOptions.scale(375)

		
			MainMenu.Update()			
			Select MainMenu.CheckItemDown()
				'Case 0 menuStatus = 4;initModiMenu() 'gameManager.PauseAndNew(New TPlayState,0)'4;initModiMenu()
				Case 0 menuStatus = 5;initLevelMenu() 'gameManager.PauseAndNew(New TPlayState,0)'4;initModiMenu()
				Case 1 menuStatus = 1
				Case 2 If istdemoversion = 1 Then initdemomenu() Else GameManager.newgamestate(Null,0)  
				Case 3 menuStatus = 2
				Case 4 If language = 0 Then OpenURL("www.workisover.de") Else OpenURL("www.workisover.com");GameManager.newgamestate(Null,0)
			End Select
			
			
			'SetColor 100,100,100
			'DrawImage(trennlinie,0,gfxOptions.scale(330))
			'DrawImage(trennlinie,0,gfxOptions.scale(605))
							
			
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TMenuState-updateMainMenu")	
		End Try
	End Method	
	                    
	
	
	'ugh
	Method enter(status:Int)
'		SetImageFont(superfont)

		initMainMenu()

		'Pause
		If status=1 Then
			pauseActive=1
			menuStatus=3
		End If
		
		'Levelende
		If status=2 Then
			menuStatus=5
			chosengamemode=LastGameMode
			initLevelMenu()
		End If
		
		'F1-Hilfebildschirm
		If status=3 Then
			menuStatus=7
		End If
		
		
		If status=4 Then ' durchgespielt
			menustatus = 9
		End If
		
		
		If status=99 Then
			initdemomenu()
		End If
		
		'If  Not ChannelPlaying(menustartchannel) Then
			playMucke(menuLoop)
		'End If
	End Method
		         
		
		
	Method Start()
		Try         
				
			'DebugStop
			menuStartchannel = PlayEffect(menuStart)
  
			neuesSpiel = 0

			agw = gfxOptions.gw
			agh = gfxOptions.gh
			agc = gfxOptions.gc
			aDriver = gfxOptions.treiber                           
		
			'background = loadimage("incbin::images/menu1.jpg")
			'background = LoadImage("incbin::images/menutest12_.jpg")
			
				background = LoadImage("images/menutest_f.jpg")
				schrift1 = LoadImage("images/schrift1.jpg")
				cursor1 = LoadImage("images/cursor2.png")
			
				ufopow = LoadImage("images/ufopower.png")
			
				trennlinie = LoadImage("images/trennlinie.png")
				            
				s0 = LoadImage("images/s0.png")
				s1 = LoadImage("images/s1.png")
				s2 = LoadImage("images/s2.png")

			
    	        links1 = LoadImage("images/links1.png")
        	    links2 = LoadImage("images/links2.png")
            	rechts1 = LoadImage("images/rechts1.png")
	            rechts2 = LoadImage("images/rechts2.png")
			
				If istDemoversion = 1 Then
					If language = 0 Then
						demobild = LoadImage("images/demo.jpg",MIPMAPPEDIMAGE)
					Else If language = 1 Then
						demobild = LoadImage("images/demoe.jpg",MIPMAPPEDIMAGE)
					End If
				End If
			
				keinschiff = LoadImage("images/keinschiff.png")
	
				If language = 0 Then
					f1hilfebild = LoadImage("images/f1hilfe.jpg",filteredimage)
				Else If language = 1 Then
					f1hilfebild = LoadImage("images/f1hilfee.jpg",filteredimage)
				End If
			
				anim = LoadAnimImage("images/anim2.png",200,100,0,18)
			
			'testback = LoadImage("images/weltall1.png")
			'testback = LoadImage("images/stars2.jpg")
			stern:TSterne = TSterne.Create(1000,GraphicsWidth()/2,GraphicsHeight()/2)
		
			MainMenu = TMenu.Create()
		
			PauseMenu = TMenu.Create()
			'create:TMenuItem(caption:string,x,y:int,alphaVal:float,blend:int,scaleVal:float,font:TImageFont, r,g,b)
			PauseMenu.AddMenuItem(TMenuItem.Create(GetLang("weiterspielen"),370, 350,1,4,1, superfont, 255, 255, 255,0))
			PauseMenu.AddMenuItem(TMenuItem.Create(GetLang("Sound-OPTIONEN"),370, 400,1,4,1, superfont, 255,255, 255,1))
			PauseMenu.AddMenuItem(TMenuItem.Create(GetLang("Graphik-OPTIONEN"),370, 450,1,4,1, superfont, 255,255, 255,3))
			PauseMenu.AddMenuItem(TMenuItem.Create(GetLang("Spiel abbrechen"),370, 500,1,4,1, superfont, 255, 255, 255,2))
			PauseMenu.AddMenuItem(TMenuItem.Create(GetLang("zu Windows"),370, 550,1,4,1, superfont, 255, 255, 255,4))
			PauseMenu.setMiddleX()
 
			'Case 2 initMainMenu();pauseActive=0;GameManager.killPaused()   


			demomenu = TMenu.create()

			F1HelpMenu = TMenu.create()
			'PauseMenu.AddMenuItem(TMenuItem.Create("weiterspielen",370, 350,1,4,1, superfont, 255, 255, 255,0))
                 
			OptionsMenu = TMenu.Create()       
			OptionsMenu.AddMenuItem(TMenuItem.Create(GetLang("ZURÜCK"),262, 600,1,4,1, superfont, 255, 255, 255,0))
						'		vx,vy,vw,vh:Int, minValue:Float,maxValue:Float,stepValue:Int
			effectChanger = TVolumeChanger.Create(262,350,0)
			effectChanger.SetStep(5)
			muckeChanger = TVolumeChanger.Create(262,500,1)
			muckeChanger.SetStep(5)
		                             
		    GFXMenu = TMenu.Create()
			GFXMenu.AddMenuItem(TMenuItem.Create(GetLang("ZURÜCK"),200, 570,1,4,1, superfont, 255, 255, 255,0))
		    GFXMenu.AddMenuItem(TMenuItem.Create(GetLang("ÄNDERUNGEN SPEICHERN"),450,570,1,4,1, superfont, 255, 255, 255,1))			
			GFXMenu.AddMenuItem(TMenuItem.Create(GetLang("ÄNDERN"),650, 325,1,4,1, superfont, 255, 255, 255,2))
			GFXMenu.AddMenuItem(TMenuItem.Create(GetLang("ÄNDERN"),650, 400,1,4,1, superfont, 255,255, 255,3))
			GFXMenu.AddMenuItem(TMenuItem.Create(GetLang("ÄNDERN"),650, 475,1,4,1, superfont, 255,255, 255,4))
			                  
			ModusMenu = TMenu.Create() 
			LevelMenu = TMenu.Create()
		
			difficultMenu = TMenu.Create()

			ShipMenu = TMenu.Create()
			ShipMenu.AddMenuItem(TMenuItem.Create(GetLang("ZURÜCK"),250, 650,1,4,1, superfont, 255, 255, 255,0))
		    ShipMenu.AddMenuItem(TMenuItem.Create(GetLang("LEVEL STARTEN"),500,650,1,4,1, superfont, 255, 255, 255,1))			
			
			'ShipMenu.AddMenuItem(TMenuItem.Create("->",240, 500,1,4,1, superfont, 255,255, 255,2))
			'ShipMenu.AddMenuItem(TMenuItem.Create("<-",200, 500,1,4,1, superfont, 255,255, 255,3))

			'ShipMenu.AddMenuItem(TMenuItem.iCreate("->",240, 500,2,0,rechts1,rechts2))
			'ShipMenu.AddMenuItem(TMenuItem.iCreate("<-",200, 500,3,0,links1,links2))
			
			ShipMenu.AddMenuItem(TMenuItem.iCreate("->", 280, 255, 2, 0, rechts1, rechts2))
			ShipMenu.AddMenuItem(TMenuItem.iCreate("<-", 180, 255, 3, 0, links1, links2))
	
			MoveMouse GraphicsWidth()/2, GraphicsHeight()/2  
			
			'DebugStop
			
			
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TMenuState-start")	
		End Try
	End Method
                     
                    
	Method setMenuFont()
		resetgfx()
	
		If gfxoptions.getscalefactor() = 1 Then
			SetImageFont superfont
		Else
			SetImageFont superfont
'			SetImageFont superfont8
		End If
				
'			SetImageFont superfont
			SetBlend LIGHTBLEND
			SetColor 255,255,255
			SetAlpha 1
	End Method

    
                   
    Method incRes()
    	If agw = 800 Then
    		agw = 1024
    		agh = 768
    	Else
    		agw = 800
    		agh = 600
    	End If
    End Method
    
    
    Method incagc()
   		Select agc
   			Case 16 agc = 24
   			Case 24 agc = 32
   			Case 32 agc = 16
   		End Select
    End Method
          
	Method incDriver()
    	If aDriver = "opengl" Then
    		aDriver = "directx"
    	Else
    		aDriver = "opengl"
    	End If
	End Method                
                   
                 
                   
                   
	Method updateGFXMenu()
		Try
		
			SetColor 0,0,0
			SetBlend alphablend
			SetAlpha 0.5
			DrawRect 0, gfxOptions.scale(300), gfxOptions.scale(1200),gfxOptions.scale(235)

		
			GFXMenu.Update()   
            setMenuFont()

			DrawText(GetLang("AUFLÖSUNG: ")+agw+"x"+agh,gfxOptions.scale(200), gfxOptions.scale(325))
			DrawText(GetLang("FARBTIEFE: ")+agc+"Bit",gfxOptions.scale(200), gfxOptions.scale(400))
			DrawText(GetLang("TREIBER: ")+aDriver, gfxOptions.scale(200), gfxOptions.scale(475))
								
			Select GFXMenu.CheckItemDown()
				Case 0 If pauseActive=1 Then menuStatus = 3 Else initMainMenu()    
				Case 1 gfxoptions.setValues(aDriver,agw, agh, agc)
				Case 2 incRes()
				Case 3 incagc()     
				Case 4 incDriver()
			End Select
			
			SetColor 100,100,100
			DrawImage(trennlinie,0,gfxOptions.scale(300))
			DrawImage(trennlinie,0,gfxOptions.scale(535))
			
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TMenuState-updateGFXMenu")	
		End Try
	End Method
                


	Method initDemoMenu()
		menustatus = 99
		demoMenu.clearMenuItems()
		demoMenu.AddMenuItem(TMenuItem.Create(GetLang("Vollversion holen"),450, 710,1,4,1, superfont, 255,255, 255,0))
		demoMenu.AddMenuItem(TMenuItem.Create(GetLang("Vielleicht später"),750, 710,1,4,1, superfont, 255,255, 255,1))
		'MainMenu.AddMenuItem(TMenuItem.Create("",400, 400,1,4,1, superfont, 255,255, 255,0))
	
	End Method


	
	Method updateDemoMenu()
		Try
			If gfxoptions.gw = 800 Then
				SetScale 0.78,0.78
			End If
		
			DrawImage demobild,0,0
		
			resetgfx()
		
			demomenu.Update()
			
			'setMenuFont()
			
			Local iid:Int = demomenu.CheckItemDown()
			
			If iid = 0 Then
				'system_ "http://www.workisover.de"
				'system_ "www.workisover.de"
				'system_ "calc.exe"
				
				'Windows:
				'system_ "shellexecute(Null,'open', 'http://www.workisover.de', Null, 'c:\\', SW_SHOWNORMAL)"
			
				'superProc=TProcess.Create("Notepad",0)
				'superProc=TProcess.Create("http://www.workisover.de",0)
				
				If language = 0 Then
					OpenURL("www.workisover.de")
				Else If language = 1 Then
					OpenURL("www.workisover.com")
				End If
								
				'system_ "www.workisover.de"
				'execfile "http://www.workisover.de"

				'If superProc.Status()
				'	Notify "Notepad is still running"
				'Else
				'	Notify "nix notepad"
				'EndIf
				

				'system_("ShellExecute(Null,'open','http://www.workisover.com',null, null, SW_NORMAL)")
				
				'Mac:
				'system("open http://www.workisover.de")
								
				
				GameManager.newgamestate(Null,0) 			
			Else If iid = 1 Then
				GameManager.newgamestate(Null,0) 			
			Else If iid = 2 Then
				'..
			End If
					
			
			'DrawMiddleX("Wähle einen Schwierigkeitsgrad",gfxOptions.scale(190))
			
			'DrawImage(s0, gfxoptions.scale(400), gfxoptions.scale(320))
			'DrawImage(s1, gfxoptions.scale(400), gfxoptions.scale(420))
			'DrawImage(s2, gfxoptions.scale(400), gfxoptions.scale(520))
			
			'SetColor 100,100,100
			'DrawImage(trennlinie,0,gfxOptions.scale(235))
			'DrawImage(trennlinie,0,gfxOptions.scale(635))
			
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TMenuState-updatedemomenu")	
		End Try
	End Method



	Method initMainMenu()     
		menuStatus=0
		MainMenu.ClearMenuItems()
		'create:TMenuItem(caption:string,x,y:int,alphaVal:float,blend:int,scaleVal:float,font:TImageFont, r,g,b)
		MainMenu.AddMenuItem(TMenuItem.Create(GetLang("SPIELEN"),400, 350,1,4,1, superfont, 255, 255, 255,0))
		MainMenu.AddMenuItem(TMenuItem.Create(GetLang("SOUND-OPTIONEN"),400, 400,1,4,1, superfont, 255,255, 255,1))
		MainMenu.AddMenuItem(TMenuItem.Create(GetLang("GRAPHIK-OPTIONEN"),400, 450,1,4,1, superfont, 255,255, 255,3))
		MainMenu.AddMenuItem(TMenuItem.Create(GetLang("BEENDEN"),400, 500,1,4,1, superfont, 255, 255, 255,2))

		If istdemoversion = 1 Then
			MainMenu.AddMenuItem(TMenuItem.Create(GetLang("Vollversion holen"),400, 550,1,4,1, superfont, 255, 255, 255,4))
		End If
		
		setMenuFont()
		MainMenu.setMiddleX()
		chosenGameMode=gmChapter1
	End Method



	Method initModiMenu()
		Local idCounter=2
		ModusMenu.ClearMenuItems() 
		
		For Local mu:TSpielmodus = EachIn Spielmodi.modi
			ModusMenu.AddMenuItem(TMenuItem.Create(mu.Bezeichnung, 210, 270+((idcounter-2)*50),1,4,1, superfont, 255, 255, 255,idcounter,1))
			idcounter:+1			                             
		Next                 
		setMenuFont()
		ModusMenu.setMiddlex()
		ModusMenu.AddMenuItem(TMenuItem.Create(GetLang("ZURÜCK"),315, 650,1,4,1, superfont, 255, 255, 255,0))
		ModusMenu.AddMenuItem(TMenuItem.Create(GetLang("WEITER"),565,650,1,4,1, superfont, 255, 255, 255,1))			
		ModusMenu.setPointItem(2)
	End Method                    
			
			
              
                    
	Method initLevelMenu()
		If aktuellerlevel <> Null Then aktuellerlevel.freelevel()
		aktuellerlevel = Null
		'If chosenlevel <> Null Then chosenlevel.freelevel()
		chosenlevel = Null
		'FlushMem()

		Local idCounter=2
		LevelMenu.ClearMenuItems() 
		Local zaehler:Int=1
		Local goleft:Int=0
		Local yp:Int = 0
		Local lcount:Int = 0
		For Local mu:TLevel = EachIn chosenGameMode.Levels
'				Function Create:TMenuItem(Caption:String,x,Y:Int,alphaVal:Float,blend:Int,scaleVal:Float,font:TImageFont,R,G,B:Int,id:Int,PointItem:Int=0)
			If zaehler = 11 Then 
				goleft = 340
				yp = 10
			End If
			
			If zaehler = 21 Then 
				goleft = 680
				yp = 20
			End If
			
			'LevelMenu.AddMenuItem(TMenuItem.Create(mu.Bezeichnung, 210, 265+((idcounter-2)*50),1,4,1, levelfont, 255, 255, 255,idcounter,1))
			Local gfont:TImagefont=Null
			If gfxoptions.getScaleFactor() = 1 Then
				gfont = levelfontg
			Else
				gfont = levelfont
			End If
			
			If levelFortschritt.levels[lcount] = 0 Then 
				LevelMenu.AddMenuItem(TMenuItem.Create(mu.Bezeichnung, 38+goleft, 260+((idcounter-2-yp)*35),1,4,1, gfont, 255, 0, 0, idcounter,-1))
			Else If levelFortschritt.levels[lcount] > 0 Then 
				LevelMenu.AddMenuItem(TMenuItem.Create(mu.Bezeichnung, 38+goleft, 260+((idcounter-2-yp)*35),1,4,1, gfont, 255, 255, 255,idcounter))
			End If
			
			'idcounter
			'levelFortschritt.levels[]
			
			idcounter:+1			                             
			zaehler:+1
			lcount:+1
		Next     
		setMenuFont()   
		'LevelMenu.setMiddlex()
		
		LevelMenu.AddMenuItem(TMenuItem.Create(GetLang("ZURÜCK"), 150, 690,1,4,1, superfont, 255, 255, 255,0))
		
		'LevelMenu.AddMenuItem(TMenuItem.Create("ZURUECK", 315, 650,1,4,1, superfont, 255, 255, 255,0))
		'LevelMenu.AddMenuItem(TMenuItem.Create("WEITER", 565, 650,1,4,1, superfont, 255, 255, 255,1))			

'		LevelMenu.AddMenuItem(TMenuItem.Create("WEITER", 565, 700,1,4,1, superfont, 255, 255, 255,1))			
		
		'LevelMenu.setPointItem(2)
	End Method                    
    

            
    Method initdifficultMenu()
		chosendifficulty = 0
		difficultmenu.ClearMenuItems()
		setMenuFont() 
		difficultmenu.AddMenuItem(TMenuItem.Create(GetLang("EINFACH"), 450, 320,1,4,1, superfont, 255, 255, 255,0))
		difficultmenu.AddMenuItem(TMenuItem.Create(GetLang("NORMAL"), 450, 420,1,4,1, superfont, 255, 255, 255,1))
		difficultmenu.AddMenuItem(TMenuItem.Create(GetLang("PROFI"), 450, 520,1,4,1, superfont, 255, 255, 255,2))
	End Method

             

    Method updatedifficultMenu()
		Try
			'levelmenu.update()
			SetColor 0,0,0
			SetBlend alphablend
			SetAlpha 0.5
			DrawRect 0, gfxOptions.scale(238), gfxOptions.scale(1200),gfxOptions.scale(397)
			
			
			difficultmenu.Update()			
			
			resetgfx() 
			setMenuFont()
			Local iid:Int = difficultmenu.CheckItemDown()
			
			If iid = 0 Then
				chosendifficulty = 0
			Else If iid = 1 Then
				chosendifficulty = 1
			Else If iid = 2 Then
				chosendifficulty = 2
			End If
			
			If iid > -1 Then
				neuesspiel = 1
				setGameValues(chosengamemode,chosenLevel,TGleiter(gleiterSammlung.gleiters.ValueAtIndex(shipCounter)),chosendifficulty)
				If (istdemoversion=1) And (chosenlevel.id > 5) Then
					initdemomenu()
				Else
					GameManager.NewGameState(New TPlayState,0)			
				End If
			End If
			
			If neuesSpiel = 1 Then Return
			
			DrawMiddleX(GetLang("Wähle einen Schwierigkeitsgrad"),gfxOptions.scale(190))
			
			DrawImage(s0, gfxoptions.scale(400), gfxoptions.scale(320))
			DrawImage(s1, gfxoptions.scale(400), gfxoptions.scale(420))
			DrawImage(s2, gfxoptions.scale(400), gfxoptions.scale(520))
			
			SetColor 100,100,100
			DrawImage(trennlinie,0,gfxOptions.scale(235))
			DrawImage(trennlinie,0,gfxOptions.scale(635))
			
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TMenuState-updatedifficultmenu")	
		End Try
		
	End Method
	
	
	
	Method UpdateLevelAuswahl()
		Try
			SetColor 0,0,0
			SetBlend alphablend
			SetAlpha 0.5
			DrawRect 0, gfxOptions.scale(238), gfxOptions.scale(1200),gfxOptions.scale(387)

		
			LevelMenu.Update()			
			resetgfx() 
			setMenuFont()
        	'DrawMiddle("SOUNDEFFEKTE",400*gfxOptions.getscaleFactor(),300*gfxOptions.getscaleFactor(),TextWidth("soundeffekte"))
			'DrawMiddle("MUSIK",400*gfxOptions.getscaleFactor(),450*gfxOptions.getscaleFactor(),TextWidth("soundeffekte"))
			
			Local iid:Int = LevelMenu.CheckItemDown()
			
			If iid = 0 Then
				menuStatus=0
				initMainMenu()
			Else If iid > 1 Then
				'Case 1 menuStatus=6;chosenLevel = TLevel(chosenGameMode.levels.ValueAtIndex(LevelMenu.GetPointItem()-2))
				menustatus=6
				chosenLevel = TLevel(chosenGameMode.levels.ValueAtIndex(iid-2))
			End If
		
			'chosenLevel = TLevel(chosenGameMode.levels.ValueAtIndex(LevelMenu.GetPointItem()-2))			
			
			
			'Beschreibung anzeigen
			If levelMenu.getItemOver() > 1 Then
				DrawMiddleX(TLevel(chosenGameMode.levels.ValueAtIndex(levelMenu.getItemOver()-2)).beschreibung,gfxOptions.scale(640))	   
				'DrawText("REKORD: " + TLevel(chosenGameMode.levels.ValueAtIndex(levelMenu.getItemOver()-2)).Rekord, gfxOptions.scale(400), gfxOptions.scale(700))	   
				If levelMenu.getItemOver() > 2 Then
					'If levelrekord.arten[TLevel(chosenGameMode.levels.ValueAtIndex(levelMenu.getItemOver()-2)).id-1] = 3 Then
						Local text0:String = "HIGHSCORES: "
						Local text1:String = levelrekord.levels[TLevel(chosenGameMode.levels.ValueAtIndex(levelMenu.getItemOver()-2)).id-1]
						Local text2:String = levelrekord.levels1[TLevel(chosenGameMode.levels.ValueAtIndex(levelMenu.getItemOver()-2)).id-1]
						Local text3:String = levelrekord.levels2[TLevel(chosenGameMode.levels.ValueAtIndex(levelMenu.getItemOver()-2)).id-1]

						DrawText(text0, gfxOptions.scale(300), gfxOptions.scale(690))
						DrawImage(s0,20+gfxOptions.scale(300)+TextWidth(text0), gfxOptions.scale(690))
						DrawText(text1, 20+gfxOptions.scale(300)+ImageWidth(s0)+TextWidth(text0), gfxOptions.scale(690))	   

						SetColor 0,0,255
						DrawImage(s1,20+gfxOptions.scale(300)+TextWidth(text0)+TextWidth(text1)+50+ImageWidth(s0), gfxOptions.scale(690))
						DrawText(text2, 20+gfxOptions.scale(300)+TextWidth(text0)+TextWidth(text1)+50+ImageWidth(s0)+ImageWidth(s1), gfxOptions.scale(690))	   

						SetColor 255,255,0
						DrawImage(s2, 20+gfxOptions.scale(300)+TextWidth(text0)+TextWidth(text1)+50+TextWidth(text2)+50+ImageWidth(s0)+ImageWidth(s1), gfxOptions.scale(690))
						DrawText(text3, 20+gfxOptions.scale(300)+TextWidth(text0)+TextWidth(text1)+50+TextWidth(text2)+50+ImageWidth(s0)+ImageWidth(s1)+ImageWidth(s2), gfxOptions.scale(690))	   
						SetColor 255,255,255

					'Else
					'	DrawText("REKORD: " + levelrekord.levels[TLevel(chosenGameMode.levels.ValueAtIndex(levelMenu.getItemOver()-2)).id-1], gfxOptions.scale(300), gfxOptions.scale(690))	   
					'End If
									
					If levelrekord.arten[TLevel(chosenGameMode.levels.ValueAtIndex(levelMenu.getItemOver()-2)).id-1] > 0 Then
						DrawText(levelrekord.art[levelrekord.arten[TLevel(chosenGameMode.levels.ValueAtIndex(levelMenu.getItemOver()-2)).id-1]-1], gfxOptions.scale(300), gfxOptions.scale(730))	   
					End If			
				End If
			End If
			  
			';DrawMiddleX(chosenGameMode.beschreibung,510)
			'DrawMiddleX("Wähle einen Level", gfxOptions.scale(350),gfxOptions.scale(200))
			DrawMiddleX(GetLang("Wähle einen Level"),gfxOptions.scale(190))

			resetgfx()
			SetBlend lightblend

			Local idCounter=2
			Local zaehler:Int=1
			Local goleft:Int=0
			Local yp:Int = 0
			Local lcount:Int = 0

			For Local mu:TLevel = EachIn chosenGameMode.Levels
				If zaehler = 11 Then 
					goleft = 340
					yp = 10
				End If
			
				If zaehler = 21 Then 
					goleft = 680
					yp = 20
				End If
			
				If gfxoptions.getScaleFactor() = 1 Then
				
				Else
					SetScale 0.78,0.78
				End If
			
				If levelFortschritt.levels[lcount] = 2 Then 
					DrawImage(s0, gfxoptions.scale(8+goleft), gfxoptions.scale(260+((idcounter-2-yp)*35)))
				Else If levelFortschritt.levels[lcount] = 3 Then 
					DrawImage(s1, gfxoptions.scale(8+goleft), gfxoptions.scale(260+((idcounter-2-yp)*35)))
				Else If levelFortschritt.levels[lcount] = 4 Then 
					DrawImage(s2, gfxoptions.scale(8+goleft), gfxoptions.scale(260+((idcounter-2-yp)*35)))
				End If
			
				idcounter:+1			                             
				zaehler:+1
				lcount:+1
			Next     
												
			resetgfx()
			SetColor 100,100,100
			
			DrawImage(trennlinie,0,gfxOptions.scale(235))
			
			'DrawImage(trennlinie,0,gfxOptions.scale(575))
			DrawImage(trennlinie,0,gfxOptions.scale(625))

		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TMenuState-updatelevelauswahl")	
		End Try
	End Method
             


                
	Method UpdateSpielmodus()
		Try
			ModusMenu.Update()			
			resetgfx() 
			setMenuFont()
        	'DrawMiddle("SOUNDEFFEKTE",400*gfxOptions.getscaleFactor(),300*gfxOptions.getscaleFactor(),TextWidth("soundeffekte"))
			'DrawMiddle("MUSIK",400*gfxOptions.getscaleFactor(),450*gfxOptions.getscaleFactor(),TextWidth("soundeffekte"))
			Select ModusMenu.CheckItemDown()
				Case 0 initMainMenu()'menuStatus=0
				Case 1 menuStatus=5;initLevelMenu()
			End Select
			
			Select ModusMenu.GetPointItem()
				Case 2 chosenGameMode=gmChapter1;DrawMiddleX(chosenGameMode.beschreibung,gfxOptions.scale(590))
				'Case 3 chosenGameMode=gmChapter2;DrawMiddleX(chosenGameMode.beschreibung,gfxOptions.scale(590))
                'Case 4 chosenGameMode=gmChapter3;DrawMiddleX(chosenGameMode.beschreibung,gfxOptions.scale(590))
				'Case 5 chosenGameMode=gmChapter4;DrawMiddleX(chosenGameMode.beschreibung,gfxOptions.scale(590))
				'Case 6 chosenGameMode=gmChapter5;DrawMiddleX(chosenGameMode.beschreibung,gfxOptions.scale(590))
				Case 7 DrawMiddleX("",510)   
            	Default chosenGameMode=Null
			End Select        
			
			'DrawText("Wähle einen Quadrant", gfxOptions.scale(350),gfxOptions.scale(200))
			DrawMiddleX(GetLang("Wähle einen Quadrant"),gfxOptions.scale(190))

			DrawImage(trennlinie,0,gfxOptions.scale(235))
			DrawImage(trennlinie,0,gfxOptions.scale(635))

		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TMenuState-updatespielmodus")	
		End Try
	End Method
	




	Method UpdateSchiffAuswahl()                   
		Try
		
			SetColor 0,0,0
			SetBlend alphablend
			SetAlpha 0.5
			DrawRect 0, gfxOptions.scale(238), gfxOptions.scale(1200),gfxOptions.scale(397)
		
			ShipMenu.Update()			

			resetgfx() 
			setMenuFont()
        	'DrawMiddle("SOUNDEFFEKTE",400*gfxOptions.getscaleFactor(),300*gfxOptions.getscaleFactor(),TextWidth("soundeffekte"))
			'DrawMiddle("MUSIK",400*gfxOptions.getscaleFactor(),450*gfxOptions.getscaleFactor(),TextWidth("soundeffekte"))
			Select ShipMenu.CheckItemDown()
				Case 0 menuStatus = 5 
				'Case 1 setGameValues(chosengamemode,chosenLevel,TGleiter(gleiterSammlung.gleiters.ValueAtIndex(shipCounter)));GameManager.NewGameState(New TPlayState,0)'GameManager.PauseAndNew(New TPlayState,0)'GameManager.NewGameState(New TPlayState,0)
				Case 1 menustatus=10;initdifficultmenu() 

				Case 2 shipCounter:+1
				Case 3 shipCounter:-1
				'Case 0 If pauseActive=1 Then menuStatus = 3 Else menuStatus=0
			End Select 
			
			If neuesSpiel = 1 Then Return
			
			'If shipCounter > gleiterSammlung.gleiters.Count()-1 Then shipCounter = 0
			'If shipCounter < 0 Then shipCounter = gleiterSammlung.gleiters.Count()-1
			If shipCounter > 5 Then shipCounter = 0
			If shipCounter < 0 Then shipCounter = 5
			
			
			
			resetgfx()
			SetBlend ALPHABLEND
			SetAlpha 0.7
			SetScale gfxOptions.getScaleFactor(),gfxOptions.getScaleFactor()

			
			DrawImage(TGleiter(gleiterSammlung.gleiters.ValueAtIndex(shipCounter)).imageMenu ,gfxOptions.scale(80),gfxOptions.scale(330))
			
			If istdemoversion = 1 And shipcounter > 0 Then
				DrawImage(keinschiff ,gfxOptions.scale(80),gfxOptions.scale(330))
				SetScale 1,1
				setMenuFont()   
				DrawText(GetLang("NUR IN DER VOLLVERSION VERFÜGBAR"),gfxOptions.scale(480),gfxOptions.scale(520))
				TMenuItem(ShipMenu.menuitems.valueatindex(1)).aktiv = 0
			Else
				TMenuItem(ShipMenu.menuitems.valueatindex(1)).aktiv = 1
			End If
			

			SetScale 1,1
			setMenuFont()   
		
			
			'DrawText("Wähle ein Raumschiff", gfxOptions.scale(350),gfxOptions.scale(200))
   			DrawMiddleX(GetLang("Wähle ein Raumschiff"),gfxOptions.scale(190))

	        DrawText(TGleiter(gleiterSammlung.gleiters.ValueAtIndex(shipCounter)).bezeichnung, gfxOptions.scale(500),gfxOptions.scale(270))
			

			Local i:Int	
			'lifepower
			SetBlend lightblend
			SetAlpha 0.9
			
			Local geschW:Int = TextWidth(GetLang("Geschwindigkeit:"))
			Local SchildW:Int = TextWidth(GetLang("Schildenergie:"))
			Local WendW:Int = TextWidth(GetLang("Wendigkeit:"))

			
			'Schildenergie
			For i = 1 To getlifepower(Int(TGleiter(gleiterSammlung.gleiters.ValueAtIndex(shipCounter)).life))
				DrawImage(ufopow,gfxOptions.scale(480)+TextWidth(GetLang("Geschwindigkeit:"))+i*30, gfxOptions.scale(350))			
			Next
			
			'Geschwindigkeit
			For i = 1 To getmaxspeedpower(Int(TGleiter(gleiterSammlung.gleiters.ValueAtIndex(shipCounter)).maxspeed))
				DrawImage(ufopow,gfxOptions.scale(480)+TextWidth(GetLang("Geschwindigkeit:"))+i*30, gfxOptions.scale(400))			
			Next

			'Wendigkeit
			For i = 1 To getwinkelspeedpower(Int(TGleiter(gleiterSammlung.gleiters.ValueAtIndex(shipCounter)).winkelspeed))
				DrawImage(ufopow,gfxOptions.scale(480)+TextWidth(GetLang("Geschwindigkeit:"))+i*30, gfxOptions.scale(450))			
			Next
			resetgfx()
			setmenufont()

			DrawText(GetLang("Schildenergie:"), gfxOptions.scale(480)+geschw-schildw,gfxOptions.scale(350))
			DrawText(GetLang("Geschwindigkeit:"), gfxOptions.scale(480),gfxOptions.scale(400))
			DrawText(GetLang("Wendigkeit:"), gfxOptions.scale(480)+geschw-wendw,gfxOptions.scale(450))
			
'			DrawText("Schildenergie: " + Int(TGleiter(gleiterSammlung.gleiters.ValueAtIndex(shipCounter)).life), gfxOptions.scale(500),gfxOptions.scale(350))
'			DrawText("Geschwindigkeit: " + TGleiter(gleiterSammlung.gleiters.ValueAtIndex(shipCounter)).maxspeed, gfxOptions.scale(500),gfxOptions.scale(400))
'			DrawText("Wendigkeit: " + TGleiter(gleiterSammlung.gleiters.ValueAtIndex(shipCounter)).winkelSpeed, gfxOptions.scale(500),gfxOptions.scale(450))
			                                                                  
			
			SetColor 100,100,100
			DrawImage(trennlinie,0,gfxOptions.scale(235))
			DrawImage(trennlinie,0,gfxOptions.scale(635))

			
			
			Rem
			resetgfx()
			DrawImage anim,200,300,animFrame
			Local time = MilliSecs()
			If time > animWait + 100 Then
				animFrame:+1
				If animFrame > 17 Then animFrame = 0
				animWait = MilliSecs()
			End If
			end rem
			
			
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TMenuState-updateSchiffauswahl")	
		End Try
	End Method                  
              


	Method UpdateOptionsMenu()
		Try
			SetColor 0,0,0
			SetBlend alphablend
			SetAlpha 0.5
			DrawRect 0, gfxOptions.scale(278), gfxOptions.scale(1200),gfxOptions.scale(300)
				
			muckeChanger.show()
			effectChanger.show()

			OptionsMenu.Update()			
			resetgfx()
            setMenuFont()
			DrawText(GetLang("SOUNDEFFEKTE"),262*gfxOptions.getscaleFactor(),300*gfxOptions.getscaleFactor())
			DrawText(GetLang("MUSIK"),262*gfxOptions.getscaleFactor(),450*gfxOptions.getscaleFactor())
			Select OptionsMenu.CheckItemDown()
				Case 0 If pauseActive=1 Then menuStatus = 3 Else initMainMenu();SaveSoundSettings()
			End Select

			SetColor 100,100,100
			DrawImage(trennlinie,0,gfxOptions.scale(275))
			DrawImage(trennlinie,0,gfxOptions.scale(575))
			
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TMenuState-updateOptionsMenu")	
		End Try
	End Method


	Method UpdateF1HelpMenu()
		Try              
			Cls
			
			If gfxoptions.getscalefactor() = 1 Then
				'SetScale 1.35,1.2
				SetScale 1.28,1.28

				DrawImage f1hilfebild,0,0
			Else			
				DrawImage f1hilfebild,0,0
			End If		
			
			
			'If waffenTimer = 0 Then 
			'	waffenTimer = MilliSecs()
			'Else
			'	If MilliSecs() > waffenTimer + 5 Then
			'		wRot = wRot + 1
			'		waffenTimer=0
			'	End If
			'End If         
			'SetBlend ALPHABLEND
			'SetRotation wRot
			
			'DrawImage TSchussart(schussarten.schuesse.valueatindex(0)).simagelevel,50,80
			'DrawImage TSchussart(schussarten.schuesse.valueatindex(1)).simagelevel,100,80
			'DrawImage TSchussart(schussarten.schuesse.valueatindex(2)).simagelevel,200,80
			'DrawImage TSchussart(schussarten.schuesse.valueatindex(3)).simagelevel,300,80
			'DrawImage TSchussart(schussarten.schuesse.valueatindex(4)).simagelevel,400,80
			'DrawImage TSchussart(schussarten.schuesse.valueatindex(5)).simagelevel,500,80
			'DrawImage TSchussart(schussarten.schuesse.valueatindex(6)).simagelevel,600,80
			'DrawImage TSchussart(schussarten.schuesse.valueatindex(7)).simagelevel,700,80
			'DrawImage TSchussart(schussarten.schuesse.valueatindex(8)).simagelevel,800,80
			'SetRotation 0
			
			
			'SetRotation MilliSecs()
				'Schild
				'Life
				'Booster
				'Radar	
			'SetRotation 0
						
						
			'setMenuFont()
			
			'DrawText "Bezeichnung:",10,150
			'DrawText "Schaden:",10,170
			'DrawText "Reichweite:",10,190
			'DrawText "Geschwindigkeit:",10,210
			'DrawText "Verzögerung:",10,230
			'DrawText "Munition:",10,250
						
									
	'bezeichnung
	'damage
	'lifetime
	'speed
	'sdelay
	'startmun
																					
		
		     

			'.setMiddleX()
			F1HelpMenu.Update()			
			'Select F1HelpMenu.CheckItemDown()
			'	Case 0 GameManager.GoToPausedAndKill()
			'	Case 1 menuStatus = 1
			'	Case 2 initMainMenu();pauseActive=0;GameManager.killPaused()   
			'	Case 3 menuStatus = 2    
			'	Case 4 GameManager.Newgamestate(Null,0)
			'End Select
			
			If KeyHit(KEY_F1) Then
				GameManager.GoToPausedAndKill()
			End If
			
			If KeyHit(key_escape) Then
				GameManager.GoToPausedAndKill()
			End If
			
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TMenuState-updateF1HelpMenu")	
		End Try
	
	End Method



	Method UpdatePauseMenu()
		Try                   
			setMenuFont()
			PauseMenu.setMiddleX()
			PauseMenu.Update()			
			Select PauseMenu.CheckItemDown()
				Case 0 GameManager.GoToPausedAndKill()
				Case 1 menuStatus = 1
				Case 2 initMainMenu();pauseActive=0;GameManager.killPaused()   
				Case 3 menuStatus = 2    
				Case 4 GameManager.Newgamestate(Null,0)
			End Select
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TMenuState-updatePauseMenu")	
		End Try
	End Method			
		
		
	'hier
	Method Process()
		
		Try      
		
			'If (Not ChannelPlaying(menustartchannel)) And (Not ChannelPlaying(muckechannel)) Then
			'	playMucke(menuLoop)
			'End If
		
		
		
			If menustatus <> 7 Then
		
				'gox = GraphicsWidth()/2 - MouseX()
				'goy = GraphicsHeight()/2 - MouseY()
				'Local rotx = MouseX() + MouseY()
				gox = 0
				goy = 0
		                       
				'MidHandleImage testback
				SetBlend LIGHTBLEND
				SetColor 200, 200, 200
				SetAlpha 0.8
				'SetRotation rotx
				'DrawImage testback, 0, 0
				'TileImage testback, gox/4, goy/4
		
				SetColor 255,255,255		
				'stern.Draw(-gox/3, -goy/3)
				resetgfx()
				SetBlend lightblend
				SetAlpha 0.7#
			
				SetScale gfxOptions.getscaleFactor(),gfxOptions.getscaleFactor()
				DrawImage(background,0,0)
				SetAlpha 1
				DrawImage(schrift1,1,73*gfxOptions.getscaleFactor())

				SetScale 1,1	
		                   
				setMenuFont()
				If menustatus = 0 Then
					DrawText(AppVersion,gfxOptions.scale(30),gfxOptions.scale(720))
				End If
			End If
		
		
			If showmessage1 = 0 Then
				Select menuStatus
					Case 0 UpdateMainMenu()
					Case 1 UpdateOptionsMenu()   
					Case 2 updateGFXMenu()       
					Case 3 UpdatePauseMenu()  
					Case 4 UpdateSpielmodus()
					Case 5 UpdateLevelAuswahl()
					Case 6 UpdateSchiffAuswahl()
					Case 7 updateF1HelpMenu()
					Case 10 updatedifficultmenu()
					Case 99 updatedemomenu()
					
					'Default UpdateMainMenu()
					'case 2 GoChooseLevel()
				End Select
	
				If neuesSpiel = 1 Then 
					Cls
					Return
				End If
				'setblend maskblend
				
				'DebugStop
			
				If menustatus <> 7 Then
					resetgfx()
					SetBlend ALPHABLEND
					SetScale 0.8,0.8
					SetAlpha 0.8
					DrawImage cursor1,MouseX(),MouseY()
					SetScale 1,1
	 		
					If KeyHit(KEY_ESCAPE) Then       
						If pauseActive = 1 Then
							GameManager.gotopausedandkill()
						Else
							If menustatus <> 0 Then
								menustatus = 0
								initmainmenu()
							Else
								GameManager.NewGameState(Null,0)
							End If
						End If
			    	    Return
		    		EndIf


					'If KeyHit(KEY_M) Then
					'	GameManager.PauseAndNew(new TPlaystate)
    		  		'	GameManager.GoToPausedAndKill()
					'end if
					
				End If
		
			Else
			
				If meldungStart = 0 Then meldungStart = MilliSecs()
				If MilliSecs() > meldungStart + 3000 Then
					meldungStart = 0
					showmessage1 = 0
				End If
				resetgfx()
				setmenufont()				
				DrawText messagetext,gfxoptions.scale(230),gfxoptions.scale(400)
			
'			agw = gfxOptions.gw
'			agh = gfxOptions.gh
'			agc = gfxOptions.gc
'			aDriver = gfxOptions.treiber                           
			
			End If
		
	      Draw()
	
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TMenuState-process")	
		End Try
   End Method
     
   
   Method Leave()
   End Method
      
   
   Method Draw()
   End Method

End Type

             









