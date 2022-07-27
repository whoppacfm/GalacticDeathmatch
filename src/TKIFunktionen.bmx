	
	
	
	'KI-Funktionen-------------------- AktuellerGegner = Globale Variable - NPC an den Befehl erteilt wird
								'			(Workaround für LUA)



	

	Global KI_Variable[100]

	Function KI_GetVar:Int(ls:Byte Ptr)
		Try
			
			Local index:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
			
			If index >= 0 And index < 100 Then
				AktuellerGegner.LuaScr.ReturnNumberToLua(ls, KI_Variable[index])
			Else
				AktuellerGegner.LuaScr.ReturnNumberToLua(ls, 0)
			End If		
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetVar)")
		End Try
	End Function   


	Function KI_SetVar:Int(ls:Byte Ptr)
		Try
			
			Local index:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
			Local value:Int = AktuellerGegner.luascr.CheckNumber(ls,2)

			If index >= 0 And index < 100 Then
				KI_Variable[index] = value
			End If		
			'AktuellerGegner.LuaScr.ReturnNumberToLua(ls, KI_Variable[index])
			
			Return 0  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_SetVar)")
		End Try
	End Function   



	Function KI_StopGoing:Int(ls:Byte Ptr)
		Try
			aktuellergegner.geheweg = Null
			Return 0  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_StopGoing)")	
		End Try
	End Function     	






	Function KI_GOXY:Int(ls:Byte Ptr)
		Try
			
		'Len-1 und -2 gibts nicht, glaub ich
		'wenn ich runter fliege sagt er fehler

			If aktuellergegner.geheweg <> Null Then
				'If aktuellergegner.geheweg[Len(aktuellergegner.geheweg)-1].x = ax And aktuellergegner.geheweg[Len(aktuellergegner.geheweg)-1].y = ay Then
				
				'If aktuellergegner.geheweg[0].x = ax And aktuellergegner.geheweg[0].y = ay Then
					'---			
				'Else
				'	aktuellerGegner.GeheWeg = aktuellerLevel.getpath(TPosition.create(stx,sty), TPosition.create(ax,ay))
				'	aktuellerGegner.pnow = 0
				'End If
			Else
				Local ax:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
				Local ay:Int = AktuellerGegner.luascr.CheckNumber(ls,2)
			
				ax = round(ax/aktuellerLevel.feldsize)
				ay = round(ay/aktuellerLevel.feldsize)

				Local stx:Int = round(aktuellerGegner.x/aktuellerLevel.feldsize)
				Local sty:Int =	round(aktuellerGegner.y/aktuellerLevel.feldsize)

				aktuellerGegner.GeheWeg = aktuellerLevel.getpath(TPosition.create(stx,sty), TPosition.create(ax,ay))
				aktuellerGegner.pnow = 0
			End If
			
			'AktuellerGegner.LuaScr.ReturnNumberToLua(ls, back)
			Return 0  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GOXY)")	
		End Try
	End Function     	



	Function KI_GOENEMY:Int(ls:Byte Ptr)
		Try

		'Len-1 und -2 gibts nicht, glaub ich
		'wenn ich runter fliege sagt er fehler

			If aktuellergegner.geheweg <> Null Then
				'If aktuellergegner.geheweg[Len(aktuellergegner.geheweg)-1].x = ax And aktuellergegner.geheweg[Len(aktuellergegner.geheweg)-1].y = ay Then
				
				'If aktuellergegner.geheweg[0].x = ax And aktuellergegner.geheweg[0].y = ay Then
					'---			
				'Else
				'	aktuellerGegner.GeheWeg = aktuellerLevel.getpath(TPosition.create(stx,sty), TPosition.create(ax,ay))
				'	aktuellerGegner.pnow = 0
				'End If
			Else
				'Local ax:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
				'Local ay:Int = AktuellerGegner.luascr.CheckNumber(ls,2)
	
				If aktuellergegner.meinfeind <> Null Then
											
					Local ax:Int = round(aktuellerGegner.meinfeind.x/aktuellerLevel.feldsize)
					Local ay:Int = round(aktuellerGegner.meinfeind.y/aktuellerLevel.feldsize)

					Local stx:Int = round(aktuellerGegner.x/aktuellerLevel.feldsize)
					Local sty:Int =	round(aktuellerGegner.y/aktuellerLevel.feldsize)
					
					
					aktuellerGegner.GeheWeg = aktuellerLevel.getpath(TPosition.create(stx,sty), TPosition.create(ax,ay))
					aktuellerGegner.pnow = 0

				End If
			End If
				
			
			'AktuellerGegner.LuaScr.ReturnNumberToLua(ls, back)
			Return 0  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GOENEMY)")	
		End Try
	End Function     	




	Function KI_GoItem:Int(ls:Byte Ptr)
		Try
			
			If aktuellergegner.geheweg <> Null Then

				'If aktuellergegner.geheweg[Len(aktuellergegner.geheweg)-1].x = ax And aktuellergegner.geheweg[Len(aktuellergegner.geheweg)-1].y = ay Then
				
				'If aktuellergegner.geheweg[0].x = ax And aktuellergegner.geheweg[0].y = ay Then
					'---			
				'Else
				'	aktuellerGegner.GeheWeg = aktuellerLevel.getpath(TPosition.create(stx,sty), TPosition.create(ax,ay))
				'	aktuellerGegner.pnow = 0
				'End If
			Else
				Local wid:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
				Local bi:TBonusitem = aktuellerlevel.items.GetItem(wid)
			
				'Local stx:Int = round(aktuellerGegner.getx()/aktuellerLevel.feldsize)
				'Local sty:Int =	round(aktuellerGegner.gety()/aktuellerLevel.feldsize)				

				'Local ax:Int = round(bi.getx()/aktuellerLevel.feldsize)
				'Local ay:Int = round(bi.gety()/aktuellerLevel.feldsize)
				
				Local stx:Int = round(aktuellerGegner.x/aktuellerLevel.feldsize)
				Local sty:Int =	round(aktuellerGegner.y/aktuellerLevel.feldsize)				

				Local ax:Int = round(bi.x/aktuellerLevel.feldsize)
				Local ay:Int = round(bi.y/aktuellerLevel.feldsize)

				aktuellerGegner.GeheWeg = aktuellerLevel.getpath(TPosition.create(stx,sty), TPosition.create(ax,ay))
				aktuellerGegner.pnow = 0
			End If
			
			'AktuellerGegner.LuaScr.ReturnNumberToLua(ls, back)
			Return 0  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GoItem)")
		End Try
	End Function   




	Function KI_ItemInLevel:Int(ls:Byte Ptr)
		Try
			Local wID:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
			Local back:Int=0

			back = aktuellerlevel.items.itemExists(wid)
	
			'AktuellerGegner.LuaScr.ReturnNumberToLua(ls, back)
			AktuellerGegner.luascr.ReturnBooleanToLua(ls,back)			
			
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_ItemInLevel")	
		End Try
	End Function     



	Function KI_ItemVisible:Int(ls:Byte Ptr)
		Try
			Local wID:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
			Local back:Int=0

'			back = aktuellerlevel.items.itemExists(wid)
			back = aktuellerlevel.items.itemVisible(wid)
			
			'AktuellerGegner.LuaScr.ReturnNumberToLua(ls, back)
			AktuellerGegner.luascr.ReturnBooleanToLua(ls,back)			
			
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_ItemVisible")	
		End Try
	End Function     


	Function KI_RouteClearToWinkel:Int(ls:Byte Ptr)
		Try
			'Local wID:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
			
			Local winkel = aktuellergegner.luascr.checknumber(ls,1)
			
			Local back:Int=0

'			back = aktuellerlevel.items.itemExists(wid)
			back = aktuellergegner.routecleartowinkel(winkel)
			
			'AktuellerGegner.LuaScr.ReturnNumberToLua(ls, back)
			AktuellerGegner.luascr.ReturnBooleanToLua(ls,back)			
			
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_RouteClearToEnemy")	
		End Try
	End Function     
		
						
		
	Function KI_RouteClearToEnemy:Int(ls:Byte Ptr)
		Try
			'Local wID:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
			Local back:Int=0

'			back = aktuellerlevel.items.itemExists(wid)
			back = aktuellergegner.routecleartoenemy()
			
			'AktuellerGegner.LuaScr.ReturnNumberToLua(ls, back)
			AktuellerGegner.luascr.ReturnBooleanToLua(ls,back)			
			
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_RouteClearToEnemy")	
		End Try
	End Function     



	Function KI_SHOOT:Int(ls:Byte Ptr)
		Try
			AktuellerGegner.shoot()
			Return 0  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_SHOOT)")	
		End Try
	End Function


	Function KI_AddSpeed:Int(ls:Byte Ptr)
		Try
			If aktuellerGegner.geheweg = Null Then
				AktuellerGegner.AddSpeed(50)
			End If
			Return 0  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_AddSpeed)")	
		End Try
	End Function
		        

	Function KI_SubSpeed:Int(ls:Byte Ptr)
		Try
			If aktuellerGegner.geheweg = Null Then
				AktuellerGegner.SubSpeed(50)
			End If
			Return 0  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_SubSpeed)")	
		End Try
	End Function      


	Function KI_Stop:Int(ls:Byte Ptr)
		Try
			If aktuellerGegner.geheweg = Null Then
				AktuellerGegner.Speed = 0
			End If
			Return 0  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_Stop)")	
		End Try
	End Function      


	
			                    
	Function KI_GoRight:Int(ls:Byte Ptr)     
		Try
			If aktuellerGegner.geheweg = Null Then
				AktuellerGegner.mwinkel = AktuellerGegner.mwinkel + GameManager.FPS_Val(AktuellerGegner.gleiter.winkelSpeed)
				AktuellerGegner.Direction = 2
			End If
			Return 0  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GoRight)")	
		End Try
	End Function      

	                  
	Function KI_GoLeft:Int(ls:Byte Ptr)
		Try
			If aktuellerGegner.geheweg = Null Then
				AktuellerGegner.mwinkel = AktuellerGegner.mwinkel - GameManager.FPS_Val(AktuellerGegner.gleiter.winkelSpeed)
				AktuellerGegner.Direction = 1
			End If
			Return 0  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GoLeft)")	
		End Try
	End Function      
	



	
	
	
	
	
	
	'WERTE aus Spiel abfragen - Funktionen MIT RÜCKGABEWERT		    
	      
	
	Function KI_AStarOnline:Int(ls:Byte Ptr)
		Try
			Local wbool:Int=0
			If aktuellerGegner.geheweg = Null Then
				wbool = 0
			Else
				wbool = 1
			End If
			
			
			AktuellerGegner.LuaScr.ReturnBooleanToLua(ls, wbool)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_AStarOnline")	
		End Try
	End Function
	
	
	
	Function KI_GetWeaponRange:Int(ls:Byte Ptr)
		Try
	
			Local reichw:Int = TSchussart(schussarten.schuesse.ValueAtIndex(aktuellerGegner.waffe-1)).lifetime
			reichw = reichw - GameManager.FPS_Val(aktuellergegner.speed) - 100
			
'			aktuellerGegner.waffenArsenal[aktuellerGegner.waffe]			
			
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, reichw)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetWeaponRange")	
		End Try
	End Function      


	
	Function KI_GetX:Int(ls:Byte Ptr)
		Try
	
			'Local reichw:Int = TSchussart(schussarten.schuesse.ValueAtIndex(aktuellerGegner.waffe-1)).lifetime
			'reichw = reichw - GameManager.FPS_Val(aktuellergegner.speed) - 100
			
'			aktuellerGegner.waffenArsenal[aktuellerGegner.waffe]			
			
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, aktuellerGegner.x)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetX")	
		End Try
	End Function      

		
	Function KI_GetY:Int(ls:Byte Ptr)
		Try
	
			'Local reichw:Int = TSchussart(schussarten.schuesse.ValueAtIndex(aktuellerGegner.waffe-1)).lifetime
			'reichw = reichw - GameManager.FPS_Val(aktuellergegner.speed) - 100
			
'			aktuellerGegner.waffenArsenal[aktuellerGegner.waffe]			
			
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, aktuellerGegner.Y)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetY")	
		End Try
	End Function      

				
			    	
	Function KI_GetActualWeapon:Int(ls:Byte Ptr)
		Try
	
			'Local reichw:Int = TSchussart(schussarten.schuesse.ValueAtIndex(aktuellerGegner.waffe-1)).lifetime
			
'			aktuellerGegner.waffenArsenal[aktuellerGegner.waffe]			
			
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, aktuellerGegner.waffe)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetActualWeapon")	
		End Try
	End Function      
				
	
	
	Function KI_GetEnemyDif:Int(ls:Byte Ptr)
		Try
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, AktuellerGegner.weg)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetEnemyDif)")	
		End Try
	End Function      
	
	Function KI_GetGegnerX:Int(ls:Byte Ptr)
		Try
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, AktuellerGegner.tox)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetGegnerX)")	
		End Try
	End Function      
	
	Function KI_GetGegnerY:Int(ls:Byte Ptr)
		Try
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, AktuellerGegner.toy)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetGegnerY)")	
		End Try
	End Function      
	
	Function KI_GetGegnerWinkel:Int(ls:Byte Ptr)
		Try
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, AktuellerGegner.toWinkel)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetGegnerWinkel)")	
		End Try
	End Function      
   
	Function KI_GetWinkel:Int(ls:Byte Ptr)
		Try
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, AktuellerGegner.mwinkel)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetWinkel")	
		End Try
	End Function      
	
	Function KI_GetShieldEnergy:Int(ls:Byte Ptr)
		Try
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, AktuellerGegner.life)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetShieldEnergy")	
		End Try
	End Function      


	Function KI_GetBonusShieldEnergy:Int(ls:Byte Ptr)
		Try
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, aktuellergegner.schildEnergie)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetBonusShieldEnergy")	
		End Try
	End Function      



	Function KI_GetStandardShield:Int(ls:Byte Ptr)
		Try
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, AktuellerGegner.gleiter.life)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetStandardShield")	
		End Try
	End Function      



	Function KI_GetStandardBonusShield:Int(ls:Byte Ptr)
		Try
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, 50)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetStandardBonusShield")	
		End Try
	End Function      



	Function KI_GetEnemyShieldEnergy:Int(ls:Byte Ptr)
		Try
			If aktuellergegner.meinfeind <> Null Then
				AktuellerGegner.LuaScr.ReturnNumberToLua(ls, AktuellerGegner.meinfeind.life + aktuellergegner.meinfeind.schildenergie)
			Else
				AktuellerGegner.LuaScr.ReturnNumberToLua(ls,-1)
			End If
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetEnemyShieldEnergy)")	
		End Try
	End Function      


	Function KI_GetBoosterEnergy:Int(ls:Byte Ptr)
		Try
			'Local wID:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
			Local iteme:Int = 0
			
			'If wID = 21 Then
				iteme = aktuellerGegner.boosterEnergie
			'Else If wID = 2 Then
				'..
			'End If
	
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, iteme)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetBoosterEnergy")	
		End Try
	End Function      





	'Funktionen in denen LUA Parameter an Spiel übergibt

	Function KI_UseBooster:Int(ls:Byte Ptr)
		Try
			'Local wID:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
			Local back:Int=0
		
			'If wID = 21 Then ' Booster
				If aktuellerGegner.turbo() = 1 Then
					back = 1	
				Else
					back = 0
				End If
			'Else If wID = 2 Then
			  '..
			'End If
	
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, back)
			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_UseBooster)")	
		End Try
	End Function     	


	Function KI_SetWeapon:Int(ls:Byte Ptr)
		Try		
			Local wID:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
			'Local height:Int = AktuellerGegner.luascr.CheckNumber(ls,2) 
			'Local message:String = SEObject.CheckString(ls, 1)

			Local wBool:Int = 0

			If (wid < 0) Or (wid > 9) Then
				wbool = 0
			Else			
				If aktuellerGegner.waffenArsenal[wID] = 1 Then 
					wBool = 1
					aktuellergegner.waffe = wID
				End If
			End If

			'AktuellerGegner.luascr.ReturnNumberToLua(ls,wBool)
			
			AktuellerGegner.luascr.ReturnBooleanToLua(ls,wBool)
		
			Return 1
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_SetWeapon)")	
		End Try
	End Function
	

	
	Function KI_GetWeaponAmmo:Int(ls:Byte Ptr)
		Try
			Local wID:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
			AktuellerGegner.LuaScr.ReturnNumberToLua(ls, AktuellerGegner.waffenMun[wID])
			'AktuellerGegner.LuaScr.ReturnNumberToLua(ls, AktuellerGegner.waffenMun[aktuellerGegner.waffe])

			Return 1  'wieviele ergebnisse zurück zu lua ?
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_GetWeaponAmmo)")	
		End Try
	End Function      
	
	
	
		
	Function KI_HaveWeapon:Int(ls:Byte Ptr)
		Try		
			Local wID:Int = AktuellerGegner.luascr.CheckNumber(ls,1)
			'Local height:Int = AktuellerGegner.luascr.CheckNumber(ls,2) 
			'Local message:String = SEObject.CheckString(ls, 1)

			Local wBool:Int = 0
			If (wid < 0) Or (wid > 9) Then
				wbool = 0
			Else
				If aktuellerGegner.waffenArsenal[wID] = 1 Then wBool = 1
			End If

			'AktuellerGegner.luascr.ReturnNumberToLua(ls,wBool)
			
			AktuellerGegner.luascr.ReturnBooleanToLua(ls,wBool)
		
			Return 1
		Catch ex:Object
			RuntimeError(ex.ToString() + "KI_HaveWeapon)")	
		End Try
	End Function
	

	

	
	
	
	
	
	'-----------------------------------
	
