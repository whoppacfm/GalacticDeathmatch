

Type TGFXOptions     
	Field gw:Int
	Field gh:Int
	Field gc:Int
	Field treiber:String 'opengl oder directx
	
	Field ogw:Int
	Field ogh:Int
	Field ogc:Int
	Field otreiber:String 'opengl oder directx
	

	Method Load()
		Try
			Local file:TStream = ReadFile("config.ini")
			If Not file Throw "could not open file " + "config.ini"
			While Not Eof(file)
				Local feld$ = ReadLine(file)
				If feld.Trim() = "" Then Continue 
				Local index% = feld.find("=")
				Local value1$ = feld[index+1..]
				feld = feld[..index]
				If value1 = "opengl" Then
					treiber = "opengl"     
				Else
					treiber = "directx"
				End If
				If feld.Trim() = "x" Then
					gw = Int(value1.Trim())
				End If
				If feld.Trim() = "y" Then
					gh = Int(value1.Trim())
				End If
				If feld.Trim() = "bit" Then
					gc = Int(value1.Trim())		
				End If
			Wend	
			CloseFile file
		Catch ex:Object
			RuntimeError(ex.ToString() + " TGFXOptions-load()")	
		End Try
		
	End Method
	                
	

	Method Save()     
		Try
			Local namef:String = "config.ini"
			Local file:TStream = OpenFile(namef)
			Local found
			If Not file Then
				Throw "could not open file " + namef
				'CreateFile filename'
				'file:TStream = OpenFile(namef)
			End If
	
			Local tempcfg:TList = New TList
	
			While Not Eof(file)
				Local tempstring:String = ReadLine$(file)
				Local temp:String
				If tempstring.Trim() <> "" Then
					Local index% = tempstring.find("=")
					temp = tempstring[..index]
					temp = Trim(temp)
					
					If temp.tolower() = "driver"
						Local newstring:String = "driver" + "=" + treiber
						tempcfg.AddLast newstring
					Else If temp.tolower() = "x"
						Local newstring:String = "x" + "=" + gw
						tempcfg.AddLast newstring
					Else If temp.tolower() = "y"
						Local newstring:String = "y" + "=" + gh
						tempcfg.AddLast newstring
					Else If temp.tolower() = "bit"
						Local newstring:String = "bit" + "=" + gc
						tempcfg.AddLast newstring
					EndIf
				End If
			Wend
				
			CloseFile (file)
			DeleteFile (namef)
			CreateFile (namef)
			file = OpenFile (namef)
			For Local t$ = EachIn tempcfg
				WriteLine ( file, t )
			Next
	
			'If found = False
			'	WriteString (file, Key + "=" + Value)
			'EndIf
			CloseFile (file)
		Catch ex:Object
			RuntimeError(ex.ToString() + " TGFXOptions-save()")	
		End Try
	
	End Method

	
	Method getScaleFactor:Float()    
		Local scaleFactor:Float
		If gw = 800 Then scaleFactor = 0.78125 Else scaleFactor = 1
		Return scalefactor
	End Method
	                  
	Method scale:Float(Value:Float)
		Local scaleFactor:Float
		If gw = 800 Then scaleFactor = 0.78125 Else scaleFactor = 1
		Return Value * scalefactor		
	End Method	                       
	
	
	
	Method setValues(aDriver:String,agw, agh, agc)

		'prüfen ob dieser mode unterstützt wird, wenn nicht Meldung
		'showmessage("") -> Meldungsfenster im Menü - alle anderen menüeingaben werden nicht verarbeitet
		
		EndGraphics()
		If aDriver = "opengl" Then
			SetGraphicsDriver GLMax2DDriver()
		Else
			'SetGraphicsDriver GLMax2DDriver()

			SetGraphicsDriver D3D7Max2DDriver()
			'SetGraphicsDriver BufferedD3D7Max2DDriver()
		End If

		Local counter:Int = CountGraphicsModes()
		Local okg:Int=0

		Local i
		
		
		For i = 0 To counter - 1
			Local w
			Local h
			Local d
			Local hertz
			GetGraphicsMode(i,w,h,d,hertz)
				
			If (w = agw) And (h = agh) And (d = agc) Then
				okg=1
				Exit				
			End If
		Next				
		
		
		If okg=1 Then						
														
			otreiber = treiber
			ogw = gw
			ogh = gh
			ogc = gc
		
			treiber = adriver
			gw = agw
			gh = agh
			gc = agc
			
			Graphics gw,gh,gc,60
			SetViewport 0,0,gw,gh
			HideMouse()
			gfxOptions.Save()     
		Else
			init()
			TMenustate(gamemanager._state).agw = gw
			TMenustate(gamemanager._state).agh = gh
			TMenustate(gamemanager._state).agc = gc
			TMenustate(gamemanager._state).aDriver = treiber                           
			TMenustate(gamemanager._state).showmessage(getlang("Graphikmodus wird nicht unterstuetzt."))	
		End If

	End Method
	
	
	
	Method Init:Int()
		EndGraphics()  
		
		If treiber = "opengl" Then
			SetGraphicsDriver GLMax2DDriver()
		Else
			'SetGraphicsDriver GLMax2DDriver()

			SetGraphicsDriver D3D7Max2DDriver()
			'SetGraphicsDriver BufferedD3D7Max2DDriver()
		End If
		
		Graphics gw,gh,gc,60 'NOSYNC '60
		'Graphics gw,gh,0,60 ',0 'NOSYNC '60

		SetViewport 0,0,gw,gh
		HideMouse()
	End Method
	
End Type