Import "HighGUI.bmx" ' Import The HighGUI code
SeedRnd(MilliSecs())
bDebugData = 1

' Setup graphics
Graphics(1024, 768, 16, 70) 
SetMaskColor(255, 0, 255)
HideMouse()
HiLoadGUI("GUI Gfx\Themes\512") ' Load the GUI

'Font
Global kGUIFont:TImageFont = LoadImageFont("ARIALN.TTF", 14)
SetBlend ALPHABLEND
SetImageFont kGUIFont

'Globals
Global kMyWindow:HiWindow = HiCreateWindow("HighGUI Test", 0, 0, GraphicsWidth(), GraphicsHeight(), True, False, True, True, False, HIWINDOWFRAMESTYLE_NONE)
Global kMyWindow2:HiWindow = HiCreateWindow("Window 2", 220, 0, 800, 700)
Global kMyWindow3:HiWindow = HiCreateWindow("Window 3", 220, 0, 450, 420)

Global kMyWindow5:HiWindow = HiCreateWindow("Active Control Details", 300, 0, 300, 125)
Global kMyWindow4:HiWindow = HiCreateWindow("Window 4", 300, 0, 200, 200)

Global kMyMenubar:HiMenuBar = kMyWindow.HiCreateMenubar()
Global kTitle1:HiMenuTitle = kMyMenubar.HiCreateTitle("File")
Global kItem1:HiMenuItem = kMyMenubar.HiCreateItem(kTitle1, "New")
Global kItem2:HiMenuItem = kMyMenubar.HiCreateItem(kTitle1, "Load")
kMyMenubar.HiCreateDash(kTitle1)
Global kItem3:HiMenuItem = kMyMenubar.HiCreateItem(kTitle1, "Exit")
Global kTitle2:HiMenuTitle = kMyMenubar.HiCreateTitle("Edit")
Global kItem4:HiMenuItem = kMyMenubar.HiCreateItem(kTitle2, "Cut", True, False, "Gfx/Cut.bmp")
Global kItem5:HiMenuItem = kMyMenubar.HiCreateItem(kTitle2, "Copy", True, False, "Gfx/Copy.bmp")
Global kItem6:HiMenuItem = kMyMenubar.HiCreateItem(kTitle2, "Paste", True, False, "Gfx/Paste.bmp")
kMyMenubar.HiCreateDash(kTitle2)
Global kItem9:HiMenuItem = kMyMenubar.HiCreateItem(kTitle2, "Undo", True, False, "Gfx/Undo.bmp")
Global kItem10:HiMenuItem = kMyMenubar.HiCreateItem(kTitle2, "Redo", True, False, "Gfx/Redo.bmp")
'kMyMenubar.HiCreateItem("Hello 2", kTitle1)

Global kMyHScrollbar:HiHScrollbar = HiCreateHScrollbar(kMyWindow, 10, 30, 200, 5)
Global kMyListbox:HiListbox = HiCreateListbox(kMyWindow, 10, 60, 200, 300)
For iCount = 1 To 30
	kMyListbox.HiAddItem("This is list item number " + iCount)
Next
Global kMyCombobox:HiCombobox = HiCreateCombobox(kMyWindow, 250, 60, 200)
For iCount = 1 To 30
	kMyCombobox.HiAddItem("This is list item number " + iCount)
Next

Global kMyTextbox:HiTextbox = HiCreateTextbox(kMyWindow3, 10, 10, 100, 44, False, True)
Global kMyPicturebox:HiPicturebox = HiCreatePicturebox(kMyWindow3, 10, 60, 320 + ImageWidth(kPicturebox_Image), 240 + ImageHeight(kPicturebox_Image))
Global kMyCheckbox:HiCheckbox = HiCreateCheckbox(kMyWindow3, "Checkable", 10, 310)
Global kMyCheckbox2:HiCheckbox = HiCreateCheckbox(kMyWindow3, "Disabled (Unchecked)", 10, 310 + (24 * 1))
kMyCheckbox2.m_bDisabled = True
Global kMyCheckbox3:HiCheckbox = HiCreateCheckbox(kMyWindow3, "Disabled (Checked)", 10, 310 + (24 * 2))
kMyCheckbox3.m_bDisabled = True
kMyCheckbox3.HiSetValue(1)

Global kMyOptionbox:HiOptionbox = HiCreateOptionbox(kMyWindow3, "Optionbox", 200, 310)
Global kMyOptionbox1:HiOptionbox = HiCreateOptionbox(kMyWindow3, "Disabled (Unchecked)", 200, 310 + (24 * 1))
kMyOptionbox1.m_bDisabled = True
Global kMyOptionbox2:HiOptionbox = HiCreateOptionbox(kMyWindow3, "Disabled (Checked)", 200, 310 + (24 * 2))
kMyOptionbox2.m_bDisabled = True
kMyOptionbox2.HiSetValue(1)

Global kMyVScrollbar:HiVScrollbar = HiCreateVScrollbar(kMyPicturebox, 0, 0, 200, 5)

Global kActiveControlX:HiLabel = HiCreateLabel(kMyWindow5, "Active Object X = ", 5, 0 + (24 * 0), 130, 22, False, False)
Global kActiveControlY:HiLabel = HiCreateLabel(kMyWindow5, "Active Object X = ", 5, 0 + (24 * 1), 130, 22, False, False)
Global kActiveControlWidth:HiLabel = HiCreateLabel(kMyWindow5, "Active Object Width = ", 5, 0 + (24 * 2), 130, 22, False, False)
Global kActiveControlHeight:HiLabel = HiCreateLabel(kMyWindow5, "Active Object Height = ", 5, 0 + (24 * 3), 130, 22, False, False)

Global kMyTabGroup1:HiTabGroup = HiCreateTabGroup(kMyWindow2, 2, 2, 300, 300)
For k = 1 To 4
	HiCreateProgressbar(kMyTabGroup1.HiAddPage("Page " + k), 2, 2, 200)
Next

Global kPage4:HiTabPage = kMyTabGroup1.HiAddPage("Page with frame + Buttons")
Global kMyFrame:HiFrame = HiCreateFrame(kPage4, "Buttons", 0, 0, 130, 135)
Global kMyButton1:HiButton = HiCreateButton(kMyFrame, "Normal Button", 5, 0 + (24 * 0), 110, 22)
Global kMyButton2:HiButton = HiCreateButton(kMyFrame, "Toggle Button", 5, 0 + (24 * 1), 110, 22, HIBUTTONSTYLE_TOGGLE)
Global kMyButton3:HiButton = HiCreateButton(kMyFrame, "Popup Button", 5, 0 + (24 * 2), 110, 22, HIBUTTONSTYLE_POPUP)
Global kMyButton4:HiButton = HiCreateButton(kMyFrame, "Disabled Button", 5, 0 + (24 * 3), 110, 22)
kMyButton4.m_bDisabled = True
Global kMySpinner:HiSpinner = HiCreateSpinner(kMyWindow4, 10, 10, 100, 10, 0, 1)

For k = 6 To 12
	kMyTabGroup1.HiAddPage("Page " + k)
Next

' Images
Global kBackImage:TImage = LoadImage("Gfx/backdrop.png")
Global kSmileImage:TImage = LoadImage("Gfx/Smile.bmp")
MidHandleImage kSmileImage









' The main loop
While Not KeyDown(KEY_ESCAPE)
	
	Cls()

	HiUpdateGUI()
	' Custom code here

	If kControllist.Contains(kMyPicturebox) Then
		kMyPicturebox.HiDrawImage(kBackImage, 0, 0)
		If kMyPicturebox.HiMouseOver() Then kMyPicturebox.HiDrawImage(kSmileImage, kMyPicturebox.HiMouseOverX(), kMyPicturebox.HiMouseOverY())
	EndIf
	
	If kMyButton2.m_iValue = 1 Then 
		kMyWindow4.HiSetAlpha(.5)
	Else
		kMyWindow4.HiSetAlpha(1)
	EndIf
	
	If kMyButton1.HiClicked() Then HiMsgBox("Button 1 was clicked!!!", "HighGUI Test App", HIMESSAGETYPE_YESNOCANCEL, HIMESSAGEICON_WARNING)
	
	If kActiveObject <> Null Then
		kMyWindow5.m_sCaption = "Active window controls [" + HiGetActiveObjectType() + "]"
		kActiveControlX.m_sText = "Active Object X = " + kMyTabGroup1.m_bUpdateChildren'kActiveObject.m_iX
		kActiveControlY.m_sText = "Active Object Y = " + kActiveObject.m_iY
		kActiveControlWidth.m_sText = "Active Object Width = " + kActiveObject.m_iWidth
		kActiveControlHeight.m_sText = "Active Object Height = " + kActiveObject.m_iHeight
	EndIf
	
	If kItem3.HiClicked() Then End	
	
	
	HiRenderGUI()
	HiDrawMouse()
	
	' Render some envi details
	SetColor Abs((Cos(MilliSecs() / 10)) * 255), Abs((Sin(MilliSecs() / 10)) * 255), Abs((Sin(MilliSecs() / 10)) * 255)
	DrawText "MemAlloced: " + MemAlloced() + "       FPS: " + Int(fp#), 10, GraphicsHeight() - 20
	
	Flip()
	
	FlushMem()
	
	' = * FPS Counter Ripped From 'GLBlurr' Sample * =
	' Work out FPS
	fps=fps+1
	If fps_t<MilliSecs()
		fp=fps
		fps2=fps
		fps_t=1000+MilliSecs()
		fps=0
	EndIf
	
Wend

EndGraphics()
End



