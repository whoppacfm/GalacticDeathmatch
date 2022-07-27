
'Strict              
Import "HighGUI.bmx"

AppTitle$ = "Partikel Editor - Christian Merz 2005"

Type gamem
	Function fps_val(a:Int)
		Return 1
	End Function
End Type


Global gamemanager:gamem = New gamem






Include "TInifiles.bmx"
Include "TPartikel.bmx"


Graphics 640, 480, 0, 0
SetMaskColor(255, 0, 255)
HideMouse()
HiLoadGUI("GUI Gfx\Themes\xp")

'Font
Global kGUIFont:TImageFont = LoadImageFont("ARIALN.TTF", 14)
SetBlend ALPHABLEND
SetImageFont kGUIFont

'Fenster
'Global kMyWindow:HiWindow = HiCreateWindow("Partikeleditor 1.0    -     Christian Merz", 0, 0, GraphicsWidth(), GraphicsHeight(), True, False, True, True, False, HIWINDOWFRAMESTYLE_NONE)
'Global kMyWindow:HiWindow = HiCreateWindow("Particle Edit 1.0", 754, 0, 270, 768,true,true,true,false,false,HIWINDOWFRAMESTYLE_NONE)

'original
'Global kMyWindow:HiWindow = HiCreateWindow("Particle Edit 0.1", 754, 0, 270, 768)
Global kMyWindow:HiWindow = HiCreateWindow("Particle Edit 0.1", 360, -280, 270, 768)

'HiCreateWindow 


'Komponenten
Rem 
Global kMyCombobox:HiCombobox = HiCreateCombobox(kMyWindow, 250, 60, 200)
local icount:Int
For iCount = 1 To 30
	kMyCombobox.HiAddItem("This is list item number " + iCount)
Next
end rem 


Local TextLeft:Int = 100

Global kImageLabel:HiLabel = HiCreateLabel(kMyWindow, "Image", 10, 10, 130, 22, False, False)
Global kImage:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 10, 150, 20, False, False)

Global kupdateIntervalLabel:HiLabel = HiCreateLabel(kMyWindow, "Update-Interval", 10, 40, 130, 22, False, False)
Global kupdateInterval:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 40, 150, 20, False, False)

Global kalphaLabel:HiLabel = HiCreateLabel(kMyWindow, "Alpha", 10, 70, 130, 22, False, False)
Global kalpha:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 70, 150, 20, False, False)

Global kalphaDeltaLabel:HiLabel = HiCreateLabel(kMyWindow, "Alpha-Delta", 10, 100, 130, 22, False, False)
Global kalphaDelta:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 100, 150, 20, False, False)

Global kBlendLabel:HiLabel = HiCreateLabel(kMyWindow, "Blending", 10, 130, 130, 22, False, False)
Global kBlend:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 130, 150, 20, False, False)

Global kscaleLabel:HiLabel = HiCreateLabel(kMyWindow, "Scale", 10, 160, 130, 22, False, False)
Global kscale:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 160, 150, 20, False, False)

Global kscaleDeltaLabel:HiLabel = HiCreateLabel(kMyWindow, "Scale-Delta", 10, 190, 130, 22, False, False)
Global kscaleDelta:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 190, 150, 20, False, False)

Global krotLabel:HiLabel = HiCreateLabel(kMyWindow, "Red", 10, 220, 130, 22, False, False)
Global krot:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 220, 150, 20, False, False)

Global kgrunLabel:HiLabel = HiCreateLabel(kMyWindow, "Green", 10, 250, 130, 22, False, False)
Global kgrun:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 250, 150, 20, False, False)

Global kblauLabel:HiLabel = HiCreateLabel(kMyWindow, "Blue", 10, 280, 130, 22, False, False)
Global kblau:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 280, 150, 20, False, False)

Global kEmitIntervalLabel:HiLabel = HiCreateLabel(kMyWindow, "Emit-Interval", 10, 310, 130, 22, False, False)
Global kEmitInterval:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 310, 150, 20, False, False)

Global kparticleVelLabel:HiLabel = HiCreateLabel(kMyWindow, "Particle-Velocity", 10, 340, 130, 22, False, False)
Global kparticleVel:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 340, 150, 20, False, False)

Global kcreatePoolLabel:HiLabel = HiCreateLabel(kMyWindow, "Pool-Size", 10, 370, 130, 22, False, False)
Global kcreatePool:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 370, 150, 20, False, False)

Global kemitCountLabel:HiLabel = HiCreateLabel(kMyWindow, "Emit-Count", 10, 400, 130, 22, False, False)
Global kemitCount:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 400, 150, 20, False, False)

Global klifetimeLabel:HiLabel = HiCreateLabel(kMyWindow, "Lifetime", 10, 430, 130, 22, False, False)
Global klifetime:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 430, 150, 20, False, False)

Global kstartangleLabel:HiLabel = HiCreateLabel(kMyWindow, "Start-Angle", 10, 460, 130, 22, False, False)
Global kstartangle:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 460, 150, 20, False, False)

Global kendangleLabel:HiLabel = HiCreateLabel(kMyWindow, "End-Angle", 10, 490, 130, 22, False, False)
Global kendangle:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 490, 150, 20, False, False)

Global kcurrangleeLabel:HiLabel = HiCreateLabel(kMyWindow, "Current-Angle", 10, 520, 130, 22, False, False)
Global kcurrangle:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 520, 150, 20, False, False)

Global kangleDeltaLabel:HiLabel = HiCreateLabel(kMyWindow, "Angle-Delta", 10, 550, 130, 22, False, False)
Global kangleDelta:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 550, 150, 20, False, False)

Global kVxLabel:HiLabel = HiCreateLabel(kMyWindow, "VX", 10, 580, 130, 22, False, False)
Global kvx:HiTextbox = HiCreateTextbox(kMyWindow, TextLeft, 580, 150, 20, False, False)


Global kDatei:HiTextbox = HiCreateTextbox(kMyWindow, 10, 640, 140+Textleft, 20, False, False)
kDatei.HiSetline(0,"partikelIni/test.ini")
Global kButtonLoad:HiButton = HiCreateButton (kMyWindow, "load", 10, 670, 140+Textleft, 22)
Global kButtonSave:HiButton = HiCreateButton (kMyWindow, "save", 10, 700, 140+TextLeft, 22)
Global kButtonPlay:HiButton = HiCreateButton (kMyWindow, "play", 10, 610, 140+TextLeft, 22)



'Partikel einladen
'global ex:TCustomEmitter=TCustomEmitter.createFromFile("partikelIni/test.ini",500,350)
Global ex:TCustomEmitter
Global start:Int=0
Global Geladen:Int = 0
Global MaxLife:Int
'----------------------------




Function LoadEmitter(datei:String)
	If datei <> "" Then 
		Local file:TStream = ReadFile(datei)
		If Not file Then
			HiMsgBox("Datei konnte nicht geöffnet werden.", "Fehler", HIMESSAGETYPE_OK, HIMESSAGEICON_WARNING)
		Else
'			ex = null
			ex=TCustomEmitter.createFromFile(datei,200,200)
			MaxLife = ex.lifetime
			start = 1
			Geladen = 1
			GetDataFromEmitter()
		End If
	Else
		HiMsgBox("Bitte geben Sie einen Dateinamen an", "Fehler", HIMESSAGETYPE_OK, HIMESSAGEICON_WARNING)
	End If
End Function


Function SaveEmitter(datei:String)
	'todo auf return auf -1 testen
	SetDataToEmitter()
	
'	debugstop
	INI_Setvalue(datei, "createpool", ex.pPool)
	INI_Setvalue(datei, "image", ex.imagepath)
	INI_Setvalue(datei, "emitcount", ex.emitCount) 
	INI_Setvalue(datei, "updateinterval", ex.pupdateInterval)
	INI_Setvalue(datei, "alpha", ex.pAlpha)
	INI_Setvalue(datei, "alphadelta", ex.pAlphaDelta)
	INI_Setvalue(datei, "blend", ex.pBlend)
	INI_Setvalue(datei, "scale", ex.pScale)
	INI_Setvalue(datei, "scaledelta", ex.pScaleDelta)
	INI_Setvalue(datei, "r", ex.pR)
	INI_Setvalue(datei, "g", ex.pG)
	INI_Setvalue(datei, "b", ex.pB) 
	INI_Setvalue(datei, "emitinterval", ex.emitInterval)
	INI_Setvalue(datei, "particlevel", ex.particleVel)
	INI_Setvalue(datei, "lifetime", ex.lifetime)
	INI_Setvalue(datei, "startangle", ex.startAngle)
	INI_Setvalue(datei, "endangle", ex.endAngle)
	INI_Setvalue(datei, "currangle", ex.currAngle)
	INI_Setvalue(datei, "angledelta", ex.angleDelta)
	INI_Setvalue(datei, "vx", ex.pVx)

	HiMsgBox("Emitter erfolgreich gespeichert.", "Gespeichert", HIMESSAGETYPE_OK, HIMESSAGEICON_WARNING)		
	
	Rem 
	
		HiMsgBox("Datei konnte nicht geschrieben werden", "Fehler", HIMESSAGETYPE_OK, HIMESSAGEICON_WARNING)
	else
		HiMsgBox("Emitter erfolgreich gespeichert.", "Gespeichert", HIMESSAGETYPE_OK, HIMESSAGEICON_WARNING)	
	end if
	end rem 
	 
End Function


Function GetDataFromEmitter()
	kImage.HiSetline(0,ex.imagepath)
	kupdateInterval.HiSetline(0,ex.pupdateinterval)
	kalpha.HiSetline(0,ex.pAlpha)	
	kalphaDelta.HiSetline(0,ex.pAlphaDelta)
	kBlend.hisetline(0,ex.pBlend)
	kscale.HiSetline(0,ex.pScale)
	kscaleDelta.HiSetline(0,ex.pScaleDelta)
	krot.HiSetline(0,ex.pR)
	kgrun.HiSetline(0,ex.pG)
	kblau.HiSetline(0,ex.pB)
	kEmitInterval.HiSetline(0,ex.emitInterval)
	kparticleVel.hisetline(0,ex.particleVel)
	kemitCount.hisetline(0,ex.emitCount)
	klifetime.HiSetline(0,ex.lifetime)
	kstartangle.HiSetline(0,ex.startAngle)
	kendangle.hisetline(0,ex.endAngle)
	kcurrangle.HiSetline(0,ex.currAngle)
	kangleDelta.HiSetline(0,ex.angleDelta)
	kcreatePool.hisetline(0,ex.pPool)	
	kvx.hisetline(0,ex.pVx)
End Function

	
Function SetDataToEmitter()
	ex.imagepath = kImage.HiGetLine(0)
	ex.pupdateInterval = Float(kupdateInterval.HiGetLine(0))
	ex.pAlpha = Float(kalpha.higetline(0))
	ex.pAlphaDelta =Float(kalphaDelta.HiGetLine(0))
	ex.pBlend = Float(kBlend.higetline(0))
	ex.pScale = Float(kscale.higetline(0))
	ex.pScaleDelta = Float(kscaleDelta.HiGetLine(0))
	ex.pR = Float(krot.higetline(0))
	ex.pG = Float(kgrun.HiGetLine(0))
	ex.pB = Float(kblau.higetline(0))
	ex.emitInterval = Float(kEmitInterval.HiGetLine(0))
	ex.particleVel = Float(kparticleVel.HiGetLine(0))
	ex.emitCount = Float(kemitCount.HiGetLine(0))
	ex.lifetime	= Float(klifetime.HiGetLine(0))
	ex.startAngle = Float(kstartangle.HiGetLine(0))
	ex.endangle =Float( kendangle.higetline(0))
	ex.currAngle = Float(kcurrangle.HiGetLine(0))
	ex.angledelta = Float(kangleDelta.higetline(0))			
	ex.ppool = Float(kcreatePool.HiGetLine(0))
	ex.CreatePool(Float(kcreatePool.HiGetLine(0)))
End Function


Function PlayEmitter()
	If Geladen = 1 Then
		SetDataToEmitter()
		start = 1
	End If
End Function



Function updateEmitter()
	Rem 
	if keydown(KEY_SPACE) then 
		ex=TCustomEmitter.createFromFile("partikelIni/test.ini",500,350)
		start = 1
	end if
	End Rem 
		
	If Geladen = 1 Then
		If ex.lifetime > 0 Or ex.lifetime < -4 Then
			If start = 1 Then
				ex.Emit(MilliSecs())
				ex.Update(MilliSecs())
				ex.Draw()
				ex.Deactivate()
				If ex.lifetime > -1 Then
					ex.lifetime = ex.lifetime - 1
				End If
			End If
		Else
			start = 0
		End If
	End If
End Function


'SetClsColor 255,255,255

'Main-Loop
While Not KeyDown(KEY_ESCAPE)
	Cls()
	
	HiUpdateGUI()
	HiRenderGUI()
	HiDrawMouse()
		
	If kButtonLoad.HiClicked() Then LoadEmitter(kDatei.HiGetLine(0))
	If kButtonSave.HiClicked() Then SaveEmitter(kDatei.HiGetLine(0))
	If kButtonPlay.HiClicked() Then PlayEmitter()
	If KeyDown(KEY_SPACE) Then PlayEmitter()

	updateEmitter()	
	Flip()
Wend

EndGraphics()
End

