
'---------
'CHAPTER 1
'---------


Global gmChapter1:TSpielmodus = TSpielmodus.Create(GetLang("Alpha Quadrant"),"") 
	
	
	'LEVEL 1 : Training
	
	Function updateC1L1(lev:TLevel)

		Global plx:Int
		Global ply:Int
		
		If lev.stand = 0 Then
		
			'spieler blickt nach oben
			TShip(lev.gegner.sh_list.last()).mwinkel :+ 90
			
			'Local i
			'For i = 0 To Len(lev.drawtraining)-1
			'	lev.drawtraining[i] = "Das ist ein Test  123456789 123456789 123456789 123456789 123456789"			
			'Next

			'max 72 Zeichen
			'0-11 Zeilen

			lev.freedrawtraining()
			lev.drawtraining[0] = ""
			lev.drawtraining[1] = GetLang("Guten Tag, Abgesandter!")			

			lev.drawtraining[6] = GetLang("Drücke jetzt die F1-Taste, um den Hilfebildschirm aufzurufen.") 
			lev.drawtraining[7] = GetLang("Drücke wiederholt F1 oder Escape, um zum Spiel zurückzukehren.")

			lev.drawtraining[3] = GetLang("Der Hilfebildschirm kann während des Spiels jederzeit aufgerufen werden.")
			lev.drawtraining[4] = GetLang("Nutze ihn, um Dich über Tastaturbelegung und Spielelemente zu informieren.")
			
			'lev.drawtraining[8] = "Drücke jetzt die F1-Taste
			
			lev.drawtraining[11] = ""
			
			lev.stand = 1																		
		End If
		
		
		'trigger1
		If lev.stand = 1 Then
			plx = 1000
			ply = 1700
			TShip(lev.gegner.sh_list.last()).speed = 0
			TShip(lev.gegner.sh_list.last()).mwinkel = 90
		
			TShip(lev.gegner.sh_list.last()).x = 1000
			TShip(lev.gegner.sh_list.last()).y = 1700
			
			'If KeyHit(KEY_F1) Then lev.stand = 2	
			If lev.f1away = 1 Then lev.stand = 2
		End If
				
		
		If lev.stand = 2 Then
			 lev.freedrawtraining()
			 'lev.drawtraining[0] = "Du kannst das Spiel pausieren, indem Du die Taste Escape drückst."
			 'lev.drawtraining[1] = "Wenn Du erneut Escape drückst, kehrst Du wieder zum Spiel zurück."
			 lev.drawtraining[2] = ""
			 lev.drawtraining[0] = GetLang("Der blaue rotierende Schild, links unten, zeigt Deine Schildenergie.")
			 lev.drawtraining[1] = GetLang("Fällt Deine Schildenergie unter 0, explodiert Dein Raumschiff.")
			 lev.drawtraining[2] = ""
			 lev.drawtraining[3] = GetLang("Unten in der Mitte befindet sich die Munitionsanzeige für Deine")
			 lev.drawtraining[4] = GetLang("aktuelle Waffe. Am Anfang besitzt Du nur den Standard-Laser mit")
			 lev.drawtraining[5] = GetLang("unendlich viel Munition, was Du am Gedankenstrich erkennen kannst.")
			 lev.drawtraining[6] = ""
 			 lev.drawtraining[7] = GetLang("Drücke die Enter-Taste, um fortzufahren.")
			lev.drawtraining[11] = ""

			lev.stand = 30
		End If
				
		
		If lev.stand = 30 Then
			TShip(lev.gegner.sh_list.last()).x = plx
			TShip(lev.gegner.sh_list.last()).y = ply
		
			TShip(lev.gegner.sh_list.last()).mwinkel = 90

			If KeyHit(KEY_ENTER)
				lev.stand = 3
			End If
		End If	
			
		
		If lev.stand = 3 Then
			 lev.freedrawtraining()

			 lev.drawtraining[0] = ""
			 lev.drawtraining[1] = ""
			 lev.drawtraining[0] = GetLang("Probiere als nächstes Deine Standardwaffe aus:")
			 lev.drawtraining[1] = GetLang("Drücke dazu die Schuss-Taste (Leertaste)")
			 lev.drawtraining[2] = ""
			 lev.drawtraining[3] = GetLang("Um andere Waffen und Items zu erhalten, musst Du mit Deinem")
			 lev.drawtraining[4] = GetLang("Raumschiff über die Items fliegen.")
			 lev.drawtraining[5] = ""
			 lev.drawtraining[6] = GetLang("Drücke jetzt solange auf die Vorwärtsfliegen-Taste bis")
			 lev.drawtraining[7] = GetLang("sich Dein Raumschiff über dem nächsten Item befindet.")
			 lev.drawtraining[10] = ""
			 lev.drawtraining[11] = ""
			lev.stand = 31
		End If


		If lev.stand = 31 Then
			TShip(lev.gegner.sh_list.last()).mwinkel = 90
				
			If TShip(lev.gegner.sh_list.last()).waffenarsenal[2] = 1 Then
				plx = TShip(lev.gegner.sh_list.last()).x
				ply = TShip(lev.gegner.sh_list.last()).y

				lev.stand = 4
			End If
		End If

				
		If lev.stand = 4 Then
									
			 lev.freedrawtraining() 
			 lev.drawtraining[0] = GetLang("Wenn Du über ein Waffen-Item fliegst, wird die neue Waffe")
			 lev.drawtraining[1] = GetLang("automatisch als Deine aktuelle Waffe gesetzt.")
			 
			 lev.drawtraining[3] = GetLang("Mit der Taste c oder den Tasten 1-9, kannst Du zwischen")
			 lev.drawtraining[4] = GetLang("deinen Waffen wechseln.")
			 
			 lev.drawtraining[6] = ""
			 lev.drawtraining[7] = ""
			 lev.drawtraining[8] = ""
			 lev.drawtraining[9] = ""
			 lev.drawtraining[10] = ""
			 lev.drawtraining[6] = GetLang("Drücke die Enter-Taste, um fortzufahren.")

			lev.stand = 32
									
		End If


		If lev.stand = 32 Then
			TShip(lev.gegner.sh_list.last()).x = plx
			TShip(lev.gegner.sh_list.last()).y = ply

			TShip(lev.gegner.sh_list.last()).mwinkel = 90
			TShip(lev.gegner.sh_list.last()).speed = 0
		
			If KeyHit(KEY_ENTER) Then
				lev.stand = 5
			End If
		End If


		
		If lev.stand = 5 Then
			 lev.freedrawtraining()
			 lev.drawtraining[0] = ""
			 lev.drawtraining[1] = ""
			 lev.drawtraining[2] = ""
			 lev.drawtraining[2] = GetLang("Um einen Überblick über die im Level vorhandenen Gegner zu")
			 lev.drawtraining[3] = GetLang("bekommen, kannst Du Dir das Radar-Item holen:")
			 lev.drawtraining[5] = ""
			 lev.drawtraining[5] = GetLang("Drücke solange die Vorwärtsfliegen-Taste bis Du das Radar-Item")
			 lev.drawtraining[6] = GetLang("aufgenommen hast.")
			 lev.drawtraining[8] = ""
			 lev.drawtraining[9] = ""
			 lev.drawtraining[10] = ""
			 lev.drawtraining[11] = ""
			lev.stand = 33
		End If
		
		
		If lev.stand = 33 Then
			TShip(lev.gegner.sh_list.last()).mwinkel = 90

			If lev.showradar = 1
				plx = TShip(lev.gegner.sh_list.last()).x
				ply = TShip(lev.gegner.sh_list.last()).y
			
				lev.stand = 6
			End If			
		End If
		
		
		
		If lev.stand = 6 Then
	
			 lev.freedrawtraining() 
			 lev.drawtraining[0] = ""
			 lev.drawtraining[1] = ""
			 lev.drawtraining[2] = ""
			 lev.drawtraining[2] = GetLang("Jetzt siehst Du links oben eine Miniaturausführung der Arena.")
			 lev.drawtraining[3] = GetLang("Der weisse Punkt bist Du und feindliche Raumschiffe werden mit")
			 lev.drawtraining[4] = GetLang("roten Punkten gekennzeichnet.")
			 lev.drawtraining[6] = ""
			 lev.drawtraining[6] = GetLang("Drücke die Enter-Taste, um fortzufahren.")
			 lev.drawtraining[8] = ""
			 lev.drawtraining[9] = ""
			 lev.drawtraining[10] = ""
			 lev.drawtraining[11] = ""
				
			lev.stand = 34
		End If



		If lev.stand = 34 Then
			TShip(lev.gegner.sh_list.last()).x = plx
			TShip(lev.gegner.sh_list.last()).y = ply

			TShip(lev.gegner.sh_list.last()).speed = 0
			TShip(lev.gegner.sh_list.last()).mwinkel = 90

			If KeyHit(KEY_ENTER) Then
				lev.stand = 7
			End If
		End If
		
		
		
		If lev.stand = 7 Then
			 lev.freedrawtraining()

			 lev.drawtraining[0] = ""
			 lev.drawtraining[1] = ""
			 lev.drawtraining[2] = ""
			 lev.drawtraining[3] = ""
			 lev.drawtraining[2] = GetLang("Turbo-Booster")
			 lev.drawtraining[5] = ""
			 lev.drawtraining[4] = GetLang("Drücke die Vorwärtsfliegen-Taste, bis sich Dein Raumschiff")
			 lev.drawtraining[5] = GetLang("über dem Booster-Item befindet.")
			 lev.drawtraining[8] = ""
			 lev.drawtraining[9] = ""
			 lev.drawtraining[10] = ""
			 lev.drawtraining[11] = ""
			lev.stand = 35
		End If
		
		
		
		If lev.stand = 35 Then
			TShip(lev.gegner.sh_list.last()).mwinkel = 90
					
			If TShip(lev.gegner.sh_list.last()).boosterenergie > 0 Then
				plx = TShip(lev.gegner.sh_list.last()).x
				ply = TShip(lev.gegner.sh_list.last()).y
				
				lev.stand = 8
			End If
		End If
			
																				
																																																						
		
		If lev.stand = 8 Then
			 lev.freedrawtraining() 
			 lev.drawtraining[0] = ""
			 lev.drawtraining[1] = ""
			 lev.drawtraining[2] = ""
			 lev.drawtraining[2] = GetLang("Mit Hilfe des Boosters kann Dein Raumschiff deutlich schneller")
			 lev.drawtraining[3] = GetLang("fliegen. Drücke dazu die Vorwärtsfliegen-Taste und gleichzeitig")
			 lev.drawtraining[4] = GetLang("die Booster-Taste (linke ALT-Taste neben der Leertaste).")
			 lev.drawtraining[6] = ""
			 lev.drawtraining[6] = GetLang("Drücke die Enter-Taste, um fortzufahren.")
			 lev.drawtraining[8] = ""
			 lev.drawtraining[9] = ""
			 lev.drawtraining[10] = ""
			 lev.drawtraining[11] = ""
			
			lev.stand = 36
		End If
		
		
		If lev.stand = 36 Then		
			If KeyHit(KEY_ENTER) Then
				TShip(lev.gegner.sh_list.last()).speed = 0
				TShip(lev.gegner.sh_list.last()).mwinkel = 90
				TShip(lev.gegner.sh_list.last()).x = 1000
				TShip(lev.gegner.sh_list.last()).y = 1700
				lev.stand = 9
			End If
		End If
		
		
		If lev.stand = 9 Then
			lev.Items.AddBonusItem(TBonusItem.Create(1000,1500,15000,6,"images/MineLevel.png"))
			lev.stand = 10
		End If	
				
		
		If lev.stand = 10 Then
			 lev.freedrawtraining() 
		
			 lev.drawtraining[0] = GetLang("Hole Dir das Minen-Item vor Deinem Raumschiff. Drücke die Schusstaste")
			 lev.drawtraining[1] = GetLang("um Minen abzulegen. Blaue Minen sind für Dein Raumschiff ungefährlich")
			 lev.drawtraining[2] = GetLang("und verletzen nur feindliche Raumschiffe, rote Minen können Dein Raumschiff")
			 lev.drawtraining[3] = GetLang("dagegen beschädigen.")

			 lev.drawtraining[5] = GetLang("Drücke die Enter-Taste, um Deine neuen Fähigkeiten praktisch")
			 lev.drawtraining[6] = GetLang("einzusetzen: Steuere die roten Punkte auf dem Radar an und zerstöre")
			 lev.drawtraining[7] = GetLang("die feindlichen Raumschiffe.")

			lev.stand = 37

		End If
				
				
		If lev.stand = 37 Then	
			If KeyHit(KEY_ENTER) Then
				lev.drawtrainingB = 0
				lev.freedrawtraining()
				lev.stand = 11
			End If
		End If				
		
		
		If lev.stand = 11 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			
			For sh:TShip = EachIn lev.Gegner.sh_list
				sh.spawn
			Next                            

			lev.stand = 12
		End If

		
		
		If lev.stand = 12 Then          
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle < 2 Then
				TShip(lev.gegner.sh_list.Last()).LevelEnde(1)
				Return
			End If
		End If
	End Function	

		

	Function initC1L1(lev:TLevel)
		FlushKeys()
	
		lev.drawtrainingb = 1	
		
		lev.playerx = 1000
		lev.playery = 1700
		
		If gdifficulty = 0 Then				
	    	lev.gegner.addShip(Tship.Create("UFO2", 350, 300, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneT.lua"))
    		lev.gegner.addShip(Tship.Create("UFO2", 1000, 300, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneT.lua"))
  			lev.gegner.addShip(Tship.Create("UFO2", 1700, 300, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneT.lua"))
		Else If gdifficulty = 1 Then
	    	lev.gegner.addShip(Tship.Create("UFO2", 350, 300, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneT1.lua"))
    		lev.gegner.addShip(Tship.Create("UFO2", 1000, 300, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneT1.lua"))
  			lev.gegner.addShip(Tship.Create("UFO2", 1700, 300, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneT1.lua"))
			lev.gegner.addShip(Tship.Create("UFO2", 1500, 300, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneT1.lua"))
		Else If gdifficulty = 2 Then
	    	lev.gegner.addShip(Tship.Create("UFO2", 350, 300, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneT2.lua"))
    		lev.gegner.addShip(Tship.Create("UFO2", 1000, 300, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneT2.lua"))
  			lev.gegner.addShip(Tship.Create("UFO2", 1700, 300, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneT2.lua"))
  			lev.gegner.addShip(Tship.Create("UFO2", 1400, 600, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneT2.lua"))
  			lev.gegner.addShip(Tship.Create("UFO2", 1200, 800, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneT2.lua"))
		End If

	   'Bonusitems adden
		  'Flammenwerfer
			'lev.Items.AddBonusItem(TBonusItem.Create(500,500,15000,5,"images/flamerLevel.png"))
		  'PowerLaser
			lev.Items.AddBonusItem(TBonusItem.Create(1000,1500,15000,2,"images/powerlaserLevel.png"))

  		  'Radar
			lev.Items.AddBonusItem(TBonusItem.Create(1000,1200,8000,20,"images/radar.png"))

		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(1000,900,15000,21,"images/booster_final.png"))
             
    End Function
   
	gmChapter1.AddLevel(TLevel.Create(1,GetLang("Level 1: Pilotentraining"),GetLang("Werde ein Pilot"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L1,initC1L1))
      

           





		
	'LEVEL 2 : Kampfdrohnen 1
	
	Function updateC1L2(lev:TLevel)
		Local i:Int
		
		'woher weiß ich ob level verloren wurde?
		'- wenn spieler tot ist
			'letztes ship in sh prüfen
					
		'- wenn zeit abgelaufen ist
		
		'- wenn gegner mehr Frags hat
		
		'- wenn anderer als erster im Ziel ist
		
		'- wenn zu beschützende basis zerstört wurde
	
		               
		'lev.stand = 4
	
		If lev.stand = 0 Then
					
			lev.freedrawtraining()
			lev.drawtraining[0] = ""

			lev.drawtraining[1] = GetLang("Tipps für Deinen ersten Kampfdrohnen-Einsatz:")
			
			lev.drawtraining[3] = GetLang("- Drücke die Taste F1, um die Tastaturbelegung zu erfahren")
			lev.drawtraining[4] = GetLang("- Finde die Schwächen der Drohnen und nutze sie")
			lev.drawtraining[5] = GetLang("- Sammle das Radar ein und verschaffe Dir einen Überblick")
			
			lev.drawtraining[7] = GetLang("Drücke die Enter-Taste, um die Tipps auszublenden")
			
			If KeyHit(KEY_ENTER) Then
				lev.stand = 99
				lev.freedrawtraining()
				aktuellerLevel.drawtrainingB = 0				
			End If
			
		End If
		
		
		
		If lev.stand = 99 Then
			'lev.setpath(TPosition.create(4,5),TPosition.create(5,5))
			lev.setpath(TPosition.create(4,5),TPosition.create(6,8))
		
			Local sh:TShip
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				sh.spawn			
				Count1 = Count1 + 1
				If Count1 = 1 Then Exit
			Next
			lev.stand = 1               
		End If
		
		If lev.stand = 1 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
			Next                            
			
			If alle < 2 Then
				Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn
					Count1 = Count1 + 1
					If Count1 = 3 Then Exit
				Next                            
				lev.stand = 2
			End If
		End If
                        

		If lev.stand = 2 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle < 2 Then
				Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn
					Count1 = Count1 + 1
					If Count1 = 5 Then Exit
				Next                            
				lev.stand = 4
			End If
		End If

		Rem
		If lev.stand = 3 Then
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle < 2 Then
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn			
				Next                            
				lev.stand = 4
			End If
		End If   
		End Rem
		If lev.stand = 4 Then          
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle < 2 Then
				levelrekord.setrekord(TShip(lev.gegner.sh_list.Last()).ausgeteilterSchaden - TShip(lev.gegner.sh_list.Last()).eingesteckterSchaden, lev.id, 1)				
				TShip(lev.gegner.sh_list.Last()).LevelEnde(1)
				Return
			End If
		End If
		
		If levelschluss = 0  Then
			If TShip(lev.gegner.sh_list.Last()).dead=1 Then          
				'levelrekord.setrekord(TShip(lev.gegner.sh_list.Last()).ausgeteilterSchaden - TShip(lev.gegner.sh_list.Last()).eingesteckterSchaden, lev.id, 1)				
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If
		End If
		
	End Function
	
	
	Function initC1L2(lev:TLevel)
		FlushKeys()
	
		lev.drawtrainingb = 1	

				
	'Gegner adden    									create:TShip(pname$,posx#,posy#,pteam,pai,pschiff:TGleiter)
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
		    	
		lev.playerx = 200
		lev.playery = 200


	  'Bonusitems adden
		  'Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,500,8000,5,"images/flamerLevel.png"))
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,450,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(300,200,15000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,300,8000,12,"images/powerlaser_muni.png"))

		  'Life Bonus 
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,200,8000,22,"images/lifebonus1.png"))
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(550,200,8000,22,"images/lifebonus1.png"))

		  'Radar
			lev.Items.AddBonusItem(TBonusItem.Create(400,200,8000,20,"images/radar.png"))
		                                      
		  'Red Shield
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,200,8000,31,"images/schildi2.png"))
	
	End Function 
			
	gmChapter1.AddLevel(TLevel.Create(2,"Level 2: " + getlang("Kampfdrohnen") + " 1",getlang("Vernichte alle Kampfdrohnen"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L2,initc1l2))
    






	



	'LEVEL 3 : Labyrinth 1
	
	Function updateC1L3(lev:TLevel)

		If lev.stand = 0 Then
					
			lev.freedrawtraining()
			lev.drawtraining[0] = ""
			lev.drawtraining[3] = GetLang("Tipps für Dein erstes Labyrinth:")		
			lev.drawtraining[4] = GetLang("- Sammle alle roten Signalitems ein, bevor der Countdown abläuft")
			lev.drawtraining[5] = GetLang("- Informiere Dich am oberen Bildschirmrand über Deinen Status")
			lev.drawtraining[6] = GetLang("- Hole und benutze den Turbo-Booster (ALT-Taste)")

			lev.drawtraining[8] = GetLang("Drücke die Enter-Taste, um die Tipps auszublenden")
			
			If KeyHit(KEY_ENTER) Then 
				lev.stand = 99
				lev.freedrawtraining()
				aktuellerLevel.drawtrainingB = 0				
			End If
		End If
				
						
		'Pausenmenü-Aufenthalt in Zeit einrechnen
		If (MilliSecs() > lastcall + 1000) And (lastcall <> 0) Then
			lev.startzeit = lev.startzeit + MilliSecs() - lastcall
		End If
		lastcall = MilliSecs()						


		Local minuten:Int
		Local sekunden:Int
		Local seks:String
		Local z:Int = (MilliSecs()-lev.startzeit)/1000
		
		If gdifficulty = 0 Then
			z = 90-z
		Else If gdifficulty = 1 Then
			z = 80-z
		Else If gdifficulty = 2 Then
			z = 70-z
		End If
		
		minuten = z/60
		sekunden = z Mod 60
		If sekunden < 10 Then seks = "0" + sekunden Else seks = sekunden
	
		
		'Die letzten 10 Sekunden ding,ding,.... und rote Schrift
		If z < 10 Then 
			playeffect(sDing)
			lev.DrawRed=1
		End If
		
		lev.DrawLevel = "0"+minuten+":"+seks
		'DrawSuper("0"+minuten+":"+seks ,400,50)
		
					
		Local anzahlAlle:Int=0
		Local anzahlUebrig:Int=0
				
		'Hat Spieler gewonnen?
		Local bi:TBonusitem		
		Local gewonnen:Int=1
		For bi:TBonusItem = EachIn lev.items.bonusitems
			If bi.itemart = 80 Then
				AnzahlAlle:+1
				If bi.show = 1 Then
					AnzahlUebrig:+1
					gewonnen = 0
				End If
			End If				
		Next
		If gewonnen=1 Then 			
			levelrekord.setrekord(z, lev.id, 3)
		
			TShip(lev.gegner.sh_list.Last()).LevelEnde(1)
			Return
		End If	

		
		If levelschluss = 0  Then
						
			anzahlUebrig = AnzahlAlle - AnzahlUebrig
			lev.DrawLevel = lev.DrawLevel + "    " + anzahlUebrig + "/" + AnzahlAlle
			lev.drawLevelX = 390
			lev.drawlevelY = 50

				
			'Hat Spieler verloren?
			If z < 1 Then
'				levelrekord.setrekord(z, lev.id, 3)
			
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If	
		End If
		
		If levelschluss = 0 Then		
			If TShip(lev.gegner.sh_list.Last()).dead=1 Then  
'				levelrekord.setrekord(z, lev.id, 3)
		        
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If
		End If
		
	End Function
	
	
	Function initC1L3(lev:TLevel)
		FlushKeys()
	
		lev.drawtrainingb = 1	

		lev.playerx = 200
		lev.playery = 150


	'Bonusitems adden
		'Collection Items		
		  lev.Items.AddBonusItem(TBonusItem.Create(600,145,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(700,145,-1,80,"images/colItem1.png"))
 		  lev.Items.AddBonusItem(TBonusItem.Create(800,145,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(900,145,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1000,145,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1100,145,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1200,145,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1300,145,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1400,145,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1500,145,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1600,145,-1,80,"images/colItem1.png"))

		  lev.Items.AddBonusItem(TBonusItem.Create(1756 ,351 ,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1401 ,548 ,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1186 ,547 ,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1694 ,935 ,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1311 ,1092 ,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1525 ,1089 ,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1771 ,1729 ,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1673 ,1728 ,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1572 ,1728 ,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(197 ,1134 ,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(198 ,916 ,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(392 ,541 ,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(392 ,340 ,-1,80,"images/colItem1.png"))

		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(500,150,8000,21, "images/booster_final.png"))

	End Function	
	
	
	gmChapter1.AddLevel(TLevel.Create(3,"Level 3: " +getlang("Labyrinth") +  " 1",getlang("Finde alle roten Signalgeber"),"Levels/Q1/orientierung1.map",updateC1L3,initc1l3))
    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("UFO2", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(3)),1))




    

   
	'LEVEL 4 : Sicherung 1
	
	Function updateC1L4(lev:TLevel)
	
		If lev.stand = 0 Then
			'FlushKeys()
			lev.stand = 98
		End If
	
	
		If lev.stand = 98 Then
			lev.freedrawtraining()
			lev.drawtraining[0] = ""
			lev.drawtraining[1] = ""		

			lev.drawtraining[3] = "" 
			lev.drawtraining[2] = GetLang("Tipps für Deinen ersten Sicherungs-Level:")
			lev.drawtraining[6] = GetLang("- Nutze die Taste c, um zwischen deinen Waffen zu wechseln")
			lev.drawtraining[4] = GetLang("- Sammle Minen-Items und lege Minenfelder an")
			lev.drawtraining[5] = GetLang("- Am oberen Bildschirmrand wird die Schildenergie der Raumstation angezeigt")
			lev.drawtraining[3] = GetLang("- Sammle Geschützturm-Items und platziere sie mit der Taste v")
						
			lev.drawtraining[8] = GetLang("Drücke die Enter-Taste, um die Tipps auszublenden")
			
			If KeyHit(KEY_ENTER) Then 
				lev.stand = -2
				lev.freedrawtraining()
				aktuellerLevel.drawtrainingB = 0
			End If
		End If
	
	
		'Pausenmenü-Aufenthalt in Zeit einrechnen
		If (MilliSecs() > lastcall + 1000) And (lastcall <> 0) Then
			lev.startzeit = lev.startzeit + MilliSecs() - lastcall
		End If
		lastcall = MilliSecs()						
	
		Local minuten:Int
		Local sekunden:Int
		Local seks:String
		Local z:Int = (MilliSecs()-lev.startzeit)/1000
		If (z > 30) And (lev.stand = -2) Then 
			lev.stand = -1
			aktuellerLevel.drawtrainingB = 0
		End If
	
		
		Local i:Int
		'lev.stand = 4
		If lev.stand = -1 Then
			Local sh:TShip
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.autospawn = 0 And sh.ai <> 98 Then
					sh.spawn		
					Count1 = Count1 + 1
				End If
				If Count1 = 3 Then Exit
			Next
			lev.stand = 1
		End If
		
		
		If lev.stand = 1 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 And sh.autospawn = 0 And sh.ai <> 98 Then alle = alle + 1
			Next                            
			
			If alle = 0 Then 
				Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					If sh.autospawn = 0 And sh.ai <> 98 Then
						sh.spawn
						Count1 = Count1 + 1
					End If
					If Count1 = 6 Then Exit
				Next                            
				lev.stand = 2
			End If
		End If
                        

		If lev.stand = 2 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0  And sh.autospawn = 0 And sh.ai <> 98 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle = 0 Then
				Count1 = 0
				
				If gdifficulty = 1 Then
					For sh:TShip = EachIn lev.Gegner.sh_list
						If sh.autospawn = 0 And sh.ai <> 98 And sh.ai <> 98 Then
							sh.spawn
							Count1 = Count1 + 1
						End If
						If Count1 = 10 Then Exit
					Next                            
				End If
				
				lev.stand = 3
			End If
		End If

		
		If lev.stand = 3 Then
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 And sh.autospawn = 0 And sh.ai <> 98 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle = 0 Then
				If gdifficulty = 2 Then
					For sh:TShip = EachIn lev.Gegner.sh_list
						If sh.autospawn = 0 And sh.ai <> 98 Then
							sh.spawn			
						End If
					Next                            
				End If
				lev.stand = 4
			End If
		End If   
		
		If lev.stand = 4 Then          
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 And sh.autospawn = 0 And sh.ai <> 98 Then alle = alle + 1
				'sh.spawn			
			Next                            

			'Spieler gewonnen?
			If alle = 0 Then
				levelrekord.setrekord(TShip(lev.gegner.sh_list.first()).life, lev.id, 2)
				TShip(lev.gegner.sh_list.Last()).LevelEnde(1)
				Return
			End If
		End If
		
		
		If levelschluss = 0  Then
		
			'Spieler verloren?
			If (TShip(lev.gegner.sh_list.Last()).dead=1) Or (TShip(lev.gegner.sh_list.first()).dead=1) Then          
'				levelrekord.setrekord(TShip(lev.gegner.sh_list.first()).life, lev.id,2)
			
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If
		End If
		
	End Function


	Function initC1L4(lev:TLevel)
		FlushKeys()
		lev.drawtrainingb = 1	

	    'Gegner adden
		'											Function create:TShip(pname$,posx#,posy#,pteam,pai,pschiff:TGleiter, autoSpawn:Int)

    	'Raumstation mit Team 0, AI = 99
		lev.gegner.addShip(Tship.Create("Station1", 1000, 1000, 0, 99, gleitersammlung.getgleiterbyid(8),1))

		lev.playerx = 900
		lev.playery = 1000

		'Angreifende Kampfdrohnen
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(6),0))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(6),0))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(6),0))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(6),0))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(6),0))

		  'Bonusitems adden
	
		  'Minen
		  lev.Items.AddBonusItem(TBonusItem.Create(650,920,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1000,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1080,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,920,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1000,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1080,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,920,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1000,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1080,-1,6,"images/MineLevel.png"))
		
		
		  'lev.Items.AddBonusItem(TBonusItem.Create(650,1160,8000,6,"images/MineLevel.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(650,1240,8000,6,"images/MineLevel.png"))

		  'Towers
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1160,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1240,8000,81,"images/t1Level.png",aktuellerLevel))

		
		'lev.Items.AddBonusItem(TBonusItem.Create(550,700,8000,82,"images/t2Level.png",aktuellerLevel))
	
	
		  'Triple Laser
		  lev.Items.AddBonusItem(TBonusItem.Create(800,1300,8000,3,"images/tripleLevel.png"))
         
		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(1100,800,8000,20,"images/radar.png"))
		                             
		  'Red Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(800,800,8000,31,"images/schildi2.png"))
	
		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(1500,1500,8000,21, "images/booster_final.png"))

	
	
	End Function


	gmChapter1.AddLevel(TLevel.Create(4,"Level 4: "+ getlang("Sicherung") +  " 1",getlang("Verteidige die Raumstation gegen alle Angreifer"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L4,initC1L4))









	'LEVEL 5 : Zweikampf 1

	Function updateC1L5(lev:TLevel)
		
		'TShip(lev.gegner.sh_list.first()).deathmatchfrags

		If KeyHit(key_l) Then
			TShip(lev.gegner.sh_list.Last()).LevelEnde(1) 'verloren
			Return
		End If
						
		
		If lev.stand = 0 Then
					
			lev.freedrawtraining()
			
			lev.drawtraining[0] = ""
			lev.drawtraining[1] = ""		

			lev.drawtraining[3] = GetLang("Tipps für Deinen ersten Zweikampf:")
			lev.drawtraining[4] = GetLang("- Lege Minen an taktisch geschickten Stellen")
			lev.drawtraining[5] = GetLang("- Repariere Dein Raumschiff mit Schildenergie-Boni")
			lev.drawtraining[6] = GetLang("- Wenn Du rückwärts fliegst, vergrößert sich Deine Schuss-Reichweite")
			lev.drawtraining[7] = GetLang("- Der Turbo-Booster kann im Nahkampf sehr nützlich sein")

			lev.drawtraining[8] = GetLang("Drücke die Enter-Taste, um die Tipps auszublenden")
			
			If KeyDown(KEY_ENTER) Then 
				lev.stand = 99
				lev.freedrawtraining()
				aktuellerLevel.drawtrainingB = 0				
			End If
		End If

		lev.DrawLevel = TShip(lev.gegner.sh_list.Last()).name  + "  " + TShip(lev.gegner.sh_list.last()).deathmatchfrags + " : " + TShip(lev.gegner.sh_list.first()).deathmatchfrags + "  " + TShip(lev.gegner.sh_list.first()).name
		lev.drawLevelX = -1
		lev.drawlevelY = 50		
		
						
		If TShip(lev.gegner.sh_list.last()).deathmatchfrags >= 5 Then
			levelrekord.setrekord(TShip(lev.gegner.sh_list.last()).deathmatchfrags - TShip(lev.gegner.sh_list.first()).deathmatchfrags, lev.id, 4)
			TShip(lev.gegner.sh_list.Last()).LevelEnde(1) 'gewonnen
			Return
		End If

		If levelschluss = 0  Then
			If TShip(lev.gegner.sh_list.first()).deathmatchfrags >= 5 Then
'				levelrekord.setrekord(TShip(lev.gegner.sh_list.last()).deathmatchfrags - TShip(lev.gegner.sh_list.first()).deathmatchfrags, lev.id, 4)
			
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0) 'verloren
				Return
			End If
		End If

	End Function
	


	Function initC1L5(lev:TLevel)
		FlushKeys()
	
		lev.drawtrainingb = 1	

    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("Gegner", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(0)),1,"KI/Ausscheidungskampf1.lua"))
		'lev.gegner.addShip(Tship.Create(getlang("Gegner"), 240, 1638, 2,1, gleitersammlung.getgleiterbyid(2),1,"KI/Ausscheidungskampf1.lua"))
		
		If splitscreen = 0 Then
			lev.gegner.addShip(Tship.Create(getlang("Gegner"), 240, 1700, 2,1, gleitersammlung.getgleiterbyid(2),1,"KI/Ausscheidungskampf1.lua"))
		End If
				
'/images/start.png,0,0,0,0,1,1,1,1,1,255,255,255,0,428,243,0
'/images/start.png,0,0,0,0,1,1,1,1,1,255,255,255,0,287,240,0

'/images/start.png,0,0,0,0,1,1,1,1,1,255,255,255,0,1682,209,0
'/images/start.png,0,0,0,0,1,1,1,1,1,255,255,255,0,1683,338,0

'/images/start.png,0,0,0,0,1,1,1,1,1,255,255,255,0,302,1637,0
'/images/start.png,0,0,0,0,1,1,1,1,1,255,255,255,0,421,1638,0

'/images/start.png,0,0,0,0,1,1,1,1,1,255,255,255,0,1297,1331,0
'/images/start.png,0,0,0,0,1,1,1,1,1,255,255,255,0,1298,1438,0		
		
		
		  'Flammenwerfer
		  'lev.Items.AddBonusItem(TBonusItem.Create(1297,1331,8000,5,"images/flamerLevel.png"))
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(1298,1438,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  lev.Items.AddBonusItem(TBonusItem.Create(1297,1331,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(421,1638,8000,12,"images/powerlaser_muni.png"))

		  'Minen
		  lev.Items.AddBonusItem(TBonusItem.Create(1683,338,8000,6,"images/MineLevel.png"))
		                                      
		  'Yellow Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(1682,209,8000,31,"images/schildi2.png"))
	
		  'Life Bonus 
		  lev.Items.AddBonusItem(TBonusItem.Create(302,1637,8000,22,"images/lifebonus1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(402,1637,8000,22,"images/lifebonus1.png"))


		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(428,243,8000,21,"images/booster_final.png"))

      End Function         
	
	
	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(5,"Level 5: " + getlang("Zweikampf") + " 1",getlang("Erziele als erstes 5 Abschüsse"),"Levels/Q1/Ausscheidung1.map",updateC1L5,initC1L5))














	'LEVEL 6 : Kampfdrohnen 2

	Function updateC1L6(lev:TLevel)
		Local i:Int
		'lev.stand = 4
		If lev.stand = 0 Then
			Local sh:TShip
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				sh.spawn			
				Count1 = Count1 + 1
				If Count1 = 1 Then Exit
			Next
			lev.stand = 1               
		End If
		
		If lev.stand = 1 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
			Next                            
			
			If alle < 2 Then
				Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn
					Count1 = Count1 + 1
					If Count1 = 2 Then Exit
				Next                            
				lev.stand = 2
			End If
		End If
                        

		If lev.stand = 2 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle < 2 Then
				Local Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn
					Count1 = Count1 + 1
					If Count1 = 3 Then Exit
				Next                            
				lev.stand = 3
			End If
		End If

		
		If lev.stand = 3 Then
			Local sh:TShip
			Local count1:Int = 0
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle < 2 Then
				count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn	
					count1 = count1 + 1
					If count1 = 4 Then Exit
				Next                            
				lev.stand = 4
			End If
		End If   
		
		If lev.stand = 4 Then          
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            

			If alle < 2 Then
				levelrekord.setrekord(TShip(lev.gegner.sh_list.Last()).ausgeteilterSchaden - TShip(lev.gegner.sh_list.Last()).eingesteckterSchaden, lev.id, 1)
				TShip(lev.gegner.sh_list.Last()).LevelEnde(1)
				Return
			End If
		End If
		
		If levelschluss = 0  Then
			If TShip(lev.gegner.sh_list.Last()).dead=1 Then
'				levelrekord.setrekord(TShip(lev.gegner.sh_list.Last()).ausgeteilterSchaden - TShip(lev.gegner.sh_list.Last()).eingesteckterSchaden, lev.id, 1)				
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If
		End If
	End Function



	Function initC1L6(lev:TLevel)
	 'Gegner adden
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	'lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	'lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	
	  'Bonusitems adden
		  'PowerLaser
		  'lev.Items.AddBonusItem(TBonusItem.Create(500,350,8000,2,"images/powerlaserLevel.png"))
		  
		  'Triple Laser
		  lev.Items.AddBonusItem(TBonusItem.Create(800,500,8000,3,"images/tripleLevel.png"))
		                                      
		  'Y-Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(500,200,8000,31,"images/schildi2.png"))
	
		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(500,600,8000,21,"images/booster_final.png"))

		  'Life Bonus 
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,200,8000,22,"images/lifebonus1.png"))
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(550,200,8000,22,"images/lifebonus1.png"))

		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(400,200,8000,20,"images/radar.png"))
	End Function

	gmChapter1.AddLevel(TLevel.Create(6,"Level 6: " + getlang("Kampfdrohnen") + " 2",getlang("Power Drohnen"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L6,initc1l6))
   











	'LEVEL 7 : Labyrinth 2
	
	Function updateC1L7(lev:TLevel)
		'Pausenmenü-Aufenthalt in Zeit einrechnen
		If (MilliSecs() > lastcall + 1000) And (lastcall <> 0) Then
			lev.startzeit = lev.startzeit + MilliSecs() - lastcall
		End If
		lastcall = MilliSecs()						


		Local minuten:Int
		Local sekunden:Int
		Local seks:String
		Local z:Int = (MilliSecs()-lev.startzeit)/1000
		
		If gdifficulty = 0 Then
			z = 75-z		
		Else If gdifficulty = 1 Then
			z = 65-z		
		Else If gdifficulty = 2 Then
			z = 55-z		
		End If
		
		
		minuten = z/60
		sekunden = z Mod 60
		If sekunden < 10 Then seks = "0" + sekunden Else seks = sekunden
	
		
		'Die letzten 10 Sekunden ding,ding,.... und rote Schrift
		If z < 10 Then 
			playeffect(sDing)
			lev.DrawRed=1
		End If
		
		lev.DrawLevel = "0"+minuten+":"+seks
		'DrawSuper("0"+minuten+":"+seks ,400,50)
		
					
		Local anzahlAlle:Int=0
		Local anzahlUebrig:Int=0
				
		'Hat Spieler gewonnen?
		Local bi:TBonusitem		
		Local gewonnen:Int=1
		For bi:TBonusItem = EachIn lev.items.bonusitems
			If bi.itemart = 80 Then
				AnzahlAlle:+1
				If bi.show = 1 Then
					AnzahlUebrig:+1
					gewonnen = 0
				End If
			End If				
		Next
		If gewonnen=1 Then 			
				levelrekord.setrekord(z, lev.id, 3)
		
			TShip(lev.gegner.sh_list.Last()).LevelEnde(1)
			Return
		End If	

		
		If levelschluss = 0  Then
						
			anzahlUebrig = AnzahlAlle - AnzahlUebrig
			lev.DrawLevel = lev.DrawLevel + "    " + anzahlUebrig + "/" + AnzahlAlle
			lev.drawLevelX = 390
			lev.drawlevelY = 50
						
						
			'Hat Spieler verloren?
			If z < 1 Then
'				levelrekord.setrekord(z, lev.id, 3)
			
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If	
		End If

		
		If levelschluss = 0 Then		
			If TShip(lev.gegner.sh_list.Last()).dead=1 Then   
'				levelrekord.setrekord(z, lev.id, 3)
			       
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If
		End If
								
	End Function
	
	
	Function initC1L7(lev:TLevel)

		lev.playerx = 200
		lev.playery = 150

	'Bonusitems adden
		'Collection Items		
		  lev.Items.AddBonusItem(TBonusItem.Create(193,138,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(285,140,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(382,139,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(499,138,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(608,137,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(668,263,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1780,136,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1382,944,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1788,943,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(183,1749,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(390,1761,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(734,1270,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(734,1487,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1192,1541,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1192,1740,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1758,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1767,1354,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1088,1356,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1467,946,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1688,1355,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1167,1355,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1388,1540,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(478,1763,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(183,1669,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(271,1158,-1,80,"images/colItem1.png"))


		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(500,150,8000,21, "images/booster_final.png"))

	End Function	
	
	
	gmChapter1.AddLevel(TLevel.Create(7,"Level 7: " + getlang("Labyrinth") + " 2",getlang("Eine echte Herausforderung"),"Levels/Q1/orientierung2.map",updateC1L7,initc1l7))
    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("UFO2", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(3)),1))















	'LEVEL 8 : Kampfdrohnen 3
	Function updateC1L8(lev:TLevel)
		Local i:Int
		'lev.stand = 4
		If lev.stand = 0 Then
			Local sh:TShip
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				sh.spawn			
				Count1 = Count1 + 1
			
				If gdifficulty = 0 Then
					If Count1 = 1 Then Exit
				Else If gdifficulty = 1 Then
					If Count1 = 2 Then Exit
				Else If gdifficulty = 2 Then																	
					If Count1 = 3 Then Exit
				End If

			Next
			lev.stand = 1               
		End If
		
		If lev.stand = 1 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
			Next                            
			
			If alle < 2 Then
				Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn
					Count1 = Count1 + 1
					
					If gdifficulty = 0 Then
						If Count1 = 2 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 3 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 4 Then Exit
					End If
					
				Next                            
				lev.stand = 2
			End If
		End If
                        

		If lev.stand = 2 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle < 2 Then
				Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn
					Count1 = Count1 + 1
					
					If gdifficulty = 0 Then
						If Count1 = 3 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 4 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 6 Then Exit
					End If
					
					
				Next                            
				lev.stand = 3
			End If
		End If

		
		If lev.stand = 3 Then
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle < 2 Then
				Local count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn	'alle spawnen
					Count1 = Count1 + 1
					
					If gdifficulty = 0 Then
						If Count1 = 4 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 5 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 7 Then Exit
					End If
					'If count1 = 10 Then Exit
				Next                            
				lev.stand = 4
			End If
		End If   
		
		If lev.stand = 4 Then          
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            

			If alle < 2 Then
				levelrekord.setrekord(TShip(lev.gegner.sh_list.Last()).ausgeteilterSchaden - TShip(lev.gegner.sh_list.Last()).eingesteckterSchaden, lev.id, 1)				

				TShip(lev.gegner.sh_list.Last()).LevelEnde(1)
				
				Return
			End If
		End If
		
		If levelschluss = 0  Then
		
			If TShip(lev.gegner.sh_list.Last()).dead=1 Then       
'				levelrekord.setrekord(TShip(lev.gegner.sh_list.Last()).ausgeteilterSchaden - TShip(lev.gegner.sh_list.Last()).eingesteckterSchaden, lev.id, 1)				
			   
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If
		End If
	End Function

	Function initC1L8(lev:TLevel)
  
	  'Gegner adden
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	'lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	'lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	'lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	
	  'Bonusitems adden
		  'PowerLaser
		  lev.Items.AddBonusItem(TBonusItem.Create(500,350,8000,2,"images/powerlaserLevel.png"))
		                                      
		  'Red Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(500,200,8000,31,"images/schildi2.png"))
	
		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(400,200,8000,20,"images/radar.png"))

	End Function


	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(8,"Level 8: " + getlang("Kampfdrohnen") + " 3",getlang("Teamwork"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L8,initC1L8))





	'zweikampf 2


	'LEVEL 9 : Zweikampf 2

	Function updateC1L9(lev:TLevel)
		
		'TShip(lev.gegner.sh_list.first()).deathmatchfrags

		lev.drawLevelX = 300
		lev.drawlevelY = 50		
		lev.DrawLevel = TShip(lev.gegner.sh_list.Last()).name  + "  " + TShip(lev.gegner.sh_list.last()).deathmatchfrags + " : " + TShip(lev.gegner.sh_list.first()).deathmatchfrags + "  " + TShip(lev.gegner.sh_list.first()).name
		
		If TShip(lev.gegner.sh_list.last()).deathmatchfrags >= 5 Then
			levelrekord.setrekord(TShip(lev.gegner.sh_list.last()).deathmatchfrags - TShip(lev.gegner.sh_list.first()).deathmatchfrags, lev.id, 4)
		
			TShip(lev.gegner.sh_list.Last()).LevelEnde(1) 'gewonnen
			Return
		End If

		If levelschluss = 0  Then
			If TShip(lev.gegner.sh_list.first()).deathmatchfrags >= 5 Then
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0) 'verloren
				Return
			End If
		End If
		

	End Function
	

	Function initC1L9(lev:TLevel)

    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("Gegner", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(0)),1,"KI/Ausscheidungskampf1.lua"))
		lev.gegner.addShip(Tship.Create(getlang("Gegner"), 1609, 1665, 2,1, gleitersammlung.getgleiterbyid(3),1,"KI/Ausscheidungskampf2.lua"))
	
'images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,343,241,0
'images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,475,240,0
'images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1609,1665,0
'images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1457,1665,0

		
		  'Flammenwerfer
		  'lev.Items.AddBonusItem(TBonusItem.Create(1297,1331,8000,5,"images/flamerLevel.png"))
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(1298,1438,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  'lev.Items.AddBonusItem(TBonusItem.Create(302,1637,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(421,1638,8000,12,"images/powerlaser_muni.png"))

		  'Minen
		  lev.Items.AddBonusItem(TBonusItem.Create(1457,1665,8000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1457,1665,8000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1457,1665,8000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1457,1665,8000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1457,1665,8000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1457,1665,8000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1457,1665,8000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1457,1665,8000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1457,1665,8000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1457,1665,8000,6,"images/MineLevel.png"))



		  lev.Items.AddBonusItem(TBonusItem.Create(475,240,8000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(475,240,8000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(475,240,8000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(475,240,8000,6,"images/MineLevel.png"))



												                                      
		  'Yellow Shield
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,209,8000,31,"images/schildi2.png"))
	
		  'Life Bonus 
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,409,8000,22,"images/lifebonus1.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,469,8000,22,"images/lifebonus1.png"))

		  'Turbo-Booster
		  'lev.Items.AddBonusItem(TBonusItem.Create(428,243,8000,21,"images/booster_final.png"))

      End Function         
	
	
	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(9,"Level 9: " + getlang("Zweikampf") + " 2",getlang("Minenfelder"),"Levels/Q1/Ausscheidung2.map",updateC1L9,initC1L9))





	










   
	'LEVEL 10 : Sicherung 2
	
	Function updateC1L10(lev:TLevel)
		'Pausenmenü-Aufenthalt in Zeit einrechnen
		If (MilliSecs() > lastcall + 1000) And (lastcall <> 0) Then
			lev.startzeit = lev.startzeit + MilliSecs() - lastcall
		End If
		lastcall = MilliSecs()						
	
		Local minuten:Int
		Local sekunden:Int
		Local seks:String
		Local z:Int = (MilliSecs()-lev.startzeit)/1000
		If (z = 30) And (lev.stand = 0) Then lev.stand = -1
	
		
		Local i:Int
		'lev.stand = 4
		If lev.stand = -1 Then
			Local sh:TShip
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.autospawn = 0 And sh.ai <> 98 Then
					sh.spawn		
					Count1 = Count1 + 1
				End If
				If Count1 = 3 Then Exit
			Next
			lev.stand = 1
		End If
		
		
		If lev.stand = 1 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 And sh.autospawn = 0 And sh.ai <> 98 Then alle = alle + 1
			Next                            
			
			If alle = 0 Then 
				Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					If sh.autospawn = 0 And sh.ai <> 98 Then
						sh.spawn
						Count1 = Count1 + 1
					End If
					If Count1 = 4 Then Exit
				Next                            
				lev.stand = 2
			End If
		End If
                        

		If lev.stand = 2 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0  And sh.autospawn = 0 And sh.ai <> 98 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle = 0 Then
				Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					If sh.autospawn = 0 And sh.ai <> 98 Then
						sh.spawn
						Count1 = Count1 + 1
					End If
					
					If gdifficulty = 0 Then
						If Count1 = 4 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 5 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 6 Then Exit
					End If
					
					
				Next                            
				lev.stand = 3
			End If
		End If

		
		If lev.stand = 3 Then
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 And sh.autospawn = 0 And sh.ai <> 98 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle = 0 Then
				Local count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					If sh.autospawn = 0 And sh.ai <> 98 Then
						sh.spawn			
						count1 = count1 + 1
					End If
					
					If gdifficulty = 0 Then
						If Count1 = 5 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 6 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 7 Then Exit
					End If
					
					
				Next                            
				lev.stand = 4
			End If
		End If   
		
		
		If lev.stand = 4 Then
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 And sh.autospawn = 0 And sh.ai <> 98 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle = 0 Then
				Local count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					If sh.autospawn = 0 And sh.ai <> 98 Then
						sh.spawn			
						count1 = count1 + 1
					End If
					If gdifficulty = 0 Then
						If Count1 = 6 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 7 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 8 Then Exit
					End If
					
					
				Next                            
				lev.stand = 7
			End If
		End If   		


		
		If lev.stand = 5 Then
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 And sh.autospawn = 0 And sh.ai <> 98 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle = 0 Then
				Local count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					If sh.autospawn = 0 And sh.ai <> 98 Then
						sh.spawn			
						count1 = count1 + 1
					End If
					
					If gdifficulty = 0 Then
						If Count1 = 8 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 9 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 11 Then Exit
					End If
					
					
				Next                            
				lev.stand = 7
			End If
		End If   		


						
												
																								
		
		
		If lev.stand = 7 Then          
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 And sh.autospawn = 0 And sh.ai <> 98 Then alle = alle + 1
				'sh.spawn			
			Next                            

			'Spieler gewonnen?
			If alle = 0 Then
				levelrekord.setrekord(TShip(lev.gegner.sh_list.first()).life,lev.id, 2)
			
				TShip(lev.gegner.sh_list.Last()).LevelEnde(1)
				Return
			End If
		End If
		
		
		If levelschluss = 0  Then
		
			'Spieler verloren?
			If (TShip(lev.gegner.sh_list.Last()).dead=1) Or (TShip(lev.gegner.sh_list.first()).dead=1) Then          
'				levelrekord.setrekord(TShip(lev.gegner.sh_list.first()).life,lev.id, 2)
			
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If
		End If
		
	End Function


	Function initC1L10(lev:TLevel)

	    'Gegner adden
		'											Function create:TShip(pname$,posx#,posy#,pteam,pai,pschiff:TGleiter, autoSpawn:Int)

    	'Raumstation mit Team 0, AI = 99
		lev.gegner.addShip(Tship.Create("Station1", 1600, 1000, 0, 99, gleitersammlung.getgleiterbyid(8),1))

		lev.playerx = 1500
		lev.playery = 1000

		'Angreifende Kampfdrohnen
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))

		  'Bonusitems adden
	
		  'Towers
		  lev.Items.AddBonusItem(TBonusItem.Create(1400,900,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1400,950,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1400,1000,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1400,1050,8000,81,"images/t1Level.png",aktuellerLevel))


	
		  'Minen
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,920,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1000,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1080,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1160,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1240,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,920,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1000,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1080,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1160,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1240,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,920,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1000,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1080,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1160,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1240,-1,6,"images/MineLevel.png"))



		  'Flammenwerfer
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1400,15000,5,"images/flamerLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1800,1500,15000,5,"images/flamerLevel.png"))
	
		  'Triple Laser
		  'lev.Items.AddBonusItem(TBonusItem.Create(800,1300,8000,3,"images/tripleLevel.png"))
         
		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(1300,800,8000,20,"images/radar.png"))
		                             
		  'Red Shield
		 ' lev.Items.AddBonusItem(TBonusItem.Create(800,800,8000,31,"images/schildi2.png"))
	
	End Function


	gmChapter1.AddLevel(TLevel.Create(10,"Level 10: " + getlang("Sicherung") + " 2",getlang("An der Wand"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L10,initC1L10))







	'LEVEL 11 : Kampfdrohnen 4
	Function updateC1L11(lev:TLevel)
		Local i:Int
		'lev.stand = 4
		If lev.stand = 0 Then
			Local sh:TShip
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				sh.spawn			
				Count1 = Count1 + 1
				
					If gdifficulty = 0 Then
						If Count1 = 1 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 2 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 3 Then Exit
					End If
				
				
			Next
			lev.stand = 1               
		End If
		
		If lev.stand = 1 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
			Next                            
			
			If alle < 2 Then
				Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn
					Count1 = Count1 + 1
					
					If gdifficulty = 0 Then
						If Count1 = 2 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 3 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 4 Then Exit
					End If
					
				Next                            
				lev.stand = 2
			End If
		End If
                        

		If lev.stand = 2 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle < 2 Then
				Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn
					Count1 = Count1 + 1
					
					If gdifficulty = 0 Then
						If Count1 = 4 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 5 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 6 Then Exit
					End If
					
				Next                            
				lev.stand = 4
			End If
		End If

		
'		If lev.stand = 3 Then
'			Local sh:TShip
'			Local alle:Int=0
'			For sh:TShip = EachIn lev.Gegner.sh_list
'				If sh.dead = 0 Then alle = alle + 1
'				'sh.spawn			
'			Next                            
			
'			If alle < 2 Then
'				Local count1 = 0
'				For sh:TShip = EachIn lev.Gegner.sh_list
'					sh.spawn	'alle spawnen
'					If count1 = 7 Then Exit
'				Next                            
'				lev.stand = 4
'			End If
'		End If   
		
		If lev.stand = 4 Then          
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            

			If alle < 2 Then
				levelrekord.setrekord(TShip(lev.gegner.sh_list.Last()).ausgeteilterSchaden - TShip(lev.gegner.sh_list.Last()).eingesteckterSchaden, lev.id, 1)				
			
				TShip(lev.gegner.sh_list.Last()).LevelEnde(1)
				Return
			End If
		End If
		
		If levelschluss = 0  Then
		
			If TShip(lev.gegner.sh_list.Last()).dead=1 Then     
'				levelrekord.setrekord(TShip(lev.gegner.sh_list.Last()).ausgeteilterSchaden - TShip(lev.gegner.sh_list.Last()).eingesteckterSchaden, lev.id, 1)				
			     
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If
		End If

	End Function


	Function initC1L11(lev:TLevel)

	  'Gegner adden
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	
	  'Bonusitems adden
		  'Flammenwerfer
'		  TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,500,8000,5,"images/flamerLevel.png"))
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,450,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  lev.Items.AddBonusItem(TBonusItem.Create(400,300,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,300,8000,12,"images/powerlaser_muni.png"))
		                                      
		  'Red Shield
'		  TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,200,8000,31,"images/schildi2.png"))
	
		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(400,400,8000,21,"images/booster_final.png"))

		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(400,200,8000,20,"images/radar.png"))
		  
		 'Triple Laser
'		  lev.Items.AddBonusItem(TBonusItem.Create(400,300,8000,3,"images/tripleLevel.png"))

	End Function

	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(11,"Level 11: " + getlang("Kampfdrohnen") + " 4",getlang("Triple Drohnen"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L11,initc1l11))









	'LEVEL 12 : Zweikampf 3

	Function updateC1L12(lev:TLevel)
		
		'TShip(lev.gegner.sh_list.first()).deathmatchfrags

		lev.drawLevelX = 300
		lev.drawlevelY = 50		
		lev.DrawLevel = TShip(lev.gegner.sh_list.Last()).name  + "  " + TShip(lev.gegner.sh_list.last()).deathmatchfrags + " : " + TShip(lev.gegner.sh_list.first()).deathmatchfrags + "  " + TShip(lev.gegner.sh_list.first()).name
		
		If TShip(lev.gegner.sh_list.last()).deathmatchfrags >= 5 Then
			levelrekord.setrekord(TShip(lev.gegner.sh_list.last()).deathmatchfrags - TShip(lev.gegner.sh_list.first()).deathmatchfrags, lev.id, 4)
		
			TShip(lev.gegner.sh_list.Last()).LevelEnde(1) 'gewonnen
			Return
		End If

		If levelschluss = 0  Then
			If TShip(lev.gegner.sh_list.first()).deathmatchfrags >= 5 Then
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0) 'verloren
				Return
			End If
		End If
		

	End Function
	

	Function initC1L12(lev:TLevel)

    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("Gegner", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(0)),1,"KI/Ausscheidungskampf1.lua"))
		lev.gegner.addShip(Tship.Create(getlang("Gegner"), 1726, 1698, 2,1, gleitersammlung.getgleiterbyid(0),1,"KI/Ausscheidungskampf3.lua"))
	
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,260,176,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1726,1698,0


'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,900,624,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1219,987,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1661,211,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,308,1616,0

		
		  'Flammenwerfer
		  'lev.Items.AddBonusItem(TBonusItem.Create(1297,1331,8000,5,"images/flamerLevel.png"))
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(1298,1438,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  'lev.Items.AddBonusItem(TBonusItem.Create(302,1637,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(421,1638,8000,12,"images/powerlaser_muni.png"))

		  'Minen
		  'lev.Items.AddBonusItem(TBonusItem.Create(1683,338,8000,6,"images/MineLevel.png"))

		  'Bullet of Death
		  lev.Items.AddBonusItem(TBonusItem.Create(900,624,15000,8,"images/deathLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1219,987,15000,8,"images/deathLevel.png"))
		                                      
		  'Yellow Shield
		  'lev.Items.AddBonusItem(TBonusItem.Create(847,1174,8000,31,"images/schildi2.png"))
	
		  'Life Bonus 
		  'lev.Items.AddBonusItem(TBonusItem.Create(574,1169,8000,22,"images/lifebonus1.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,469,8000,22,"images/lifebonus1.png"))

		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(1661,211,8000,21,"images/booster_final.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(308,1616,8000,21,"images/booster_final.png"))


      End Function         
	
	
	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(12,"Level 12: " + getlang("Zweikampf") + " 3",getlang("Duell der Scharfschützen"),"Levels/Q1/Ausscheidung3.map",updateC1L12,initC1L12))







	'LEVEL 13 : Labyrinth 3
	
	Function updateC1L13(lev:TLevel)
		'Pausenmenü-Aufenthalt in Zeit einrechnen
		If (MilliSecs() > lastcall + 1000) And (lastcall <> 0) Then
			lev.startzeit = lev.startzeit + MilliSecs() - lastcall
		End If
		lastcall = MilliSecs()						


		Local minuten:Int
		Local sekunden:Int
		Local seks:String
		Local z:Int = (MilliSecs()-lev.startzeit)/1000
		
		
		If gdifficulty = 0 Then
			z = 75-z		
		Else If gdifficulty = 1 Then
			z = 65-z		
		Else If gdifficulty = 2 Then
			z = 55-z		
		End If

		
		minuten = z/60
		sekunden = z Mod 60
		If sekunden < 10 Then seks = "0" + sekunden Else seks = sekunden
	
		
		If lev.stand = 0 Then
			Local sh:TShip
			For sh:TShip = EachIn lev.Gegner.sh_list
				sh.spawn			
			Next
			lev.stand = 1               
		End If
		
		
		
		'Die letzten 10 Sekunden ding,ding,.... und rote Schrift
		If z < 10 Then 
			playeffect(sDing)
			lev.DrawRed=1
		End If
		
		lev.DrawLevel = "0"+minuten+":"+seks
		'DrawSuper("0"+minuten+":"+seks ,400,50)
		
					
		Local anzahlAlle:Int=0
		Local anzahlUebrig:Int=0
				
		'Hat Spieler gewonnen?
		Local bi:TBonusitem		
		Local gewonnen:Int=1
		For bi:TBonusItem = EachIn lev.items.bonusitems
			If bi.itemart = 80 Then
				AnzahlAlle:+1
				If bi.show = 1 Then
					AnzahlUebrig:+1
					gewonnen = 0
				End If
			End If				
		Next
		If gewonnen=1 Then 			
				levelrekord.setrekord(z, lev.id, 3)
		
			TShip(lev.gegner.sh_list.Last()).LevelEnde(1)
			Return
		End If	

		
		If levelschluss = 0  Then
						
			anzahlUebrig = AnzahlAlle - AnzahlUebrig
			lev.DrawLevel = lev.DrawLevel + "    " + anzahlUebrig + "/" + AnzahlAlle
			lev.drawLevelX = 390
			lev.drawlevelY = 50
						
			'Hat Spieler verloren?
			If z < 1 Then
'				levelrekord.setrekord(z, lev.id, 3)
			
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If	
		End If

		If levelschluss = 0 Then		
			If TShip(lev.gegner.sh_list.Last()).dead=1 Then       
'				levelrekord.setrekord(z, lev.id, 3)
			   
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If
		End If
		
						
	End Function
	
	
	Function initC1L13(lev:TLevel)
		lev.gegner.addShip(Tship.Create(getlang("Gegner"), 150, 150, 2,1, gleitersammlung.getgleiterbyid(1),1,"KI/Labyrinth3.lua"))

    	lev.gegner.addShip(Tship.Create("UFO2", 1778, 130, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 982, 1738, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 186, 1756, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1349, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 394, 947, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 803, 748, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 785, 1141, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
		
		lev.playerx = 200
		lev.playery = 150

	'Bonusitems adden
		'Collection Items		
		  lev.Items.AddBonusItem(TBonusItem.Create(182,336,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(194,132,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(588,325,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(992,322,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(985,137,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1778,130,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1403,560,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1187,542,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1536,1055,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(982,1738,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(768,1748,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(186,1756,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(400,1349,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(174,1134,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(394,947,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(803,748,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(785,1141,-1,80,"images/colItem1.png"))

		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(500,150,8000,21, "images/booster_final.png"))

		  'PowerLaser
		  'lev.Items.AddBonusItem(TBonusItem.Create(150,150,8000,2,"images/powerlaserLevel.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(150,150,8000,2,"images/powerlaserLevel.png"))
		  'Triple Laser
		  'lev.Items.AddBonusItem(TBonusItem.Create(150,150,8000,3,"images/tripleLevel.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(150,150,8000,3,"images/tripleLevel.png"))




	End Function	
	
	
	gmChapter1.AddLevel(TLevel.Create(13,"Level 13: " + getlang("Labyrinth") + " 3",getlang("Der Gejagte"),"Levels/Q1/orientierung3.map",updateC1L13,initc1l13))
    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("UFO2", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(3)),1))








	'LEVEL 14 : Kampfdrohnen 5
	Function updateC1L14(lev:TLevel)
		Local i:Int
		'lev.stand = 4
		If lev.stand = 0 Then
			Local sh:TShip
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				sh.spawn			
				Count1 = Count1 + 1
					If gdifficulty = 0 Then
						If Count1 = 2 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 3 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 4 Then Exit
					End If
				
				
			Next
			lev.stand = 1               
		End If
		
		If lev.stand = 1 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
			Next                            
			
			If alle < 2 Then
				Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn
					Count1 = Count1 + 1
					
					If gdifficulty = 0 Then
						If Count1 = 3 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 5 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 6 Then Exit
					End If
					
				Next                            
				lev.stand = 2
			End If
		End If
                        

		If lev.stand = 2 Then
			Local sh:TShip
			Local alle:Int=0
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle < 2 Then
				Count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn
					Count1 = Count1 + 1
					
					If gdifficulty = 0 Then
						If Count1 = 4 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 6 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 8 Then Exit
					End If
					
					
				Next                            
				lev.stand = 3
			End If
		End If
		
		If lev.stand = 3 Then
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            
			
			If alle < 2 Then
				Local count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					'sh.spawn	'alle spawnen
					'If count1 = 7 Then Exit
					sh.spawn
					count1 = count1 + 1
					If gdifficulty = 0 Then
						If Count1 = 6 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 7 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 9 Then Exit
					End If
					
				Next                            
				lev.stand = 4
			End If
		End If   
		
		If lev.stand = 4 Then          
			Local sh:TShip
			Local alle:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				If sh.dead = 0 Then alle = alle + 1
				'sh.spawn			
			Next                            

			If alle < 2 Then
				levelrekord.setrekord(TShip(lev.gegner.sh_list.Last()).ausgeteilterSchaden - TShip(lev.gegner.sh_list.Last()).eingesteckterSchaden, lev.id, 1)				
			
				TShip(lev.gegner.sh_list.Last()).LevelEnde(1)
				Return
			End If
		End If
		
		If levelschluss = 0  Then
		
			If TShip(lev.gegner.sh_list.Last()).dead=1 Then          
'				levelrekord.setrekord(TShip(lev.gegner.sh_list.Last()).ausgeteilterSchaden - TShip(lev.gegner.sh_list.Last()).eingesteckterSchaden, lev.id, 1)				
			
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0)
				Return
			End If
		End If

	End Function


	Function initC1L14(lev:TLevel)

	  'Gegner adden
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	
	  'Bonusitems adden
		  'Flammenwerfer
'		  TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,500,8000,5,"images/flamerLevel.png"))
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,450,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  lev.Items.AddBonusItem(TBonusItem.Create(400,300,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,300,8000,12,"images/powerlaser_muni.png"))
		                                      
		  'Y-Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(400,200,8000,31,"images/schildi2.png"))
	
		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(400,400,8000,21,"images/booster_final.png"))

		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(400,500,8000,20,"images/radar.png"))
		  
		 'Triple Laser
		  lev.Items.AddBonusItem(TBonusItem.Create(400,600,8000,3,"images/tripleLevel.png"))

		  'Life Bonus
		  lev.Items.AddBonusItem(TBonusItem.Create(500,200,15000,22,"images/lifebonus1.png"))

	End Function


	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(14,"Level 14: " + getlang("Kampfdrohnen") + " 5",getlang("Dreierpack"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L14,initc1l14))




