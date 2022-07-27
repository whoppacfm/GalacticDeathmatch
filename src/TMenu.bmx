
Type TMenu
	Field MenuItems:TList
	Field ItemDown:Int = -1
	Field overID:Int = -1
	Field AktuellesPointItem:Int=0        
	
	Method CheckItemDown:Int()
		Local itemid = ItemDown
		ItemDown=-1
		Return itemid
	End Method
	
		            
	Method getItemOver:Int()
		Return overID		
	End Method
		
		 
	Method ClearMenuItems()
		MenuItems.Clear()
	End Method
		
	Function Create:TMenu()
		Local Menu:TMenu = New TMenu
		Menu.MenuItems = New TList
		Return Menu
	End Function
	
	Method AddMenuItem(menuItem:TMenuItem)
		MenuItems.AddLast(menuItem)
	End Method                
		
	
	Method setMiddle()    
		'SetImageFont superfont
		Local biggestLength:Int = 0
		For Local mu:TMenuItem = EachIn MenuItems  
			If TextWidth(mu.Caption) > biggestLength Then biggestLength = TextWidth(mu.Caption)
		Next          
		For Local mu:TMenuItem = EachIn MenuItems  
			Local diff:Int = biggestLength - TextWidth(mu.Caption)
			If diff > 0 Then
				mu.x = mu.x + diff/2
			End If
		Next          
	End Method


	Method setMiddleX()    
		'SetImageFont superfont
		'SetImageFont superfont
		'Local biggestLength:Int = 0
		'For Local mu:TMenuItem = EachIn MenuItems  
		'	If TextWidth(mu.Caption) > biggestLength Then biggestLength = TextWidth(mu.Caption)
		'Next          
		For Local mu:TMenuItem = EachIn MenuItems  
			Local diff:Int = GraphicsWidth() - TextWidth(mu.Caption)
			If diff > 0 Then
				mu.x = diff/2        
				If gfxoptions.getscalefactor() <> 1 Then
					mu.x = mu.x + (mu.x - Float((gfxoptions.scale(mu.x)/1.08)))
				End If
			End If
		Next          
	End Method



	Method setpointitem(id1:Int)
		For Local mu:TMenuItem = EachIn MenuItems
			mu.PointItemAktuell=0
			If mu.id = id1 Then 
				mu.PointItemAktuell = 1
				AktuellesPointItem = id1
			End If
		Next          
	End Method
	            
	Method GetPointItem:Int()
		Return AktuellesPointItem
	End Method
	          
	
	
	Method update()
		overid = -1

		For Local mu:TMenuItem = EachIn MenuItems
			
			mu.update() 
			If mu.pointitem = -1 Then Continue
						
			If mu.isover=1 Then overid = mu.id
			
			If mu.imousedown = 1 Then
				If mu.PointItem=1 Then
					AktuellesPointItem=mu.id
				Else
					ItemDown = mu.id
				End If   
				mu.imousedown = 0
			End If    
			If mu.id <> AktuellesPointItem Then mu.PointItemAktuell = 0
		Next          
		If MouseHit(1) Then FlushKeys()
	End Method
End Type

                   





Type TMenuItem
	Field id:Int  
	Field ImageItem:Int '0 oder 1
	Field Caption:String   
	Field x:Int
	Field Y:Int
	Field alphaVal:Float
	Field blend:Int
	Field scaleVal:Float		                            
	Field font:TImageFont
	Field R,G,B:Int    
	Field aktiv:Int
	
	Field inormal:TImage
	Field iover:TImage
	
	Field PointItem:Int 'gehört zu einer Auswahlgruppe aus der ein Item ausgewählt werden kann und mit einem Rahmen umzogen wird
	Field PointItemAktuell:Int

	Field isOver:Int = 0 '0=nein, 1=ja
	Field animFrame:Int = 0
	Field animTime:Int = 0
	
	Field imousedown:Int=0
	                       
	
	'Image Item
	Function icreate:TMenuItem(Caption:String,x,Y:Int,id:Int,PointItem:Int=0,inormal:TImage,iover:TImage)
		Local item:TMenuItem = New TMenuItem
		item.ImageItem = 1
		
		item.inormal = inormal
		item.iover = iover
		
		item.Caption = Caption
		item.x = x
		item.Y = Y
		item.alphaVal = 0.7
		item.blend = alphablend
		item.scaleVal = 0.7
		'item.font = font
		item.R = 255
		item.G = 255
		item.B = 255
		item.id = id    
		item.PointItem=PointItem 
		item.aktiv = 1
		Return item
	End Function       
	
	
	'Text Item
	Function Create:TMenuItem(Caption:String,x,Y:Int,alphaVal:Float,blend:Int,scaleVal:Float,font:TImageFont,R,G,B:Int,id:Int,PointItem:Int=0)
		Local item:TMenuItem = New TMenuItem
		item.ImageItem = 0
		item.Caption = Caption
		item.x = x
		item.Y = Y
		item.alphaVal = alphaVal
		item.blend = blend
		item.scaleVal = scaleVal
		
		If font = superfont Then
			If gfxoptions.getscalefactor() = 1 Then
				item.font = font
			Else
				item.font = font
				'item.font = superfont8
			End If
		Else
			item.font = font
		End If
		
		item.R = R
		item.G = G
		item.B = B
		item.id = id    
		item.PointItem=PointItem 
		item.aktiv = 1
		
		Return item
	End Function
	
	
	Method getWidth:Int() 'für Monospaced Fonts
		If ImageItem = 0 Then
			Local lang:Int = Caption.length
			SetImageFont font
			Return TextWidth(caption)
			'Return lang*17'(lang * (font.Height()/2.5)) 
		Else
			Return inormal.width*scaleVal
		End If
	End Method
	
		
	Method checkMouseOver:Int(ox,oy:Int)
		If ImageItem = 0 Then
			If (ox >= gfxOptions.scale(x)) And (ox <= gfxOptions.scale(x)+getWidth()) And (oy >= gfxOptions.scale(Y)) And (oy <= gfxOptions.scale(Y)+font.Height()) Then
				Return 1
			Else
				Return 0
			End If
		Else
			If (ox >= gfxOptions.scale(x)) And (ox <= gfxOptions.scale(x)+getWidth()) And (oy >= gfxOptions.scale(Y)) And (oy <= gfxOptions.scale(Y)+inormal.Height*scaleVal) Then
				Return 1
			Else
				Return 0
			End If
		End If
	End Method
		
	
	Method Update()
		If aktiv = 1 Then
			SetImageFont font
			SetBlend blend
			SetAlpha alphaVal
			SetScale scaleVal,scaleVal
			SetColor R,G,B
			Local cap:String = caption
		
			If PointItemAktuell=1 Then 
				SetColor 255,0,0
'				cap = "[ " + cap + " ]"
			End If
		
			If pointitem = -1 Then ' POINTITEM = -1 -> nur TEXT ohne Funktionalität
				If ImageItem = 0 Then
					DrawText cap,gfxOptions.scale(x),gfxOptions.scale(Y)		 			
				Else
					DrawImage inormal,gfxOptions.scale(x),gfxOptions.scale(Y)	
				End If
	
			Else
		
				If checkMouseOver(MouseX(),MouseY()) Then
					If ImageItem = 0 Then
						SetScale scaleVal, scaleVal+0.3
						DrawText cap,gfxOptions.scale(x),gfxOptions.scale(Y)	
					Else
						DrawImage iover,gfxOptions.scale(x),gfxOptions.scale(Y)	
					End If
									
					If isOver=0 Then 
						playeffect mover
						isOver=1
					End If
					If MouseHit(1) Then 
						imousedown = 1
						If PointItem=1 Then PointItemAktuell=1	
						playeffect mdown
					End If
				Else
					isOver=0
					If ImageItem = 0 Then
						DrawText cap,gfxOptions.scale(x),gfxOptions.scale(Y)		 			
					Else
						DrawImage inormal,gfxOptions.scale(x),gfxOptions.scale(Y)	
					End If
				End If	
			End If	 
		End if       
	End Method 
End Type

