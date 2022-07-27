

Public
Global muckeVolume:Float
Global effectVolume:Float  

Const configFile:String="config.ini"


Function LoadSoundSettings()
	Try
		muckeVolume = Float(ini_GetValue(configFile,"mfx","0.8"))
		effectVolume = Float(ini_GetValue(configFile,"sfx","0.8"))
	Catch ex:Object
		RuntimeError(ex.ToString() + " TSoundManager-loadsoundsettings()")	
	End Try
End Function
	           
	

Function SaveSoundSettings()     
	Try
		ini_SetValue(configFile,"mfx",muckeVolume)	
		ini_SetValue(configFile,"sfx",effectVolume)			
	Catch ex:Object
		RuntimeError(ex.ToString() + " TSoundMaanger-saveSoundSettings()")	
	End Try
End Function





Function PlayEffect:TChannel(effect:TSound)
	Try
		Local channel:TChannel = CueSound(effect)
		If effectVolume > 1 Then effectVolume = 1
		If effectVolume < 0 Then effectVolume = 0
		Local evol:Float = effectvolume - 0.1
		If evol < 0 Then evol = 0
		If channel <> Null Then
			SetChannelVolume(channel,evol)
			ResumeChannel channel 
		End If      
		Return channel
	Catch ex:Object
		RuntimeError(ex.ToString() + " Main.bmx-PlayEffect")	
	End Try
End Function
                

Global muckeChannel:TChannel 


Function PlayMucke(mucke:TSound)
	Try
		'Local channel = CueSound(mucke)
		If muckeChannel <> Null Then muckeChannel.Stop
		muckeChannel = CueSound(mucke)
		If muckeVolume > 1 Then muckeVolume = 1
		If muckeVolume < 0 Then muckeVolume = 0
		If muckeChannel <> Null Then
			Local evol:Float = muckeVolume- 0.1
			If evol < 0 Then evol = 0
		
			SetChannelVolume(muckeChannel,evol)
			ResumeChannel muckeChannel 
		End If
	Catch ex:Object
		RuntimeError(ex.ToString() + " Main.bmx-PlayMucke")	
	End Try
End Function





Type TVolumeChanger
	Field vx:Int
	Field vy:Int
	Field currentStep:Float=0
	Field changer:TImage
	Field changerk:TImage
	Field art:Int
	
	Function Create:TVolumeChanger(vx,vy,art:Int)
		Try
			Local changer:TVolumeChanger = New TVolumeChanger
			changer.vx = vx    
			changer.vy = vy
			changer.art = art 
			changer.changer:TImage = LoadImage("images/changer.jpg")
			changer.changerk:TImage = LoadImage("images/changerk.jpg")
			Return changer
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TVolumeChanger-create")	
		End Try
	End Function
	
	
	Method SetStep(Value:Int)
		Try
			currentStep = Value
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TVolumeChanger-setStep")	
		End Try
	End Method

	
	Method show()
		Try        
			Select art
				Case 0 currentStep=effectVolume*10
				Case 1 currentStep=muckeVolume*10
			End Select

			If (MouseX() > gfxOptions.scale(vx)) And (MouseX() < gfxOptions.scale(vx) + 550*gfxOptions.getscaleFactor()) And (MouseY() > gfxOptions.scale(vy)) And (MouseY() < gfxOptions.scale(vy)+50*gfxOptions.getscaleFactor()) Then
				If MouseDown(1) Then
					currentStep = (MouseX()-gfxOptions.scale(vx))/(50*gfxOptions.getscaleFactor())
					
					If art = 0 Then
						effectVolume = Float(currentStep/10)
						PlayEffect mover					
					Else If art = 1 Then
						Local evol:Float = muckeVolume- 0.1
						If evol < 0 Then evol = 0					
						muckeVolume = Float(currentStep/10)
						If muckechannel<>Null Then 
							SetChannelVolume(muckeChannel,evol)';ResumeChannel muckeChannel						
						End If
					End If
						
					'FlushKeys()				
				End If
			End If
					
			resetGFX()
			'setcolor 0,0,255
			SetAlpha 0.7
			SetBlend LIGHTBLEND
			SetScale gfxOptions.getscaleFactor(),gfxOptions.getscaleFactor()
			DrawImage changer,gfxOptions.scale(vx),gfxOptions.scale(vy)
				 		
			Local i:Int
			Local sx=0

			For	i = 0 To currentStep-1
				SetScale gfxOptions.getscaleFactor(),gfxOptions.getscaleFactor()
				DrawImage changerk,gfxOptions.scale(vx)+sx,gfxOptions.scale(vy)
				sx = sx + 50*gfxOptions.getscaleFactor()
			Next 	
		Catch ex:Object
			RuntimeError(ex.ToString() + " Main.bmx-TVolumeChanger-show")	
		End Try
	End Method
	
End Type
