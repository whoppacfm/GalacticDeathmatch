AppTitle = "Arena Editor 0.1"
'SetGraphicsDriver (GLMax2DDriver())

Graphics 1024, 768, 60

include "TArena.bmx"
include "TBackground.bmx"


global arena1:TLevel
arena1 = TLevel.createFromFile("arena2.map")
'arena1 = TLevel.createFromFile("test.map")


LoadSkin("skin")
SetSmallFont("skin/fonts/arial.ttf",10)
SetStdFont("skin/fonts/arial.ttf",12)
SetGuruFont("skin/fonts/VTSR____.TTF",16)
SetBackgroundPicture("skin/screen/bg.png")

type TArenaWindow Extends TG_WND
	field testback:TImage
	field sternchen:TSterne

	Method New()
		testback = loadimage("images/weltall1.png")
		sternchen:TSterne = TSterne.create(1000)
		
		Caption = "Arena"
		AllowResizing(True)

		ScrollH.Visible = True
		ScrollV.Visible = True
		ScrollH.Size = 10000
		ScrollV.Size = 1000

		w = 400	
		h = 300
		MinW = 256
		MinH = 256
		
		X = 100
		Y = 100
	end method

	Method RenderContent()
		
		tileimage testback, -scrollh.pos, -scrollv.pos
		sternchen.draw(scrollh.pos, scrollv.pos)	
		arena1.drawU(scrollh.pos, scrollv.pos)
		arena1.drawg(scrollh.pos, scrollv.pos)
		arena1.drawo(scrollh.pos, scrollv.pos)
		
	End Method
	
end type








type TEditWindow Extends TG_WND
	Field Button_01:TG_Btn
	Field Animated:TG_Checkbox
	Field AnimDelay:TG_Edit

	Method New()
	
		Caption = "Edit"
		AllowResizing(True)
		' Show Scrollbars of the window
		ScrollH.Visible = True
		ScrollV.Visible = True
		' Size of the window content in pixel
		ScrollH.Size = 100
		ScrollV.Size = 100
		' Set window size and position
		w = 400
		h = 300
		
		MinW = 256
		MinH = 256
		
		X = 600
		Y = 100
		
		' Create Button
		
		Button_01 = New TG_Btn
		
		Button_01.x = 50
		Button_01.y = 50
		Button_01.Caption = "New Button!"
		Button_01.w = 140
		
		' Add Button to the window
		
		AddChild(Button_01)		

		' Add some more objects...

		Animated = New TG_Checkbox
		Animated.x=50
		Animated.y=70
		AddChild (Animated)
		
		AnimDelay = New TG_Edit
		AnimDelay.x = 50
		AnimDelay.y = 90
		AnimDelay.w = 140
		AddChild(AnimDelay)

	End Method

	'
	' You have to overwrite the abstract method RenderContent
	'
	' You can render graphic options to the window and/or you
	' can check if child-objects of the window are pressed
	'

	Method RenderContent()
	
		If Button_01.IsHit Then TG_CreateGuruMessage("You have pressed the button!")
	
	End Method
end type







Type TNewWindow Extends TG_WND
	Field Button_01:TG_Btn
	Field Animated:TG_Checkbox
	Field AnimDelay:TG_Edit

	Method New()
	
		Caption = "New Window"
		AllowResizing(True)
		' Show Scrollbars of the window
		ScrollH.Visible = True
		ScrollV.Visible = True
		' Size of the window content in pixel
		ScrollH.Size = 600
		ScrollV.Size = 250
		' Set window size and position
		w = 400
		h = 300
		
		MinW = 256
		MinH = 256
		
		X = 100
		Y = 100
		
		' Create Button
		
		Button_01 = New TG_Btn
		
		Button_01.x = 50
		Button_01.y = 50
		Button_01.Caption = "New Button!"
		Button_01.w = 140
		
		' Add Button to the window
		
		AddChild(Button_01)		

		' Add some more objects...

		Animated = New TG_Checkbox
		Animated.x=50
		Animated.y=70
		AddChild (Animated)
		
		AnimDelay = New TG_Edit
		AnimDelay.x = 50
		AnimDelay.y = 90
		AnimDelay.w = 140
		AddChild(AnimDelay)

	End Method

	'
	' You have to overwrite the abstract method RenderContent
	'
	' You can render graphic options to the window and/or you
	' can check if child-objects of the window are pressed
	'

	Method RenderContent()
	
		If Button_01.IsHit Then TG_CreateGuruMessage("You have pressed the button!")
	
	End Method
End Type




Type TOtherWindow Extends TG_Wnd
	Method New()
		X = 40
		Y = 40
		Caption = "Other Window"
	End Method
	
	Method RenderContent()
		
		'
		' Draw some content
		'
		
		SetColor 255,0,0
		DrawRect 0,0,500,500
		SetColor 255,255,255
		DrawLine 20,20,80,80
		DrawRect 30,30,20,20
		SetColor 0,0,0
		DrawText "Here are some graphics",10,10
		DrawText "inside the window",10,30
	End Method
End Type
'
' Now you can create an object from your
' delievered class
'

'Global MyWindow:TNewWindow = New TNewWindow
'Global OtherWindow:TOtherWindow = New TOtherWindow

Global ArenaWindow:TArenaWindow = New TArenaWindow
Global EditWindow:TEditWindow = New TEditWindow



While Not KeyDown(KEY_ESCAPE)

	Cls
	
	Mouse.Refresh()
	Skin.DrawBackground()
	
	GraphicReset()
	TG_Wnd.RenderAllWindows()
	
	Skin.Refresh()

	FlushMem()
	Flip	
	
Wend

