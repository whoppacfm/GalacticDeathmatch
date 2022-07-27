




	'LEVEL 15 : Zweikampf 4

	Function updateC1L15(lev:TLevel)
		
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
	

	Function initC1L15(lev:TLevel)

    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("Gegner", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(0)),1,"KI/Ausscheidungskampf1.lua"))
		lev.gegner.addShip(Tship.Create(getlang("Gegner"), 1698, 1698, 2,1, gleitersammlung.getgleiterbyid(2),1,"KI/Ausscheidungskampf4.lua"))


'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,247,184,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1698,1698,0

		
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,506,1542,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,716,1537,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1460,647,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,395,797,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1637,244,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,395,346,0
		
		  'Flammenwerfer
		  lev.Items.AddBonusItem(TBonusItem.Create(506,1542,8000,5,"images/flamerLevel.png"))
				
		  'Triple Laser
		  lev.Items.AddBonusItem(TBonusItem.Create(716,1537,15000,3,"images/tripleLevel.png"))

		  'PowerLaser
		  lev.Items.AddBonusItem(TBonusItem.Create(1460,647,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(421,1638,8000,12,"images/powerlaser_muni.png"))
		                                      
		  'Yellow Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(395,797,8000,31,"images/schildi2.png"))
	
		  'Life Bonus 
		  lev.Items.AddBonusItem(TBonusItem.Create(1637,244,8000,22,"images/lifebonus1.png"))

		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(395,346,8000,21,"images/booster_final.png"))

      End Function         
	
	
	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(15,"Level 15: " + getlang("Zweikampf") + " 4",getlang("Jetzt wird abgerechnet!"),"Levels/Q1/Ausscheidung4.map",updateC1L15,initC1L15))












	'LEVEL 16 : Kampfdrohnen 6
	Function updateC1L16(lev:TLevel)
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
						If Count1 = 5 Then Exit
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
						If Count1 = 5 Then Exit
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
					sh.spawn
					count1 = count1 + 1
					If gdifficulty = 0 Then
						If Count1 = 6 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 8 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 9 Then Exit
					End If
				
				
					'sh.spawn	'alle spawnen
					'If count1 = 7 Then Exit
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


	Function initC1L16(lev:TLevel)

	  'Gegner adden
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	
	  'Bonusitems adden
		  'Flammenwerfer
		  lev.Items.AddBonusItem(TBonusItem.Create(400,300,8000,5,"images/flamerLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(500,300,8000,5,"images/flamerLevel.png"))
		  
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,450,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,300,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,300,8000,12,"images/powerlaser_muni.png"))
		                                      
		  'Y-Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(400,200,8000,31,"images/schildi2.png"))
	
		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(400,400,8000,21,"images/booster_final.png"))

		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(400,500,8000,20,"images/radar.png"))
		  
		 'Triple Laser
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,600,8000,3,"images/tripleLevel.png"))

		  'Life Bonus
		  lev.Items.AddBonusItem(TBonusItem.Create(400,600,15000,22,"images/lifebonus1.png"))

	End Function


	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(16,"Level 16: " + getlang("Kampfdrohnen") + " 6",getlang("Flamer Drohnen"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L16,initc1l16))









   
	'LEVEL 17 : Sicherung 3
	
	Function updateC1L17(lev:TLevel)
		'Pausenmenü-Aufenthalt in Zeit einrechnen
		If (MilliSecs() > lastcall + 1000) And (lastcall <> 0) Then
			lev.startzeit = lev.startzeit + MilliSecs() - lastcall
		End If
		lastcall = MilliSecs()						
	
		Local minuten:Int
		Local sekunden:Int
		Local seks:String
		Local z:Int = (MilliSecs()-lev.startzeit)/1000
		If (z = 40) And (lev.stand = 0) Then lev.stand = -1
	
		
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
				
				If gdifficulty = 0 Then
					If Count1 = 3 Then Exit
				Else If gdifficulty = 1 Then
					If Count1 = 5 Then Exit
				Else If gdifficulty = 2 Then																	
					If Count1 = 6 Then Exit
				End If
				
				
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
					
					If gdifficulty = 0 Then
						If Count1 = 4 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 5 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 8 Then Exit
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
						If Count1 = 6 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 7 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 9 Then Exit
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
						If Count1 = 10 Then Exit
					End If
					
					
				Next                            
				lev.stand = 5
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
						If Count1 = 10 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 11 Then Exit
					End If
					
					
				Next                            
				lev.stand = 6
			End If
		End If   		
		
		
		If lev.stand = 6 Then
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
						If Count1 = 10 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 12 Then Exit
					End If
					
					
				Next                            
				lev.stand = 8
			End If
		End If   			
		
		
'		If lev.stand = 4 Then
'			Local sh:TShip
'			Local alle:Int=0
'			For sh:TShip = EachIn lev.Gegner.sh_list
'				If sh.dead = 0 And sh.autospawn = 0 and sh.ai <> 98 Then alle = alle + 1
'				'sh.spawn			
'			Next                            
'			
'			If alle = 0 Then
'				Local count1 = 0
'				For sh:TShip = EachIn lev.Gegner.sh_list
'					If sh.autospawn = 0 and sh.ai <> 98 Then
'						sh.spawn			
'						count1 = count1 + 1
'					End If
'					If count1 = 7 Then Exit
'				Next                            
'				lev.stand = 5
'			End If
'		End If   		
		
		
		If lev.stand = 8 Then          
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


	Function initC1L17(lev:TLevel)


'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,982,182,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,805,347,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,916,344,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1036,339,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1149,344,0

'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,818,1413,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,957,1414,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1118,1420,0



	    'Gegner adden
		'											Function create:TShip(pname$,posx#,posy#,pteam,pai,pschiff:TGleiter, autoSpawn:Int)

    	'Raumstation mit Team 0, AI = 99
		lev.gegner.addShip(Tship.Create("Station1", 915, 300, 0, 99, gleitersammlung.getgleiterbyid(8),1))

		lev.playerx = 820
		lev.playery = 400

		'Angreifende Kampfdrohnen
    	lev.gegner.addShip(Tship.Create("UFO2", 818, 1413, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 957, 1413, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1118, 1413, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 818, 1413, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 957, 1413, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1118, 1413, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 818, 1413, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 957, 1413, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1118, 1413, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 957, 1413, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1118, 1413, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 818, 1413, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 957, 1413, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1118, 1413, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 818, 1413, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))


		  'Bonusitems adden
	
		  'Minen
		  lev.Items.AddBonusItem(TBonusItem.Create(900,200,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(980,200,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1050,200,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(900,200,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(980,200,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1050,200,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(900,200,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(980,200,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1050,200,-1,6,"images/MineLevel.png"))
		  		
		
		  'Towers
		  lev.Items.AddBonusItem(TBonusItem.Create(920,530,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(970,530,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1020,530,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1070,530,8000,81,"images/t1Level.png",aktuellerLevel))

		  lev.Items.AddBonusItem(TBonusItem.Create(970,630,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1020,630,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(920,630,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1070,630,8000,82,"images/t2Level.png",aktuellerLevel))


				
		  'Flammenwerfer
		  'lev.Items.AddBonusItem(TBonusItem.Create(800,1300,15000,5,"images/flamerLevel.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(800,1400,15000,5,"images/flamerLevel.png"))

		  'Target Gun
		  'lev.Items.AddBonusItem(TBonusItem.Create(800,1300,15000,7,"images/rocketLevel.png"))
	
		  'Triple Laser
		  lev.Items.AddBonusItem(TBonusItem.Create(1000,470,8000,3,"images/tripleLevel.png"))
         
		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(1000,1300,8000,20,"images/radar.png"))
		                             
		  'Red Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(1000,1400,8000,31,"images/schildi2.png"))
	
	End Function


	gmChapter1.AddLevel(TLevel.Create(17,"Level 17: " + getlang("Sicherung") + " 3",getlang("Bewache den Durchgang"),"Levels/Q1/sicherung3.map",updateC1L17,initC1L17))










	'LEVEL 18 : Zweikampf 5

	Function updateC1L18(lev:TLevel)
		
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
	

	Function initC1L18(lev:TLevel)

    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("Gegner", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(0)),1,"KI/Ausscheidungskampf1.lua"))
		lev.gegner.addShip(Tship.Create(getlang("Gegner"), 1775, 1737, 2,1, gleitersammlung.getgleiterbyid(1),1,"KI/Ausscheidungskampf5.lua"))


'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,218,148,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1775,1737,0

'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1761,151,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,231,1717,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1070,671,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1264,285,0
		
		
		  'Flammenwerfer
		  'lev.Items.AddBonusItem(TBonusItem.Create(1297,1331,8000,5,"images/flamerLevel.png"))
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(1298,1438,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  'lev.Items.AddBonusItem(TBonusItem.Create(302,1637,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(421,1638,8000,12,"images/powerlaser_muni.png"))

		  'Minen
		  lev.Items.AddBonusItem(TBonusItem.Create(331,1717,8000,6,"images/MineLevel.png"))
  		  lev.Items.AddBonusItem(TBonusItem.Create(331,1717,8000,6,"images/MineLevel.png"))
                                      
		
		
		  'Yellow Shield
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,209,8000,31,"images/schildi2.png"))

		  'Triple Laser
		  lev.Items.AddBonusItem(TBonusItem.Create(1064,585,15000,3,"images/tripleLevel.png"))
		  
			'Mine
		  lev.Items.AddBonusItem(TBonusItem.Create(1364,385,8000,6,"images/MineLevel.png"))


		  'Allrounder
		  lev.Items.AddBonusItem(TBonusItem.Create(1070,671,15000,4,"images/allrounderLevel.png"))
	
		  'Life Bonus 
		  lev.Items.AddBonusItem(TBonusItem.Create(231,1717,8000,22,"images/lifebonus1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(231,1617,8000,22,"images/lifebonus1.png"))
		
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,469,8000,22,"images/lifebonus1.png"))

		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(1761,166,8000,21,"images/booster_final.png"))

      End Function         
	
	
	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(18,"Level 18: " + getlang("Zweikampf") + " 5",getlang("Schlacht im Trümmerfeld"),"Levels/Q1/Ausscheidung5.map",updateC1L18,initC1L18))












	'LEVEL 19 : Kampfdrohnen 7
	Function updateC1L19(lev:TLevel)
		Local i:Int
		'lev.stand = 4
		If lev.stand = 0 Then
			Local sh:TShip
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				sh.spawn			
				Count1 = Count1 + 1
				If Count1 = 3 Then Exit
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
						If Count1 = 4 Then Exit
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
						If Count1 = 5 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 7 Then Exit
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
					sh.spawn	'alle spawnen
					count1 = count1 + 1
					If gdifficulty = 0 Then
						If Count1 = 3 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 4 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 5 Then Exit
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


	Function initC1L19(lev:TLevel)

	  'Gegner adden
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	
	  'Bonusitems adden
		  'Flammenwerfer
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,300,8000,5,"images/flamerLevel.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(500,300,8000,5,"images/flamerLevel.png"))
		  
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,450,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,300,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,300,8000,12,"images/powerlaser_muni.png"))
		                                      
		  'Y-Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(400,200,8000,31,"images/schildi2.png"))
	
		  'Turbo-Booster
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,400,8000,21,"images/booster_final.png"))

		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(400,300,8000,20,"images/radar.png"))
		  
		 'Triple Laser
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,600,8000,3,"images/tripleLevel.png"))

		  'Life Bonus
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,600,15000,22,"images/lifebonus1.png"))

		  'Target Gun
		  lev.Items.AddBonusItem(TBonusItem.Create(400,400,15000,7,"images/rocketLevel.png"))

	End Function


	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(19,"Level 19: " + getlang("Kampfdrohnen") + " 7",getlang("Gute Mischung"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L19,initc1l19))














	'LEVEL 20 : Labyrinth 4
	
	Function updateC1L20(lev:TLevel)
		'Pausenmenü-Aufenthalt in Zeit einrechnen
		If (MilliSecs() > lastcall + 1000) And (lastcall <> 0) Then
			lev.startzeit = lev.startzeit + MilliSecs() - lastcall
		End If
		lastcall = MilliSecs()						


		Local minuten:Int
		Local sekunden:Int
		Local seks:String
		Local z:Int = (MilliSecs()-lev.startzeit)/1000
		z = 60-z
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
	
	
	Function initC1L20(lev:TLevel)

    	lev.gegner.addShip(Tship.Create("UFO2", 189, 1155, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 390, 1126, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 555, 1125, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 801, 1349, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 910, 1118, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 204, 1737, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1297, 1494, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1583, 1475, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1753, 1730, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1648, 1730, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1565, 1386, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1188, 1484, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1560, 1078, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1438, 1078, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 746, 454, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 838, 456, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 942, 456, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 754, 553, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/droneo1.lua"))

		lev.playerx = 200
		lev.playery = 150

	'Bonusitems adden
		'Collection Items		
		  lev.Items.AddBonusItem(TBonusItem.Create(189,1155,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(390,1126,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(555,1125,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(801,1125,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(910,1118,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(204,1737,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1297,1494,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1583,1475,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1753,1730,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1648,1730,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1565,1386,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1188,1484,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1560,1078,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1438,1078,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1584,156,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1589,238,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1590,347,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1788,141,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1792,242,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1795,323,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(746,454,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(838,456,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(942,456,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(754,553,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(859,557,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(969,561,-1,80,"images/colItem1.png"))

		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(500,150,8000,21, "images/booster_final.png"))

		  'Flammenwerfer
		  lev.Items.AddBonusItem(TBonusItem.Create(550,150,8000,5,"images/flamerLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(600,150,8000,5,"images/flamerLevel.png"))

		  'Yellow Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(650,150,8000,31,"images/schildi2.png"))


	End Function	
	
	gmChapter1.AddLevel(TLevel.Create(20,"Level 20: " + getlang("Labyrinth") + " 4",getlang("Bewachtes Gebiet"),"Levels/Q1/orientierung4.map",updateC1L20,initc1l20))
    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("UFO2", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(3)),1))





	'LEVEL 21 : Zweikampf 6

	Function updateC1L21(lev:TLevel)
		
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
	

	Function initC1L21(lev:TLevel)

    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("Gegner", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(0)),1,"KI/Ausscheidungskampf1.lua"))
		lev.gegner.addShip(Tship.Create(getlang("Gegner"), 1738, 1721, 2,1, gleitersammlung.getgleiterbyid(4),1,"KI/Ausscheidungskampf6.lua"))


'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,242,180,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1611,1720,0

'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1738,1721,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1487,1718,0

'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,384,179,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,541,179,0
		
		
		  'Flammenwerfer
		  'lev.Items.AddBonusItem(TBonusItem.Create(1297,1331,8000,5,"images/flamerLevel.png"))
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(1298,1438,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  lev.Items.AddBonusItem(TBonusItem.Create(1611,1720,8000,2,"images/powerlaserLevel.png"))

		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(1487,1718,8000,21,"images/booster_final.png"))


		  'PowerLaser
		  lev.Items.AddBonusItem(TBonusItem.Create(384,179,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(421,1638,8000,12,"images/powerlaser_muni.png"))

		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(541,179,8000,21,"images/booster_final.png"))

		  'Minen
		  'lev.Items.AddBonusItem(TBonusItem.Create(1683,338,8000,6,"images/MineLevel.png"))
		                                      
		  'Yellow Shield
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,209,8000,31,"images/schildi2.png"))
	
		  'Life Bonus 
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,409,8000,22,"images/lifebonus1.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,469,8000,22,"images/lifebonus1.png"))


      End Function         
	
	
	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(21,"Level 21: " + getlang("Zweikampf") + " 6",getlang("Fernkampf-Duell"),"Levels/Q1/Ausscheidung6.map",updateC1L21,initC1L21))










   
	'LEVEL 22 : Sicherung 4
	
	Function updateC1L22(lev:TLevel)
		'Pausenmenü-Aufenthalt in Zeit einrechnen
		If (MilliSecs() > lastcall + 1000) And (lastcall <> 0) Then
			lev.startzeit = lev.startzeit + MilliSecs() - lastcall
		End If
		lastcall = MilliSecs()						
	
		Local minuten:Int
		Local sekunden:Int
		Local seks:String
		Local z:Int = (MilliSecs()-lev.startzeit)/1000
		If (z = 40) And (lev.stand = 0) Then lev.stand = -1
	
		
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
				
					If gdifficulty = 0 Then
						If Count1 = 6 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 8 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 10 Then Exit
					End If
				
				
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
					
					If gdifficulty = 0 Then
						If Count1 = 7 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 9 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 10 Then Exit
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
						If Count1 = 9 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 10 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 12 Then Exit
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
						If Count1 = 10 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 12 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 14 Then Exit
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
						If Count1 = 12 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 14 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 16 Then Exit
					End If
					
					
				Next                            
				lev.stand = 5
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
						If Count1 = 12 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 15 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 17 Then Exit
					End If
					
					
				Next                            
				lev.stand = 6
			End If
		End If   				
		
		If lev.stand = 6 Then
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
						If Count1 = 14 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 15 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 18 Then Exit
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
			
			If alle = 0 Then
				Local count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					If sh.autospawn = 0 And sh.ai <> 98 Then
						sh.spawn			
						count1 = count1 + 1
					End If
					
					If gdifficulty = 0 Then
						If Count1 = 4 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 7 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 10 Then Exit
					End If
					
					
				Next                            
				lev.stand = 8
			End If
		End If   					
				
		
		If lev.stand = 8 Then
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
						If Count1 = 1 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 4 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 5 Then Exit
					End If
					
					
				Next                            
				lev.stand = 9
			End If
		End If   				
		
		
		
		If lev.stand = 9 Then
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
						If Count1 = 14 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 15 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 18 Then Exit
					End If
					
					
				Next                            
				lev.stand = 10
			End If
		End If   			
		
			
		If lev.stand = 10 Then
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
						If Count1 = 8 Then Exit
					End If
					
					
				Next                            
				lev.stand = 11
			End If
		End If   							
						
		
'		If lev.stand = 4 Then
'			Local sh:TShip
'			Local alle:Int=0
'			For sh:TShip = EachIn lev.Gegner.sh_list
'				If sh.dead = 0 And sh.autospawn = 0 and sh.ai <> 98 Then alle = alle + 1
'				'sh.spawn			
'			Next                            
'			
'			If alle = 0 Then
'				Local count1 = 0
'				For sh:TShip = EachIn lev.Gegner.sh_list
'					If sh.autospawn = 0 and sh.ai <> 98 Then
'						sh.spawn			
'						count1 = count1 + 1
'					End If
'					If count1 = 7 Then Exit
'				Next                            
'				lev.stand = 5
'			End If
'		End If   		
		
		
		If lev.stand = 11 Then          
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


	Function initC1L22(lev:TLevel)

	    'Gegner adden
		'											Function create:TShip(pname$,posx#,posy#,pteam,pai,pschiff:TGleiter, autoSpawn:Int)

    	'Raumstation mit Team 0, AI = 99
		lev.gegner.addShip(Tship.Create("Station1", 900, 173, 0, 99, gleitersammlung.getgleiterbyid(8),1))
		'lev.gegner.addShip(Tship.Create("Station1", 1248, 173, 0, 99, gleitersammlung.getgleiterbyid(8),1))

		lev.playerx = 900
		lev.playery = 600

		'Angreifende Kampfdrohnen
    	lev.gegner.addShip(Tship.Create("UFO2", 300, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 500, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 600, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 700, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 800, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 900, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1000, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1100, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1200, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1300, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1400, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1600, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1400, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1600, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))



		  'Bonusitems adden
	
	
		  'Towers
		  lev.Items.AddBonusItem(TBonusItem.Create(300,1451,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(350,1451,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(400,1451,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(450,1451,8000,81,"images/t1Level.png",aktuellerLevel))

		  lev.Items.AddBonusItem(TBonusItem.Create(500,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(550,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(600,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1451,8000,82,"images/t2Level.png",aktuellerLevel))

		  lev.Items.AddBonusItem(TBonusItem.Create(700,1451,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(750,1451,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(800,1451,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(850,1451,8000,81,"images/t1Level.png",aktuellerLevel))

		  lev.Items.AddBonusItem(TBonusItem.Create(900,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(950,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1000,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1050,1451,8000,82,"images/t2Level.png",aktuellerLevel))


'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,792,173,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1248,171,0

'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,246,1651,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,360,1649,0
		
	
		  'Minen
		  lev.Items.AddBonusItem(TBonusItem.Create(300,1551,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(350,1551,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(400,1551,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(450,1551,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(500,1551,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(550,1551,-1,6,"images/MineLevel.png"))
  		  lev.Items.AddBonusItem(TBonusItem.Create(600,1551,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1551,-1,6,"images/MineLevel.png"))

		  lev.Items.AddBonusItem(TBonusItem.Create(300,1551,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(350,1551,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(400,1551,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(450,1551,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(500,1551,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(550,1551,-1,6,"images/MineLevel.png"))
  		  lev.Items.AddBonusItem(TBonusItem.Create(600,1551,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1551,-1,6,"images/MineLevel.png"))

	
		  'Flammenwerfer
		  lev.Items.AddBonusItem(TBonusItem.Create(400,1651,15000,5,"images/flamerLevel.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(800,1400,15000,5,"images/flamerLevel.png"))

		  'Target Gun
		  'lev.Items.AddBonusItem(TBonusItem.Create(800,1300,15000,7,"images/rocketLevel.png"))
	
		  'Triple Laser
		  lev.Items.AddBonusItem(TBonusItem.Create(900, 500, 8000, 3, "images/tripleLevel.png"))
         
		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(500,1651,8000,20,"images/radar.png"))
		                             
		  'Red Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(600,1651,8000,31,"images/schildi2.png"))
	
	End Function


	gmChapter1.AddLevel(TLevel.Create(22,"Level 22: " + getlang("Sicherung") + " 4",getlang("Sturmtruppen"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L22,initC1L22))























	'LEVEL 23 : Kampfdrohnen 8
	Function updateC1L23(lev:TLevel)
		Local i:Int
		'lev.stand = 4
		If lev.stand = 0 Then
			Local sh:TShip
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				sh.spawn			
				Count1 = Count1 + 1
				If Count1 = 3 Then Exit
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
						If Count1 = 4 Then Exit
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
						If Count1 = 6 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 7 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 8 Then Exit
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
'			
'			If alle < 2 Then
'				'Local count1 = 0
'				For sh:TShip = EachIn lev.Gegner.sh_list
'					sh.spawn	'alle spawnen
'					'If count1 = 7 Then Exit
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


	Function initC1L23(lev:TLevel)

	  'Gegner adden
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	
	  'Bonusitems adden
		  'Flammenwerfer
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,300,8000,5,"images/flamerLevel.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(500,300,8000,5,"images/flamerLevel.png"))
		  
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,450,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  lev.Items.AddBonusItem(TBonusItem.Create(400,200,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,300,8000,12,"images/powerlaser_muni.png"))
		                                      
		  'Y-Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(400,300,8000,31,"images/schildi2.png"))
	
		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(400,400,8000,21,"images/booster_final.png"))

		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(400,500,8000,20,"images/radar.png"))
		  
		 'Triple Laser
		  lev.Items.AddBonusItem(TBonusItem.Create(400,600,8000,3,"images/tripleLevel.png"))

		  'Life Bonus
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,600,15000,22,"images/lifebonus1.png"))

		  'Bullet of Death
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,400,15000,8,"images/deathLevel.png"))

		  'Allrounder
		  lev.Items.AddBonusItem(TBonusItem.Create(400,700,15000,4,"images/allrounderLevel.png"))


		  'Target Gun
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,400,15000,7,"images/rocketLevel.png"))

	End Function

	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(23,"Level 23: " + getlang("Kampfdrohnen") + " 8",getlang("Target Drohnen"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L23,initc1l23))





	'LEVEL 24 : Zweikampf 7

	Function updateC1L24(lev:TLevel)
		
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
	
	
	
	

	Function initC1L24(lev:TLevel)

    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("Gegner", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(0)),1,"KI/Ausscheidungskampf1.lua"))
		lev.gegner.addShip(Tship.Create(getlang("Gegner"), 1708, 1706, 2,1, gleitersammlung.getgleiterbyid(5),1,"KI/Ausscheidungskampf7.lua"))
	

'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,247,150,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1708,1706,0

'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1236,278,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,340,1631,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,524,1627,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1592,791,0


		  'Triple Laser
		  lev.Items.AddBonusItem(TBonusItem.Create(1236,278,8000,3,"images/tripleLevel.png"))
		
		  'Flammenwerfer
		  'lev.Items.AddBonusItem(TBonusItem.Create(1297,1331,8000,5,"images/flamerLevel.png"))
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(1298,1438,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  'lev.Items.AddBonusItem(TBonusItem.Create(1592,791,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(421,1638,8000,12,"images/powerlaser_muni.png"))

		  'Minen
		  'lev.Items.AddBonusItem(TBonusItem.Create(1683,338,8000,6,"images/MineLevel.png"))
		                                      
		  'Yellow Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(524,1627,8000,31,"images/schildi2.png"))
	
		  'Life Bonus 
		  lev.Items.AddBonusItem(TBonusItem.Create(1592,791,8000,22,"images/lifebonus1.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,469,8000,22,"images/lifebonus1.png"))

		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(340,1631,8000,21,"images/booster_final.png"))

      End Function         
	
	
	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(24,"Level 24: " + getlang("Zweikampf") + " 7",getlang("Speedy Scout"),"Levels/Q1/Ausscheidung7.map",updateC1L24,initC1L24))








	'LEVEL 25 : Labyrinth 5
	
	Function updateC1L25(lev:TLevel)
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
			z = 85-z		
		Else If gdifficulty = 1 Then
			z = 75-z		
		Else If gdifficulty = 2 Then
			z = 65-z		
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
	
	
	
	
	Function initC1L25(lev:TLevel)

    	lev.gegner.addShip(Tship.Create("UFO2", 1400, 329, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1488, 328, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1576, 329, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1774, 234, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1400, 248, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/droneo1.lua"))

    	lev.gegner.addShip(Tship.Create("UFO2", 1406, 1542, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1496, 1543, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1684, 1617, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1684, 1617, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/droneo1.lua"))

    	lev.gegner.addShip(Tship.Create("UFO2", 194, 1746, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 394, 1570, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 194, 1670, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 294, 1670, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/droneo1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 394, 1670, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/droneo1.lua"))

		lev.playerx = 200
		lev.playery = 150

	'Bonusitems adden
		'Collection Items		
		  lev.Items.AddBonusItem(TBonusItem.Create(1400,329,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1488,328,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1576,329,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1679,329,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1781,330,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1774,234,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1667,229,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1571,233,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1480,240,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1400,248,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1400,147,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1500,151,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1598,149,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1687,148,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1788,145,-1,80,"images/colItem1.png"))

		  lev.Items.AddBonusItem(TBonusItem.Create(1406,1542,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1496,1543,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1582,1543,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1667,1542,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1764,1542,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1769,1617,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1684,1617,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1597,1616,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1507,1618,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1410,1619,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1774,1696,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1685,1693,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1601,1688,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1509,1696,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(1414,1700,-1,80,"images/colItem1.png"))

		  lev.Items.AddBonusItem(TBonusItem.Create(194,1746,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(289,1746,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(382,1749,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(475,1745,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(572,1749,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(193,1663,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(280,1662,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(375,1663,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(468,1662,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(569,1662,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(189,1570,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(276,1570,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(375,1577,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(467,1574,-1,80,"images/colItem1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(561,1575,-1,80,"images/colItem1.png"))


		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(500,150,8000,21, "images/booster_final.png"))

		  'Yellow Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(600,150,15000,31,"images/schildi2.png"))

		  'Minen
		  lev.Items.AddBonusItem(TBonusItem.Create(700,150,15000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(800,150,15000,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(900,150,15000,6,"images/MineLevel.png"))
				


	End Function	
	
	gmChapter1.AddLevel(TLevel.Create(25,"Level 25: " + getlang("Labyrinth") + " 5",getlang("Mausefalle"),"Levels/Q1/orientierung5.map",updateC1L25,initc1l25))
    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("UFO2", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(3)),1))















	'LEVEL 26 : Kampfdrohnen 9
	Function updateC1L26(lev:TLevel)
		Local i:Int
		'lev.stand = 4
		If lev.stand = 0 Then
			Local sh:TShip
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				sh.spawn			
				Count1 = Count1 + 1
					If gdifficulty = 0 Then
						If Count1 = 4 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 4 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 5 Then Exit
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
						If Count1 = 4 Then Exit
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
						If Count1 = 5 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 6 Then Exit
					End If
					
					
				Next                            
				lev.stand = 4
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
					
					sh.spawn
					count1 = count1 + 1
					If gdifficulty = 0 Then
						If Count1 = 6 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 7 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 9 Then Exit
					End If
				
				
					'sh.spawn	'alle spawnen
					'If count1 = 7 Then Exit
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


	Function initC1L26(lev:TLevel)

	  'Gegner adden
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	
	  'Bonusitems adden
		  'Flammenwerfer
		  lev.Items.AddBonusItem(TBonusItem.Create(400,200,8000,5,"images/flamerLevel.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(500,300,8000,5,"images/flamerLevel.png"))
		  
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,450,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  lev.Items.AddBonusItem(TBonusItem.Create(500,200,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,300,8000,12,"images/powerlaser_muni.png"))
		                                      
		  'Y-Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(400,300,8000,31,"images/schildi2.png"))
	
		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(500,300,8000,21,"images/booster_final.png"))

		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(400,400,8000,20,"images/radar.png"))
		  
		 'Triple Laser
		  lev.Items.AddBonusItem(TBonusItem.Create(500,400,8000,3,"images/tripleLevel.png"))

		  'Life Bonus
		  lev.Items.AddBonusItem(TBonusItem.Create(400,500,15000,22,"images/lifebonus1.png"))

		  'Bullet of Death
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,400,15000,8,"images/deathLevel.png"))

		  'Allrounder
		  lev.Items.AddBonusItem(TBonusItem.Create(500,500,15000,4,"images/allrounderLevel.png"))


		  'Target Gun
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,600,15000,7,"images/rocketLevel.png"))

	End Function

	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(26,"Level 26: " + getlang("Kampfdrohnen") + " 9",getlang("Zusammenkunft"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L26,initc1l26))














   
	'LEVEL 27 : Sicherung 5
	
	Function updateC1L27(lev:TLevel)
		'Pausenmenü-Aufenthalt in Zeit einrechnen
		If (MilliSecs() > lastcall + 1000) And (lastcall <> 0) Then
			lev.startzeit = lev.startzeit + MilliSecs() - lastcall
		End If
		lastcall = MilliSecs()						
	
		Local minuten:Int
		Local sekunden:Int
		Local seks:String
		Local z:Int = (MilliSecs()-lev.startzeit)/1000
		If (z = 40) And (lev.stand = 0) Then lev.stand = -1
	
		
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
				If Count1 = 6 Then Exit
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
					
					If gdifficulty = 0 Then
						If Count1 = 5 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 6 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 8 Then Exit
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
						If Count1 = 7 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 8 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 10 Then Exit
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
						If Count1 = 8 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 10 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 12 Then Exit
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
						If Count1 = 8 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 10 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 12 Then Exit
					End If
					
					
				Next                            
				lev.stand = 5
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
						If Count1 = 6 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 8 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 10 Then Exit
					End If
					
					
				Next                            
				lev.stand = 6
			End If
		End If   				
		

		If lev.stand = 6 Then
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
						If Count1 = 10 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 12 Then Exit
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
			
			If alle = 0 Then
				Local count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					If sh.autospawn = 0 And sh.ai <> 98 Then
						sh.spawn			
						count1 = count1 + 1
					End If
					
					If gdifficulty = 0 Then
						If Count1 = 14 Then Exit
					Else If gdifficulty = 1 Then
						If Count1 = 17 Then Exit
					Else If gdifficulty = 2 Then																	
						If Count1 = 19 Then Exit
					End If
					
					
				Next                            
				lev.stand = 8
			End If
		End If   							
		
		
		If lev.stand = 8 Then
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
					If count1 = 6 Then Exit
				Next                            
				lev.stand = 9
			End If
		End If   							
				
		
		
		If lev.stand = 9 Then          
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


	Function initC1L27(lev:TLevel)

	    'Gegner adden
		'											Function create:TShip(pname$,posx#,posy#,pteam,pai,pschiff:TGleiter, autoSpawn:Int)

    	'Raumstation mit Team 0, AI = 99
		lev.gegner.addShip(Tship.Create("Station1", 1000, 1000, 0, 99, gleitersammlung.getgleiterbyid(8),1))

		lev.playerx = 900
		lev.playery = 1000

		'Angreifende Kampfdrohnen
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1600, 350, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1000, 1700, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 800, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1600, 300, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1600, 400, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))


		  'Bonusitems adden
	
			  'Towers
		  lev.Items.AddBonusItem(TBonusItem.Create(300,1451,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(350,1451,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(400,1451,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(450,1451,8000,81,"images/t1Level.png",aktuellerLevel))

		  lev.Items.AddBonusItem(TBonusItem.Create(500,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(550,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(600,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1451,8000,82,"images/t2Level.png",aktuellerLevel))

		  lev.Items.AddBonusItem(TBonusItem.Create(700,1451,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(750,1451,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(800,1451,8000,81,"images/t1Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(850,1451,8000,81,"images/t1Level.png",aktuellerLevel))

		  lev.Items.AddBonusItem(TBonusItem.Create(900,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(950,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1000,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1050,1451,8000,82,"images/t2Level.png",aktuellerLevel))
	
		  lev.Items.AddBonusItem(TBonusItem.Create(1100,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1150,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1200,1451,8000,82,"images/t2Level.png",aktuellerLevel))
		  lev.Items.AddBonusItem(TBonusItem.Create(1250,1451,8000,82,"images/t2Level.png",aktuellerLevel))
	
	
		  'Minen
		  lev.Items.AddBonusItem(TBonusItem.Create(650,920,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1000,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1080,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1160,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1240,-1,6,"images/MineLevel.png"))

		  lev.Items.AddBonusItem(TBonusItem.Create(550,920,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(550,1000,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(550,1080,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(550,1160,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(550,1240,-1,6,"images/MineLevel.png"))

		  lev.Items.AddBonusItem(TBonusItem.Create(650,920,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1000,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1080,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1160,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(650,1240,-1,6,"images/MineLevel.png"))

		  lev.Items.AddBonusItem(TBonusItem.Create(550,920,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(550,1000,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(550,1080,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(550,1160,-1,6,"images/MineLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(550,1240,-1,6,"images/MineLevel.png"))

		  'Flammenwerfer
		  lev.Items.AddBonusItem(TBonusItem.Create(800,1600,15000,5,"images/flamerLevel.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(800,1400,15000,5,"images/flamerLevel.png"))

		  'Target Gun
		  'lev.Items.AddBonusItem(TBonusItem.Create(800,1300,15000,7,"images/rocketLevel.png"))
	
		  'Triple Laser
		  lev.Items.AddBonusItem(TBonusItem.Create(1000,1600,8000,3,"images/tripleLevel.png"))
         
		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(1100,800,8000,20,"images/radar.png"))
		                             
		  'Red Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(800,800,8000,31,"images/schildi2.png"))
	
		  'PowerLaser
		  lev.Items.AddBonusItem(TBonusItem.Create(900,1600,15000,2,"images/powerlaserLevel.png"))
			
	
	End Function


	gmChapter1.AddLevel(TLevel.Create(27,"Level 27: " + getlang("Sicherung") + " 5", getlang("Aus allen Richtungen"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L27,initC1L27))








	'LEVEL 28 : Zweikampf 8

	Function updateC1L28(lev:TLevel)
		
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
	

	Function initC1L28(lev:TLevel)

    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("Gegner", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(0)),1,"KI/Ausscheidungskampf1.lua"))
		lev.gegner.addShip(Tship.Create(getlang("Gegner"), 1611, 1720, 2,1, gleitersammlung.getgleiterbyid(2),1,"KI/Ausscheidungskampf8.lua"))
	

'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,242,180,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,384,179,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,541,179,0

'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1611,1720,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1738,1721,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1487,1718,0

		


		
		  'Flammenwerfer
		  lev.Items.AddBonusItem(TBonusItem.Create(1738,1721,8000,5,"images/flamerLevel.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(384,179,8000,5,"images/flamerLevel.png"))
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(1298,1438,8000,13,"images/flamer_muni.png"))

		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(1487,1718,8000,21,"images/booster_final.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(541,179,8000,21,"images/booster_final.png"))


		  'PowerLaser
		  'lev.Items.AddBonusItem(TBonusItem.Create(302,1637,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(421,1638,8000,12,"images/powerlaser_muni.png"))

		  'Minen
		  'lev.Items.AddBonusItem(TBonusItem.Create(1683,338,8000,6,"images/MineLevel.png"))
		                                      
		  'Yellow Shield
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,209,8000,31,"images/schildi2.png"))
	
		  'Life Bonus 
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,409,8000,22,"images/lifebonus1.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,469,8000,22,"images/lifebonus1.png"))

      End Function         
	
	
	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(28,"Level 28: " + getlang("Zweikampf") + " 8",getlang("Nahkampf-Duell"),"Levels/Q1/Ausscheidung8.map",updateC1L28,initC1L28))










	'LEVEL 29 : Kampfdrohnen 10
	Function updateC1L29(lev:TLevel)
		Local i:Int
		'lev.stand = 4
		If lev.stand = 0 Then
			Local sh:TShip
			Local Count1:Int=0
			For sh:TShip = EachIn lev.Gegner.sh_list
				sh.spawn			
				Count1 = Count1 + 1
				If Count1 = 5 Then Exit
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
					If Count1 = 8 Then Exit
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
					If Count1 = 8 Then Exit
				Next                            
				lev.stand = 4
			End If
		End If
		
		
		If lev.stand = 3 Then
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
					If Count1 = 8 Then Exit
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
				'Local count1 = 0
				For sh:TShip = EachIn lev.Gegner.sh_list
					sh.spawn	'alle spawnen
					'If count1 = 7 Then Exit
				Next                            
				lev.stand = 5
			End If
		End If   
		
		If lev.stand = 5 Then          
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


	Function initC1L29(lev:TLevel)

	  'Gegner adden
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1000, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 1700, 2,1, gleitersammlung.getgleiterbyid(6),0,"ki/drone1.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 400, 350, 2,1, gleitersammlung.getgleiterbyid(7),0,"ki/drone2.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 1700, 2,1, gleitersammlung.getgleiterbyid(9),0,"ki/drone3.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1700, 350, 2,1, gleitersammlung.getgleiterbyid(10),0,"ki/drone4.lua"))
    	lev.gegner.addShip(Tship.Create("UFO2", 1500, 1700, 2,1, gleitersammlung.getgleiterbyid(11),0,"ki/drone5.lua"))
    	
	  'Bonusitems adden
		  'Flammenwerfer
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,200,8000,5,"images/flamerLevel.png"))
		  'lev.Items.AddBonusItem(TBonusItem.Create(500,300,8000,5,"images/flamerLevel.png"))
		  
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,450,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  'lev.Items.AddBonusItem(TBonusItem.Create(500,200,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(500,300,8000,12,"images/powerlaser_muni.png"))
		                                      
		  'Y-Shield
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,300,8000,31,"images/schildi2.png"))
	
		  'Turbo-Booster
		  'lev.Items.AddBonusItem(TBonusItem.Create(500,300,8000,21,"images/booster_final.png"))

		  'Radar
		  lev.Items.AddBonusItem(TBonusItem.Create(400,200,8000,20,"images/radar.png"))
		  
		 'Triple Laser
		  'lev.Items.AddBonusItem(TBonusItem.Create(500,400,8000,3,"images/tripleLevel.png"))

		  'Life Bonus
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,500,15000,22,"images/lifebonus1.png"))

		  'Bullet of Death
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,400,15000,8,"images/deathLevel.png"))

		  'Allrounder
		  'lev.Items.AddBonusItem(TBonusItem.Create(500,500,15000,4,"images/allrounderLevel.png"))

		  'Ultragun
		  lev.Items.AddBonusItem(TBonusItem.Create(400,300,15000,9,"images/ultragun.png"))

		  'Minen
		  'lev.Items.AddBonusItem(TBonusItem.Create(1683,338,15000,6,"images/MineLevel.png"))


		  'Target Gun
		  'lev.Items.AddBonusItem(TBonusItem.Create(400,600,15000,7,"images/rocketLevel.png"))

	End Function

	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(29,"Level 29: " + getlang("Kampfdrohnen") + " 10",getlang("Schlachtfeld"),"Levels/Q1/Arena_Kampfdronen1.map",updateC1L29,initc1l29))











	'LEVEL 30 : Finalkampf

	Function updateC1L30(lev:TLevel)
		
		'TShip(lev.gegner.sh_list.first()).deathmatchfrags

		lev.drawLevelX = 300
		lev.drawlevelY = 50	
		lev.DrawLevel = TShip(lev.gegner.sh_list.Last()).name  + "  " + TShip(lev.gegner.sh_list.last()).deathmatchfrags + " : " + TShip(lev.gegner.sh_list.first()).deathmatchfrags + "  " + TShip(lev.gegner.sh_list.first()).name
		
		If TShip(lev.gegner.sh_list.last()).deathmatchfrags >= 5 Then
			levelrekord.setrekord(TShip(lev.gegner.sh_list.last()).deathmatchfrags - TShip(lev.gegner.sh_list.first()).deathmatchfrags, lev.id, 4)
		
			TShip(lev.gegner.sh_list.Last()).LevelEnde(1) 'gewonnen
			Return
		End If

		If KeyHit(key_m) Then
			'TShip(lev.gegner.sh_list.Last()).LevelEnde(1) 
			'Return
		End If
		

		If levelschluss = 0  Then
			If TShip(lev.gegner.sh_list.first()).deathmatchfrags >= 5 Then
				TShip(lev.gegner.sh_list.Last()).LevelEnde(0) 'verloren
				Return
			End If
		End If

	End Function
	

	Function initC1L30(lev:TLevel)

    'Gegner adden
    	'TLevel(gmChapter1.levels.Last()).gegner.addShip(Tship.Create("Gegner", 1000, 850, 2,1, TGleiter(gleiterSammlung.gleiters.ValueAtIndex(0)),1,"KI/Ausscheidungskampf1.lua"))
		lev.gegner.addShip(Tship.Create(getlang("Gegner"), 1611, 1720, 2,1, gleitersammlung.getgleiterbyid(12),1,"KI/Ausscheidungskampf9.lua"))
	


'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,242,180,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,384,179,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,541,179,0

'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1611,1720,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1738,1721,0
'/images/changerk.jpg,0,0,0,0,1,1,1,1,1,255,255,255,0,1487,1718,0
	
				
		
		
		  'Flammenwerfer
		  lev.Items.AddBonusItem(TBonusItem.Create(500,1000,8000,5,"images/flamerLevel.png"))
		  'Munition für Flammenwerfer
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(1298,1438,8000,13,"images/flamer_muni.png"))

		  'PowerLaser
		  lev.Items.AddBonusItem(TBonusItem.Create(602,1000,8000,2,"images/powerlaserLevel.png"))
		  'Munition für Powerlaser
		  'TLevel(gmChapter1.levels.Last()).Items.AddBonusItem(TBonusItem.Create(421,1638,8000,12,"images/powerlaser_muni.png"))

		  'Minen
		  lev.Items.AddBonusItem(TBonusItem.Create(700,1000,8000,6,"images/MineLevel.png"))
		                                      
		  'Yellow Shield
		  lev.Items.AddBonusItem(TBonusItem.Create(800,1000,8000,31,"images/schildi2.png"))
	
		  'Life Bonus 
		  'lev.Items.AddBonusItem(TBonusItem.Create(1682,409,8000,22,"images/lifebonus1.png"))
		  lev.Items.AddBonusItem(TBonusItem.Create(900,1000,8000,22,"images/lifebonus1.png"))

		  'Turbo-Booster
		  lev.Items.AddBonusItem(TBonusItem.Create(1000,1000,8000,21,"images/booster_final.png"))

		  'Triple Laser
		  lev.Items.AddBonusItem(TBonusItem.Create(1100,1000,15000,3,"images/tripleLevel.png"))

		  'Allrounder
		  lev.Items.AddBonusItem(TBonusItem.Create(1200,1000,15000,4,"images/allrounderLevel.png"))

		  'Target Gun
		  lev.Items.AddBonusItem(TBonusItem.Create(1300,1000,15000,7,"images/rocketLevel.png"))

		  'Bullet of Death
		  lev.Items.AddBonusItem(TBonusItem.Create(1400,1000,15000,8,"images/deathLevel.png"))

		  'Ultragun
		  'lev.Items.AddBonusItem(TBonusItem.Create(1500,1000,15000,9,"images/ultragun.png"))

      End Function         
	
	
	'gmChapter1.AddLevel(TLevel.Create("Level 6: Ausscheidungskampf","Besiege den Abgesandten der ...","Levels/Q1/Arena_Kampfdronen1.map",updateC1L6))
	gmChapter1.AddLevel(TLevel.Create(30,"Level 30: " + getlang("Finalkampf"),getlang("Besiege den Ultra Fighter"),"Levels/Q1/Ausscheidung9.map",updateC1L30,initC1L30))







