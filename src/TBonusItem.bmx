      
	
Type TBonusItems
	Field BonusItems:TList 'TBonusItem
	
	
	Function Create:TBonusItems()
		Local BItems:TBonusItems = New TBonusItems
		BItems.BonusItems = CreateList() 
		Return BItems
	End Function      
		
		
	Method AddBonusItem(item:TBonusItem)
		BonusItems.AddLast(item)
	End Method	                
	
	
	
	         
	
	Method getItem:TBonusitem(id:Int)
		Local back:TBonusItem=Null
		Local bi:TBonusItem
		For bi:TBonusitem = EachIn bonusitems
			If bi.itemart = id Then 
				back = bi
				Exit
			End If
		Next
		Return back
	End Method
	
	
	Method ItemExists(id:Int)
		Local back:Int = 0
		Local bi:TBonusItem
		For bi:TBonusitem = EachIn bonusitems
			If bi.itemart = id Then 
				back = 1
			End If
		Next
		Return back
	End Method


	Method ItemVisible(id:Int)
		Local back:Int = 0
		Local bi:TBonusItem
		For bi:TBonusitem = EachIn bonusitems
			If bi.itemart = id Then 
				If bi.show = 1 Then
					back = 1
					Exit
				End If
				Exit
			End If
		Next
		Return back
	End Method

		
	
	Method Update()
		Local item:TBonusItem
		For item:TBonusItem = EachIn BonusItems
			item.Update()		
		Next
	End Method
End Type		
	
	
	
Type TBonusItem
	Field x:Int
	Field Y:Int        
	Field lev:TLevel
	Field towership:TShip
	
	Field waffenTimer:Int = 0
	Field wRot:Int = 0
	
	Field spawnTime:Int '-1 = weg, taucht nicht mehr auf
	Field starttime:Int
	Field show:Int
	Field itemimage:TImage 
	Field itemImagePath:String
	Field GetItemSound:TSound

	Field ItemArt:Int 
	'0-9 = Waffen 0-9
	'10-19: Munition für Waffen 0-9
	
	'21=Booster
	
	'30=Red Shield
	'31=
	    
	'40=Energieitem +3 Standardschildenergie auch über max hinaus
	
	' 81 = Tower1
	' 82 = Tower2
	
	
	Function Create:TBonusItem(x:Int,Y:Int,spawnTime:Int,ItemArt:Int,iImagepath:String,lev:TLevel=Null)
		Local bi:TBonusItem=New TBonusItem
		bi.show = 1	         
		bi.starttime = -1	
		bi.itemImagePath = iimagepath
		'bi.spawnTime = spawnTime
		If spawntime = -1 Then 
			bi.spawnTime = spawnTime
		Else
			bi.spawnTime = 15000 'einheitlich
		End If

		If itemart = 20 Or itemart = 81 Or itemart = 82 Then 'Radar/Tower kommen nicht wieder
			bi.spawntime = -1
		End If

		bi.ItemArt = ItemArt
		bi.Init()   
		bi.x=x
		bi.Y=Y
		
		If lev <> Null Then
			bi.lev = lev
		End If
		
		
		If itemart = 81 Then 'Laserturm
			bi.towership = Tship.Create("Turm1", x, y, 0, 98, gleitersammlung.getgleiterbyid(14),0,"ki/tower.lua")
	    	bi.lev.gegner.addShip(bi.towership)
		Else If itemart = 82 Then 'Powerlaserturm
			bi.towership = Tship.Create("Turm2", x, y, 0, 98, gleitersammlung.getgleiterbyid(15),0,"ki/tower.lua")
	    	bi.lev.gegner.addShip(bi.towership)
		End If
		
		Return bi
	End Function
		
		

	Method Init()
		itemimage = LoadImage(itemImagePath,FILTEREDIMAGE)
		MidHandleImage(itemimage)		      	
		'getitemsound=
	End Method	                                           
	       
	
	Method GetX:Int()
		Return x-viewx
	End Method	                                           
	
	                  
	Method GetY:Int()
		Return Y-viewy
	End Method	                                           
		                                           
		
	Method GetX2:Int()
		Return x-viewx2
	End Method	                                           
	
	                  
	Method GetY2:Int()
		Return Y-viewy2
	End Method	                                           
		
		
		
	Method checkCollision() 'kollision mit gegnern
	Try
		Local sh:TShip
		For sh:TShip = EachIn aktuellerLevel.gegner.sh_list
			If sh<>Null Then
				If show = 1 Then
					
					If (sh.gleiter.gleiterid < 6) Or (sh.gleiter.gleiterid = 12)  Then 'Dronen dürfen keine Items aufnehmen
					
'					If (GetX() > sh.GetX()-sh.width/2 And (GetX() < sh.GetX()+sh.width/2) And (GetY() > sh.GetY()-sh.width/2) And (GetY() < sh.GetY()+sh.width/2)
'					If (GetX() > sh.GetX()-sh.width And (GetX() < sh.GetX()+sh.width) And (GetY() > sh.GetY()-sh.width/2) And (GetY() < sh.GetY()+sh.width/2)
					Local itemW:Int
					If itemimage.height > itemimage.width Then
						itemw = itemimage.height
					Else
						itemw = itemimage.width
					End If 
					
					'X-Kollision: links, rechts und mitte und drüber
					'If ((sh.getx() > getx()) And (sh.getx() < getx()+itemw)) Or ((sh.getx()+sh.width > getx()) And (sh.getx()+sh.width < getx()+itemw)) Or ((sh.getx() < getx()) And (sh.getx()+sh.width > getx()+itemw)) Or ( (sh.getX() > getX()) And (sh.getx()+sh.width < getx() + itemw)) Then
  					'If ((sh.gety() > gety()) And (sh.gety() < gety()+itemw)) Or ((sh.gety()+sh.width > gety()) And (sh.gety()+sh.width < gety()+itemw)) Or ((sh.gety() < gety()) And (sh.gety()+sh.width > gety()+itemw)) Or ( (sh.gety() > gety()) And (sh.gety()+sh.width < gety() + itemw)) Then

					If ((sh.x > x) And (sh.x < x+itemw)) Or ((sh.x+sh.width > x) And (sh.x+sh.width < x+itemw)) Or ((sh.x < x) And (sh.x+sh.width > x+itemw)) Or ( (sh.X > X) And (sh.x+sh.width < x + itemw)) Then
  					If ((sh.y > y) And (sh.y < y+itemw)) Or ((sh.y+sh.width > y) And (sh.y+sh.width < y+itemw)) Or ((sh.y < y) And (sh.y+sh.width > y+itemw)) Or ( (sh.y > y) And (sh.y+sh.width < y + itemw)) Then


						'if (x > sh.x-100) and (x < sh.x+100) and (y > sh.y-100) and (y < sh.y+100) And (sh.team <> nummer)					
						'explosions.AddExplosion (TExplosion.create(sh.x,sh.y))
						Local iview = sh.inViewport()
						If iview=1 Then
							'playeffect damage
						End If       
						
						Local genommen:Int = 1
						
						If (ItemArt >= 0) And (ItemArt <= 9) Then  'Waffen
							If sh.waffenArsenal[ItemArt] = 1 Then
								playeffect(sGetMun)
							Else
								playeffect(sGetGun)
							End If
							
							sh.waffe = ItemArt
						    sh.waffenArsenal[ItemArt] = 1
						    sh.waffenMun[ItemArt] = sh.waffenMun[ItemArt] + TSchussart(schussarten.schuesse.ValueAtIndex(ItemArt-1)).startmun
						End If
												
						
						If itemart = 81 Then 'Tower1
							'If sh.towers[0] = 1 Then
							'	genommen = 0
								'playeffect(sGetMun)
							'Else
								playeffect(sGetGun)
							'End If
							
							sh.towers[0] :+ 1
						End If
						
												
						If itemart = 82 Then 'Tower2
							'If sh.towers[1] = 1 Then
								'playeffect(sGetMun)
							'	genommen = 0
							'Else
							'	playeffect(sGetGun)
							'End If
							
							sh.towers[1] :+ 1
						End If
						
						    
						                                 
						If (ItemArt >= 10) And (ItemArt <= 19) Then  'Munition
							If sh.waffenArsenal[ItemArt-10] = 1 Then
								sh.waffenMun[ItemArt-10] = sh.waffenMun[ItemArt-10] + TSchussart(schussarten.schuesse.ValueAtIndex(ItemArt-10-1)).ItemMun
								playeffect(sGetMun)
							Else
								genommen = 0
							End If
						End If												     
						    
						
						If ItemArt = 20 Then 'Radar
							If aktuellerLevel.showRadar = 0 Then
								aktuellerLevel.showRadar = 1
								playeffect(sGetRadar)
							Else
								genommen = 0
							End If
						End If
						      
												
						
						If ItemArt = 21 Then 'Booster
							sh.boosterEnergie = 100
							playeffect(sGetBooster)
						End If
						

						If itemart = 22 Then 'lifebonus 50
							If sh.life < sh.gleiter.life Then
								sh.addLife(50) 
								playeffect(slifebonus)
							Else
								genommen = 0
							End If
						End If
						
						
						
						'If itemart = 23 Then 'lifebonus 100
						'	sh.addLife(100) 
						'	playeffect(slifebonus)
						'End If


						
						If (ItemArt >= 31) And (ItemArt <= 39) Then 'Schilde
							'nur wenn schildstufe < neues schild dann nehmen
							If sh.schildStufe < ItemArt-30 Then
								sh.schildStufe = ItemArt-30
								sh.schildEnergie = TSchild(schildersammlung.schildliste.ValueAtIndex(ItemArt-31)).energie
								sh.zusatzschild =  TSchild(schildersammlung.schildliste.ValueAtIndex(ItemArt-31)).Image
							Else If sh.schildStufe = ItemArt-30 Then
								If sh.schildEnergie < TSchild(schildersammlung.schildliste.ValueAtIndex(ItemArt-31)).energie Then
									sh.schildStufe = ItemArt-30
									sh.schildEnergie = TSchild(schildersammlung.schildliste.ValueAtIndex(ItemArt-31)).energie
									sh.zusatzschild =  TSchild(schildersammlung.schildliste.ValueAtIndex(ItemArt-31)).Image
								Else
									genommen = 0								
								End If
							Else
								genommen = 0
							End If     
							If genommen = 1 Then playeffect(sGetSchild)
						End If
						
						
						
						If itemart = 80 Then 'Collection Item
							genommen = 1
							playeffect(GetColItem)
							
						End If           
						
						
						If genommen = 1 Then
							starttime = MilliSecs()
							show=0
						End If

					   
					End If
					End If
					End If
				End If
			End If
		Next
	Catch ex:Object
		RuntimeError(ex.ToString() + " TBonusItem-checkCollision)")	
	End Try
	End Method
	
	
	
	Method Update()   
		resetgfx()
		If show = 0 
		    If MilliSecs() > starttime+spawnTime
		    	If spawntime > 0 Then
					show = 1
			    	starttime = -1   
				End If
		    End If
		Else If show = 1
			checkCollision()
			resetGFX()
			If ((ItemArt >=0) And (ItemArt <= 19)) Or (itemart = 81) Or (itemart = 82) Or (itemart=20) Or (itemart=21) Or (itemart=22) Or (itemart=23) Then
				If waffenTimer = 0 Then 
					waffenTimer = MilliSecs()
				Else
					If MilliSecs() > waffenTimer + 5 Then
						wRot = wRot + 1
						waffenTimer=0
					End If
				End If         
				SetBlend ALPHABLEND
				SetRotation wRot
			Else                   
				SetBlend LIGHTBLEND
				SetRotation MilliSecs()
			End If
			SetAlpha 1
			
			
			If splitscreen = 0 Then
				DrawImage itemimage,GetX(),GetY()
			Else
							SetViewport 0,0,GraphicsWidth()/2,GraphicsHeight()												

				DrawImage itemimage,GetX(),GetY()
				SetViewport GraphicsWidth()/2, 0, GraphicsWidth(), GraphicsHeight()								

				DrawImage itemimage,GetX2(),GetY2()
				SetViewport 0,0, GraphicsWidth(), GraphicsHeight()				
			End If
			
		End If
	End Method
	
End Type






